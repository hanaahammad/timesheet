import streamlit as st
from db import execute, fetch_all

from utils import require_login
user = require_login()

if "user_id" not in st.session_state:
    st.error("Please login first.")
    st.stop()

if st.session_state["role"] != "user":
    st.warning("This page is only for users.")
    st.stop()

st.title("User Dashboard – Submit Timesheet")

# Step 1: Create or select weekly timesheet
week_start = st.date_input("Week Starting")

ts = fetch_all(
    "SELECT * FROM timesheets WHERE user_id=%s AND week_start=%s",
    (st.session_state["user_id"], week_start)
)
if ts:
    timesheet_id = ts[0]["timesheet_id"]
else:
    execute("""
        INSERT INTO timesheets (user_id, week_start, status, submitted_at)
        VALUES (%s, %s, 'draft', NOW())
    """, (st.session_state["user_id"], week_start))
    ts = fetch_all(
        "SELECT * FROM timesheets WHERE user_id=%s AND week_start=%s",
        (st.session_state["user_id"], week_start)
    )
    timesheet_id = ts[0]["timesheet_id"]

st.write(f"Working on Timesheet #{timesheet_id}")

# Step 2: Add a daily entry
projects = fetch_all("SELECT project_id, project_name FROM projects WHERE status='active'")
project_options = {p["project_name"]: p["project_id"] for p in projects}

with st.form("entry_form", clear_on_submit=True):
    entry_date = st.date_input("Date")
    #hours = st.number_input("Hours Worked", 0.0, 24.0, step=0.5)
    hours = st.number_input("Hours Worked", min_value=0, max_value=24, step=1)

    activity = st.text_input("Activity")
    project_name = st.selectbox("Project", list(project_options.keys()))
    submitted = st.form_submit_button("Add Entry")
    if submitted:
        project_id = project_options[project_name]
        execute("""
            INSERT INTO timesheet_entries (timesheet_id, entry_date, hours_worked, activity, project_id)
            VALUES (%s, %s, %s, %s, %s)
        """, (timesheet_id, entry_date, hours, activity, project_id))
        st.success("Entry added!")

# Step 3: Show entries
entries = fetch_all("""
    SELECT te.entry_date, te.hours_worked, te.activity, p.project_name
    FROM timesheet_entries te
    JOIN projects p ON te.project_id = p.project_id
    WHERE te.timesheet_id=%s
    ORDER BY te.entry_date
""", (timesheet_id,))

st.subheader("Your Entries This Week")
for e in entries:
    st.write(f"{e['entry_date']} – {e['hours_worked']}h – {e['activity']} – {e['project_name']}")

# Step 4: Submit weekly timesheet
if st.button("Submit Timesheet for Approval"):
    execute("UPDATE timesheets SET status='submitted', submitted_at=NOW() WHERE timesheet_id=%s", (timesheet_id,))
    st.success("Timesheet submitted!")
