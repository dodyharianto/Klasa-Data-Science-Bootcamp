import pandas as pd
from flask import Flask
from sqlalchemy import create_engine
import os

app = Flask(__name__)

conn_format = "postgresql://klasa:klasasecret@178.128.111.32:5432/dataset_restapi"
conn_string = conn_format.format(**{
    "user": os.environ.get("POSTGRES_USER"),
    "pass": os.environ.get("POSTGRES_PASS"),
    "host": os.environ.get("POSTGRES_HOST"),
    "port": os.environ.get("POSTGRES_PORT"),
    "db": os.environ.get("POSTGRES_DB"),
})

conn = create_engine(conn_string)

@app.route('/')
def home():
    headline = '<h1> Welcome to the Supermarket Sales Database! </h1>\n'
    endpoints = '<h2> Available Endpoints: </h2>\n'
    options = """
    /get_csv, /display_all, /sales/list/branch, /sales/list/payment, /sales/date/2021-02-25, /sales/summary/payment, /sales/summary/gender, /sales/summary/branch
    """
    result = headline + endpoints + options
    return result

@app.route('/get_csv', methods = ['GET'])
def convert_database_to_csv():
    query = 'SELECT * FROM supermarket_sales'
    df = pd.read_sql(query, conn)
    df.to_csv('supermarket_sales_df.csv', index = False)

# Endpoint 1
@app.route('/display_all', methods = ['GET'])
def display_all():
    query = 'SELECT * FROM supermarket_sales'
    df = pd.read_sql(query, conn)
    result = df.to_dict()
    return {'data': result}

@app.route('/sales/list/branch', methods = ['GET'])
def get_distinct_branch():
    query = 'SELECT DISTINCT branch FROM supermarket_sales'
    df = pd.read_sql(query, conn)
    result = df.to_dict()
    return {'data': result}

@app.route('/sales/list/payment', methods = ['GET'])
def get_distinct_payment():
    query = 'SELECT DISTINCT payment FROM supermarket_sales'
    df = pd.read_sql(query, conn)
    result = df.to_dict()
    return {'data': result}

# Endpoint 2
@app.route('/sales/date/2021-02-25', methods = ['GET'])
def get_sales_based_on_date():
    query = "SELECT * FROM supermarket_sales WHERE date = '2019-02-25'"
    df = pd.read_sql(query, conn)
    result = df.to_dict()
    return {'data': result}

# Endpoint 3
@app.route('/sales/summary/payment')
def get_total_sales_by_payment():
    query = """
    SELECT COUNT(*) as payments 
    FROM supermarket_sales 
    GROUP BY payment
    """
    df = pd.read_sql(query, conn)
    result = df.to_dict()
    return {'data': result}

@app.route('/sales/summary/gender')
def get_total_sales_by_gender():
    query = """
    SELECT COUNT(*) as genders 
    FROM supermarket_sales 
    GROUP BY gender
    """
    df = pd.read_sql(query, conn)
    result = df.to_dict()
    return {'data': result}

@app.route('/sales/summary/branch')
def get_total_sales_by_branch():
    query = """
    SELECT COUNT(*) as branch 
    FROM supermarket_sales 
    GROUP BY branch
    """
    df = pd.read_sql(query, conn)
    result = df.to_dict()
    return {'data': result}

if __name__ == '__main__':
    app.run(debug = True)