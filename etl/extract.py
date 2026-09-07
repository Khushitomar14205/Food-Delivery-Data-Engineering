import pandas as pd
import os


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RAW_DIR = os.path.join(BASE_DIR, "data", "raw")


def extract_data():
    customers = pd.read_csv(
        os.path.join(RAW_DIR, "customers.csv")
    )

    restaurants = pd.read_csv(
        os.path.join(RAW_DIR, "restaurants.csv")
    )

    delivery_partners = pd.read_csv(
        os.path.join(RAW_DIR, "delivery_partners.csv")
    )

    orders = pd.read_csv(
        os.path.join(RAW_DIR, "orders.csv")
    )

    payments = pd.read_csv(
        os.path.join(RAW_DIR, "payments.csv")
    )

    return {
        "customers": customers,
        "restaurants": restaurants,
        "delivery_partners": delivery_partners,
        "orders": orders,
        "payments": payments
    }


if __name__ == "__main__":
    data = extract_data()

    for name, df in data.items():
        print(f"{name}: {df.shape}")
