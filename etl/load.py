import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from getpass import getpass


def create_mysql_engine():

    username = "root"

    password = getpass(
        "Enter MySQL password: "
    )

    connection_url = URL.create(
        "mysql+pymysql",
        username=username,
        password=password,
        host="localhost",
        port=3306,
        database="food_delivery_dw"
    )

    return create_engine(connection_url)


def load_to_mysql(data):

    engine = create_mysql_engine()

    table_mapping = {
        "customers": "stg_customers",
        "restaurants": "stg_restaurants",
        "delivery_partners": "stg_delivery_partners",
        "orders": "stg_orders",
        "payments": "stg_payments"
    }

    for name, table_name in table_mapping.items():

        df = data[name].copy()

        print(
            f"Loading {name} "
            f"({len(df)} rows)..."
        )

        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="append",
            index=False,
            chunksize=1000,
            method="multi"
        )

        print(
            f"{name} loaded successfully."
        )

    print("\nETL loading completed.")
