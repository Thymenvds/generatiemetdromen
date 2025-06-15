from typing import Any
from datetime import datetime

from fastapi import APIRouter, HTTPException, Depends
from fastapi.encoders import jsonable_encoder

from mijnvisie.api.deps import CurrentUser, QuestionSessionDep, get_current_active_superuser
from mijnvisie.models import Question, QuestionCreate, QuestionUpdate, QuestionInDB, Message


from pysondb.errors import IdDoesNotExistError

router = APIRouter(prefix="/questions", tags=["questions"])


@router.get("/")
def read_questions(session: QuestionSessionDep) -> Any:
    """
    Retrieve Questions.
    """
    return session.get_all()


@router.get("/{id}", response_model=Question)
def read_question(session: QuestionSessionDep, current_user: CurrentUser, id: str) -> Any:
    """
    Get question by ID.
    """
    try:
        question = session.get_by_id(id)
    except (IdDoesNotExistError):
        raise HTTPException(status_code=404, detail="Question not found")
    return Question(**question, id=id)


@router.post("/", response_model=Question, dependencies=[Depends(get_current_active_superuser)])
def create_question(
    *, session: QuestionSessionDep, current_user: CurrentUser, question_in: QuestionCreate
) -> Any:
    """
    Create new question.
    """
    question = QuestionInDB.model_validate(
        QuestionInDB(**question_in.model_dump(), created=datetime.now())
    )
    id = session.add(jsonable_encoder(question))
    return Question(**question.model_dump(), id=id)


@router.put("/{id}", response_model=Question, dependencies=[Depends(get_current_active_superuser)])
def update_item(
    *,
    session: QuestionSessionDep,
    id: str,
    question_in: QuestionUpdate,
) -> Any:
    """
    Update an Question.
    """
    try:
        question = session.get_by_id(id)
    except (IdDoesNotExistError):
        raise HTTPException(status_code=404, detail="Question not found")

    if question_in.new_version: # create new with same fields
        new_id = session.add(jsonable_encoder(question))
        update_dict = question_in.model_dump(exclude_unset=True, exclude=["new_version"])
        update_dict["previous_version"] = id
        update_dict["created"] = datetime.now()
    else: # update old (this change is undetectable)
        update_dict = question_in.model_dump(exclude_unset=True, exclude=["new_version"])
        new_id = id
    question = session.update_by_id(id, jsonable_encoder(update_dict))
    return Question(**question, id=id)


@router.delete("/{id}", dependencies=[Depends(get_current_active_superuser)])
def delete_question(
    session: QuestionSessionDep, id: str
) -> Message:
    """
    Delete an Question.
    """
    try:
        session.delete_by_id(id)
    except (IdDoesNotExistError):
        raise HTTPException(status_code=404, detail="Question not found")
    return Message(message="Question deleted successfully")