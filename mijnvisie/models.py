from typing import List

from pydantic import EmailStr
from pydantic import BaseModel
from pydantic_extra_types.pendulum_dt import DateTime

from enum import Enum


class UserType(str, Enum):
    admin = "admin"
    ambassador = "ambassador"
    user = "user"

# Shared properties
class UserBase(BaseModel):
    email: str
    first_name: str
    last_name: str
    user_type: UserType = UserType.user
    is_active: bool = True

    @property
    def is_superuser(self):
        return self.user_type == UserType.admin


# Properties to receive via API on creation
class UserCreate(UserBase):
    password: str


class UserRegister(BaseModel):
    email: str
    first_name: str
    last_name: str
    password: str


# Properties to receive via API on update, all are optional
class UserUpdate(UserBase):
    email: str | None
    password: str | None = None


class UserUpdateMe(BaseModel):
    first_name: str | None = None
    last_name: str | None = None
    email: EmailStr | None = None


class UpdatePassword(BaseModel):
    current_password: str
    new_password: str

class UserInDB(UserBase):
    hashed_password: str

class User(UserInDB):
    id: str

# Generic message
class Message(BaseModel):
    message: str


# JSON payload containing access token
class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"


# Contents of JWT token
class TokenPayload(BaseModel):
    sub: str | None = None


class NewPassword(BaseModel):
    token: str
    new_password: str


### QUESTIONS ###

class QuestionType(str, Enum):
    mc = "mc"
    open = "open"

class QuestionBase(BaseModel):
    type: QuestionType
    title: str
    description: str | None = None
    options: List[str] | None = None

# Properties to receive via API on creation
class QuestionCreate(QuestionBase):
    pass

class QuestionUpdate(BaseModel):
    type: QuestionType | None = None
    title: str | None = None
    description: str | None = None
    options: List[str] | None = None
    new_version: bool = False

class QuestionInDB(QuestionBase):
    previous_version: str | None = None
    created: DateTime

class Question(QuestionInDB):
    id: str

class AnswerBase(BaseModel):
    user_id: str
    question_id: str
    answer: str | int

class AnswerCreate(BaseModel):
    question_id: str
    answer: str | int

class AnswerInDB(AnswerBase):
    created: DateTime

class Answer(AnswerInDB):
    id: str