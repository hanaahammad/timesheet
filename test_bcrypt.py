import bcrypt

hashed = b"$2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i"  # from DB
print(bcrypt.checkpw(b"secret123", hashed))
