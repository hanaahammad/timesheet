import mysql.connector
import streamlit as st

def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",      # change
        password="HH@mysql",  # change
        database="timesheet_app"
    )

def fetch_one(query, params=None):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(query, params or ())
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result

def fetch_all(query, params=None):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(query, params or ())
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

def execute(query, params=None):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params or ())
    conn.commit()
    cursor.close()
    conn.close()

print("Functions in db.py loaded:", dir())
