
from fastapi import FastAPI
from fastapi.routing import APIRoute
from starlette.middleware.cors import CORSMiddleware

from mijnvisie.api.main import api_router


app = FastAPI()


app.include_router(api_router)