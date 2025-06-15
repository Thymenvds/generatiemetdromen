from fastapi import APIRouter

from mijnvisie.api.routes import login, users, questions, answers

api_router = APIRouter()
api_router.include_router(login.router)
api_router.include_router(users.router)
api_router.include_router(questions.router)
api_router.include_router(answers.router)