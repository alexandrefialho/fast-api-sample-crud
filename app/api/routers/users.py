from fastapi import APIRouter

router = APIRouter()

@router.post("/api/users",
            summary="Return data of the created user",
            responses={
                201: {"description": "User created successfully"},
            },
            tags=["Users"])
async def create_user():
    return {"message": "User created successfully"}

@router.get("/api/users",
            summary="Return data from all users",
            responses={
                200: {"description": "Data from users"},
            },
            tags=["Users"])
async def get_data_from_all_users():
    return {"message": "data from all users"}


@router.get("/api/users/{user_id}",
            summary="Return data for a especific user",
            responses={
                200: {"description": "Data from user"},
            },
            tags=["Users"])
async def get_data_from(user_id: int):
    return {"message": f"data from user: {user_id}"}


@router.put("/api/users/{user_id}",
            summary="Update data of a especific user",
            responses={
                202: {"description": f"User updated"},
            },
            tags=["Users"])
async def update_user_from(user_id: int):
    return {"message": f"User Updated: {user_id}"}


@router.delete("/api/users/{user_id}",
               summary="Delete a especific user",
               responses={
                   202: {"description": f"User deleted"},
               },
               tags=["Users"])
async def delete_user_from(user_id: int):
    return {"message": f"User Deleted: {user_id}"}