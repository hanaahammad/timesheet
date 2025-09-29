import streamlit as st

def require_login():
    if "user" not in st.session_state or st.session_state["user"] is None:
        st.error("Please login first.")
        st.stop()
    return st.session_state["user"]
