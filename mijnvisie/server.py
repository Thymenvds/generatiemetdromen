from typing import Union, List

# for API
from fastapi import FastAPI
from pydantic import BaseModel

# for DB
from pysondb import PysonDB

## MODELS ##
class Question(BaseModel):
    name: str
    title: str = None
    options: List[str]

class Answer(BaseModel):
    user_id: str
    question_id: str
    option: int

users = PysonDB("db/users.json")
questions = PysonDB("db/questions.json")
answers = PysonDB("db/answers.json")

app = FastAPI()

@app.get("/user/")
def read_user(name: str = None):
    if name is None:
        return users.get_all()
    return users.getBy({"name":name})

@app.put("/user/{name}")
def add_user(name: str):
    users.add({"name": name})

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
