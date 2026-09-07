import pandas as pd


def clean_customers(customers):
    df = customers.copy()

    # Handling missing city
    df["city"] = df["city"].fillna("Unknown")

    # Removing duplicate customers
    df = df.drop_duplicates(
        subset=["customer_id"]
    )

    return df


def clean_restaurants(restaurants):
    df = restaurants.copy()

    # Removing duplicate restaurants
    df = df.drop_duplicates(
        subset=["restaurant_id"]
    )

    
    df["rating"] = df["rating"].clip(0, 5)

    return df


def clean_delivery_partners(delivery_partners):
    df = delivery_partners.copy()

    # Removing duplicate delivery partners
    df = df.drop_duplicates(
        subset=["delivery_partner_id"]
    )

    # Keep ratings within valid range
    df["rating"] = df["rating"].clip(0, 5)

    return df


def clean_orders(orders):
    df = orders.copy()

    # Removing eexact duplicate rows
    df = df.drop_duplicates()

    # Handling missing discounts
    df["discount"] = df["discount"].fillna(0)

    # Removing invalid negative order amounts
    df = df[df["order_amount"] >= 0]

    # Calculating final amount
    df["final_amount"] = (
        df["order_amount"]
        - df["discount"]
        + df["delivery_fee"]
    )

    # Calculating delivery delay
    df["delivery_delay"] = (
        df["actual_delivery_time"]
        - df["estimated_delivery_time"]
    )

    # Identifying delayed deliveries
    df["is_delayed"] = (
        df["delivery_delay"] > 0
    ).astype(int)

    # Date features
    df["order_year"] = df["order_date"].dt.year
    df["order_month"] = df["order_date"].dt.month
    df["order_day"] = df["order_date"].dt.day

    # Hour feature
    df["order_hour"] = (
        df["order_time"]
        .astype(str)
        .str[:2]
        .astype(int)
    )

    return df


def clean_payments(payments):
    df = payments.copy()

    # Removing duplicate payments
    df = df.drop_duplicates(
        subset=["payment_id"]
    )

    return df


def transform_data(data):

    # Converting date columns
    data["customers"]["signup_date"] = pd.to_datetime(
        data["customers"]["signup_date"]
    )

    data["restaurants"] = data["restaurants"].copy()

    data["delivery_partners"]["joining_date"] = pd.to_datetime(
        data["delivery_partners"]["joining_date"]
    )

    data["orders"]["order_date"] = pd.to_datetime(
        data["orders"]["order_date"]
    )

    data["payments"] = data["payments"].copy()

    # Applying cleaning
    customers = clean_customers(
        data["customers"]
    )

    restaurants = clean_restaurants(
        data["restaurants"]
    )

    delivery_partners = clean_delivery_partners(
        data["delivery_partners"]
    )

    orders = clean_orders(
        data["orders"]
    )

    payments = clean_payments(
        data["payments"]
    )

    # Referential integrity
    payments = payments[
        payments["order_id"].isin(
            orders["order_id"]
        )
    ]

    return {
        "customers": customers,
        "restaurants": restaurants,
        "delivery_partners": delivery_partners,
        "orders": orders,
        "payments": payments
    }
