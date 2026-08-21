# Power Query Transformation Steps

The project uses Power Query for repeatable data preparation.

1. Load the UCI Online Retail Excel file into Power Query.
2. Set appropriate data types:
   - InvoiceNo / StockCode / CustomerID: text or appropriate numeric type
   - Description / Country: text
   - Quantity: whole number
   - InvoiceDate: date/time
   - UnitPrice: decimal number
3. Trim and clean text fields.
4. Add `Revenue = Quantity * UnitPrice`.
5. Add `Transaction_Status`:
   - InvoiceNo beginning with `C` -> Cancelled
   - otherwise -> Completed
6. Add `Data_Quality_Flag`:
   - Quantity < 0 -> Negative Quantity
   - otherwise -> Valid
7. Keep missing Customer IDs visible and report them as a data-quality KPI rather than silently deleting them.
8. Load the cleaned table to Excel as `CleanData`.

This keeps the transformation logic simple and auditable, which is appropriate for an operations/reporting use case.
