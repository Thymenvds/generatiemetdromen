from typing import Any
from datetime import datetime

from fastapi import APIRouter, HTTPException, Depends
from fastapi.encoders import jsonable_encoder

from mijnvisie.api.deps import CurrentUser, AnswerSessionDep, get_current_active_superuser
# from api.deps import CurrentUser, AnswerSessionDep, get_current_active_superuser
from mijnvisie.models import Answer, AnswerCreate, AnswerInDB, Message
# from models import Answer, AnswerCreate, AnswerInDB, Message


from pysondb.errors import IdDoesNotExistError

router = APIRouter(prefix="/answers", tags=["answers"])


@router.get("/")
def read_answer(
    session: AnswerSessionDep, current_user: CurrentUser) -> Any:
    """
    Retrieve Answers.
    """
    if current_user.is_superuser:
        return session.get_all()
    return session.get_by_query(lambda data: data["user_id"] == current_user.id)


@router.get("/{id}", response_model=Answer)
def read_answer(session: AnswerSessionDep, current_user: CurrentUser, id: str) -> Any:
    """
    Get answer by ID.
    """
    try:
        answer = session.get_by_id(id)
        answer = Answer(**answer, id=id)
    except (IdDoesNotExistError):
        raise HTTPException(status_code=404, detail="Answer not found")
    if current_user.is_superuser or current_user.id == answer.user_id:
        return Answer(**answer, id=id)
    else:
        raise HTTPException(status_code=404, detail="Answer not found")


@router.post("/", response_model=Answer)
def create_answer(
    *, session: AnswerSessionDep, current_user: CurrentUser, answer_in: AnswerCreate
) -> Any:
    """
    Create new Answer.
    """
    answer = AnswerInDB.model_validate(
        AnswerInDB(**answer_in.model_dump(), created=datetime.now(), user_id=current_user.id)
    )
    id = session.add(jsonable_encoder(answer))
    return Answer(**answer.model_dump(), id=id)

@router.delete("/{id}")
def delete_answer(
    session: AnswerSessionDep, current_user: CurrentUser, id: str
) -> Message:
    """
    Delete an Answer.
    """
    try:
        answer = AnswerInDB(**session.get_by_id(id))
        if not current_user.is_superuser and not current_user.id == answer.user_id:
            raise HTTPException(status_code=400, detail="Not enough permissions")
        session.delete_by_id(id)
    except (IdDoesNotExistError):
        raise HTTPException(status_code=404, detail="Answser not found")
    return Message(message="Answer deleted successfully")