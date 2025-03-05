import streamlit as st
import pymysql
import pandas as pd
import matplotlib.pyplot as plt

# Kết nối MySQL
def get_connection():
    return pymysql.connect(
        host="127.0.0.1",  # Thay bằng IP server MySQL của bạn
        user="root",  # Username của MySQL
        password="quan21042004",  # Thay bằng mật khẩu MySQL
        database="olist_db"  # Thay bằng tên database của bạn
    )

# Lấy dữ liệu từ MySQL
def get_data(query):
    conn = get_connection()
    df = pd.read_sql(query, conn)
    conn.close()
    return df

# Streamlit UI
st.title("📊 Olist Sales Dashboard")

# 1️⃣ Tổng số đơn hàng theo tháng
st.subheader("Tổng số đơn hàng theo tháng")
query = """
    SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month, COUNT(*) AS total_orders
    FROM orders
    GROUP BY order_month
    ORDER BY order_month;
"""
df_orders = get_data(query)
st.line_chart(df_orders.set_index("order_month"))

# 2️⃣ Top 5 khách hàng đặt nhiều nhất
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

# 3️⃣ Doanh thu theo danh mục sản phẩm
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

# Vẽ biểu đồ
fig, ax = plt.subplots()
ax.bar(df_revenue["product_category_name"], df_revenue["total_revenue"])
plt.xticks(rotation=45)
plt.ylabel("Doanh thu")
st.pyplot(fig)
