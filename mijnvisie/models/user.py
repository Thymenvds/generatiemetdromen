from pydantic import BaseModel
from enum import Enum

class UserType(str, Enum):
    admin = "admin"
    ambassador = "ambassador"
    user = "user"

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: str | None = None

class User(BaseModel):
    username: str
    user_type: UserType = UserType.user
    email: str | None = None
    full_name: str | None = None
    disabled: bool | None = None

class UserInDB(User):
    hashed_password: str

class UserNew(User):
    password: str