import bcrypt
from db import fetch_one

def login(email, password):
    row = fetch_one(
        "SELECT user_id, first_name, last_name, email, password_hash, role "
        "FROM users WHERE email = %s", 
        (email,)
    )
    if row:
        stored_hash = row["password_hash"].encode("utf-8")  # ensure bytes
        if bcrypt.checkpw(password.encode("utf-8"), stored_hash):
            return row
    return None
