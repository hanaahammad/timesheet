# test_imports.py
print("Starting import test...")

try:
    import auth
    print("✅ auth.py imported")
except Exception as e:
    print("❌ auth.py import failed:", e)

try:
    import db
    print("✅ db.py imported")
except Exception as e:
    print("❌ db.py import failed:", e)

from auth import login
from db import fetch_one

print("✅ Specific functions imported successfully")

print("All imports seem OK 🚀")
