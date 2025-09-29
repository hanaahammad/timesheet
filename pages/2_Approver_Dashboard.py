import streamlit as st
from db import fetch_all, execute

from utils import require_login
user = require_login()

if "user_id" not in st.session_state:
    st.error("Please login first.")
    st.stop()

if st.session_state["role"] != "approver":
    st.warning("This page is only for approvers.")
    st.stop()

st.title("Approver Dashboard – Review Timesheets")

# Fetch timesheets for projects this approver manages
timesheets = fetch_all("""
    SELECT DISTINCT t.timesheet_id, t.user_id, t.week_start, t.status,
           u.first_name, u.last_name, u.organization
    FROM timesheets t
    JOIN timesheet_entries te ON t.timesheet_id = te.timesheet_id
    JOIN projects p ON te.project_id = p.project_id
    JOIN project_approvers pa ON p.project_id = pa.project_id
    JOIN users u ON t.user_id = u.user_id
    WHERE pa.user_id = %s AND t.status='submitted'
    ORDER BY t.week_start DESC
""", (st.session_state["user_id"],))

if not timesheets:
    st.info("No pending timesheets for your projects.")
else:
    for t in timesheets:
        st.subheader(f"Timesheet #{t['timesheet_id']} – {t['first_name']} {t['last_name']} ({t['organization']}) – Week of {t['week_start']}")

        entries = fetch_all("""
            SELECT te.entry_date, te.hours_worked, te.activity, p.project_name
            FROM timesheet_entries te
            JOIN projects p ON te.project_id = p.project_id
            WHERE te.timesheet_id=%s
            ORDER BY te.entry_date
        """, (t["timesheet_id"],))

        for e in entries:
            st.write(f"{e['entry_date']} – {e['hours_worked']}h – {e['activity']} – {e['project_name']}")

        col1, col2 = st.columns(2)
        with col1:
            if st.button(f"Approve {t['timesheet_id']}"):
                execute("""
                    UPDATE timesheets
                    SET status='approved', approver_id=%s, approved_at=NOW()
                    WHERE timesheet_id=%s
                """, (st.session_state["user_id"], t["timesheet_id"]))
                st.success("Approved!")
                st.rerun()
        with col2:
            if st.button(f"Reject {t['timesheet_id']}"):
                execute("""
                    UPDATE timesheets
                    SET status='rejected', approver_id=%s, approved_at=NOW()
                    WHERE timesheet_id=%s
                """, (st.session_state["user_id"], t["timesheet_id"]))
                st.error("Rejected!")
                st.rerun()
