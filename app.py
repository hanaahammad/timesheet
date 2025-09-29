import streamlit as st
from auth import login

st.set_page_config(page_title="Timesheet App", layout="wide")
#st.sidebar.write(dict(st.session_state))

# Initialize session state
if "user" not in st.session_state:
    st.session_state["user"] = None

st.title("⏱ Timesheet Application")

# --- Login Screen ---
if st.session_state["user"] is None:
    st.subheader("Login")

    email = st.text_input("Email")
    password = st.text_input("Password", type="password")

    if st.button("Login"):
        user = login(email, password)
        if user:
            st.session_state["user"] = user
            st.session_state["user_id"] = user["user_id"]
            st.session_state["role"] = user["role"] 
            st.success(f"Welcome {user['first_name']}!")
            st.rerun()   # 👈 force app to reload with logged-in user
        else:
            st.error("Invalid email or password")

# --- Main App (after login) ---
else:
    user = st.session_state["user"]

    st.sidebar.title("Navigation")
    st.sidebar.write(f"👤 Logged in as: {user['first_name']} {user['last_name']} ({user['role']})")

    if st.sidebar.button("Logout"):
        st.session_state["user"] = None
        st.rerun()

    # Show different dashboards by role
    if user["role"] == "approver":
        st.header("✅ Approver Dashboard")
        st.write("Here you will review submitted timesheets.")
        # You can load approver pages here

    elif user["role"] == "user":
        st.header("📝 Timesheet Entry")
        st.write("Here you can submit your hours worked.")
        # You can load user pages here

    else:
        st.error("Unknown role. Please contact admin.")
