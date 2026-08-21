import pandas as pd

# Basic Python validation for the Financial Operations project.
# Update the file path before running locally.

FILE_PATH = "financial_operations_clean_data.csv"

df = pd.read_csv(FILE_PATH)

# Basic checks
print("Rows:", len(df))
print("\nColumns:")
print(df.columns.tolist())

print("\nMissing Customer IDs:", df["CustomerID"].isna().sum())
print("Negative Quantity Lines:", (df["Quantity"] < 0).sum())

# Revenue check
df["Revenue"] = df["Quantity"] * df["UnitPrice"]

print("\nTotal Revenue:", round(df["Revenue"].sum(), 2))

# Transaction status
df["Transaction_Status"] = df["InvoiceNo"].astype(str).str.startswith("C").map(
    {True: "Cancelled", False: "Completed"}
)

print("\nTransaction Status:")
print(df["Transaction_Status"].value_counts())

# Monthly summary
df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"])
monthly = (
    df.groupby(df["InvoiceDate"].dt.to_period("M"))["Revenue"]
      .sum()
      .reset_index()
)

print("\nMonthly Revenue:")
print(monthly.to_string(index=False))

# Country summary
country = (
    df.groupby("Country")["Revenue"]
      .sum()
      .sort_values(ascending=False)
      .head(10)
)

print("\nTop 10 Countries:")
print(country)

# Product summary
product = (
    df.groupby("Description")["Revenue"]
      .sum()
      .sort_values(ascending=False)
      .head(10)
)

print("\nTop 10 Products:")
print(product)
