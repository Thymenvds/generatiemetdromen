from collections.abc import Generator
from typing import Annotated

import jwt
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jwt.exceptions import InvalidTokenError
from pydantic import ValidationError

from mijnvisie.core import security
from mijnvisie.models import TokenPayload, User

from pysondb import PysonDB
from pysondb.errors import IdDoesNotExistError

reusable_oauth2 = OAuth2PasswordBearer(
    tokenUrl=f"/login/access-token"
)


user_db = PysonDB("db/users.json")
question_db = PysonDB("db/questions.json")
def get_user_db():
    return user_db
def get_question_db():
    return question_db

UserSessionDep = Annotated[PysonDB, Depends(get_user_db)]
QuestionSessionDep = Annotated[PysonDB, Depends(get_question_db)]

TokenDep = Annotated[str, Depends(reusable_oauth2)]

def get_current_user(session: UserSessionDep, token: TokenDep) -> User:
    try:
        payload = jwt.decode(
            token, security.SECRET_KEY, algorithms=[security.ALGORITHM]
        )
        token_data = TokenPayload(**payload)
    except (InvalidTokenError, ValidationError):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
        )
    try:
        user_data = session.get_by_id(token_data.sub)
        user = User(**user_data, id=token_data.sub)
    except (IdDoesNotExistError):
        user = None
    
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    return user


CurrentUser = Annotated[User, Depends(get_current_user)]


def get_current_active_superuser(current_user: CurrentUser) -> User:
    if not current_user.is_superuser:
        raise HTTPException(
            status_code=403, detail="The user doesn't have enough privileges"
        )
    return current_user