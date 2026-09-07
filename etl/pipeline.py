from extract import extract_data
from transform import transform_data
from load import load_to_mysql


def run_pipeline():

    print("=" * 60)
    print("FOOD DELIVERY ETL PIPELINE")
    print("=" * 60)

    # -------------------------
    # EXTRACT
    # -------------------------

    print("\n[1] EXTRACT")

    raw_data = extract_data()

    for name, df in raw_data.items():
        print(
            f"{name}: {len(df)} rows extracted"
        )

    # -------------------------
    # TRANSFORM
    # -------------------------

    print("\n[2] TRANSFORM")

    cleaned_data = transform_data(
        raw_data
    )

    for name, df in cleaned_data.items():
        print(
            f"{name}: {len(df)} rows after cleaning"
        )

    # -------------------------
    # LOAD
    # -------------------------

    print("\n[3] LOAD")

    load_to_mysql(
        cleaned_data
    )

    print("\n" + "=" * 60)
    print("ETL PIPELINE COMPLETED")
    print("=" * 60)


if __name__ == "__main__":
    run_pipeline()
