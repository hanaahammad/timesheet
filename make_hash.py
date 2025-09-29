import bcrypt

import bcrypt

password = b"secret123"

hashed = bcrypt.hashpw(password, bcrypt.gensalt())
print("Hash for DB:", hashed.decode())

'''
passwords = {
    "john_doe": "password123",
    "manager_sara": "approve123"
}

for user, pwd in passwords.items():
    hashed = bcrypt.hashpw(pwd.encode(), bcrypt.gensalt()).decode()
    print(f"INSERT INTO users (username, password_hash, role, full_name, email) "
          f"VALUES ('{user}', '{hashed}', "
          f"{'\'user\'' if user=='john_doe' else '\'approver\''}, "
          f"'Test {user}', '{user}@example.com');")
'''