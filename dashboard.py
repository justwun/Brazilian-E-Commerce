import streamlit as st
import pymysql
import pandas as pd
import matplotlib.pyplot as plt

def get_connection():
    return pymysql.connect(
        host="127.0.0.1",  
        user="root",  
        password="******",  
        database="olist_db"  
    )

def get_data(query):
    conn = get_connection()
    df = pd.read_sql(query, conn)
    conn.close()
    return df


st.title("📊 Olist Sales Dashboard")


st.subheader("Tổng số đơn hàng theo tháng")
query = """
    SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month, COUNT(*) AS total_orders
    FROM orders
    GROUP BY order_month
    ORDER BY order_month;
"""
df_orders = get_data(query)
st.line_chart(df_orders.set_index("order_month"))

st.subheader("Top 5 khách hàng có nhiều đơn hàng nhất")
query = """
    SELECT customer_id, COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
    ORDER BY total_orders DESC
    LIMIT 5;
"""
df_top_customers = get_data(query)
st.dataframe(df_top_customers)


st.subheader("Doanh thu theo danh mục sản phẩm")
query = """
    SELECT p.product_category_name, SUM(oi.price) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
    ORDER BY total_revenue DESC
    LIMIT 10;
"""
df_revenue = get_data(query)

fig, ax = plt.subplots()
ax.bar(df_revenue["product_category_name"], df_revenue["total_revenue"])
plt.xticks(rotation=45)
plt.ylabel("Doanh thu")
st.pyplot(fig)
