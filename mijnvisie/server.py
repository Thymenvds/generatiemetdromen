from datetime import datetime, timedelta, timezone
from typing import Union, List, Annotated

from enum import Enum


import jwt
from fastapi import Depends, FastAPI, HTTPException, status
from jwt.exceptions import InvalidTokenError
from pydantic import BaseModel

# for DB
from pysondb import PysonDB

## MODELS ##
class QuestionType(str, Enum):
    mc = "mc"
    open = "open"


class Question(BaseModel):
    name: str
    type: QuestionType
    title: str = None
    options: List[str] | None = None

class Answer(BaseModel):
    user_id: str
    question_id: str
    option: int





users = PysonDB("db/users.json")
questions = PysonDB("db/questions.json")
answers = PysonDB("db/answers.json")

app = FastAPI()


# to get a string like this run:
# openssl rand -hex 32

app = FastAPI()





@app.get("/question/")
def read_question(id: str = None):
    if id is None:
        print(questions.get_all())
        return questions.get_all()
    return questions.get_by_id(id)

@app.post("/question/")
def add_question(id: str = None, question: Question = None):
    if id is None: #add new question
        questions.add(question.model_dump())
    else:
        return 400
    
@app.get("/answer/")
def get_answer(user_id: str = None, question_id: str = None):
    def query(data):
        if user_id is not None:
            if data["user_id"] != user_id:
                return False
        if question_id is not None:
            if data["question_id"] != question_id:
                return False
        return True
    return answers.get_by_query(query)

@app.post("/answer/")
def add_answer(answer: Answer):
    answers.add(answer.model_dump())
