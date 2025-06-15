import uuid
from typing import Any

from pysondb import PysonDB

from mijnvisie.core.security import get_password_hash, verify_password
from mijnvisie.models import User, UserCreate, UserUpdate, UserInDB


def create_user(*, session: PysonDB, user_create: UserCreate) -> User:
    db_obj = UserInDB.model_validate(
        UserInDB(**user_create.model_dump(), hashed_password=get_password_hash(user_create.password))
    )
    id = session.add(db_obj.model_dump())
    user = User.model_validate(
        User(**db_obj.model_dump(), id=id)
    )
    return user


# def update_user(*, session: PysonDB, db_user: User, user_in: UserUpdate) -> Any:
#     user_data = user_in.model_dump(exclude_unset=True)
#     extra_data = {}
#     if "password" in user_data:
#         password = user_data["password"]
#         hashed_password = get_password_hash(password)
#         extra_data["hashed_password"] = hashed_password
#     db_user.sqlmodel_update(user_data, update=extra_data)
#     session.add(db_user)
#     session.commit()
#     session.refresh(db_user)
#     return db_user


def get_user_by_email(*, session: PysonDB, email: str) -> User | None:
    query_result = session.get_by_query(lambda data: data["email"]==email)
    if len(query_result) == 0:
        return None
    id, user = query_result.popitem()
    return User(**user, id=id)


def authenticate(*, session: PysonDB, email: str, password: str) -> User | None:
    db_user = get_user_by_email(session=session, email=email)
    if not db_user:
        return None
    if not verify_password(password, db_user.hashed_password):
        return None
    return db_user
