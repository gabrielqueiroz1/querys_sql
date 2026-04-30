# %%
import pandas as pd
import sqlalchemy

con_engine = sqlalchemy.create_engine("sqlite:///database.db")


with open("projeto/etl.sql") as open_file:
    query = open_file.read()

print(query)


# %%

dates = [
    '2025-01-01',
    '2025-02-01',
    '2025-03-01',
    '2025-04-01',
    '2025-05-01',
    '2025-06-01',
    '2025-07-01',
    '2025-08-01',
    '2025-09-01',
    '2025-10-01',
    '2025-11-01',
    '2025-12-01',
]

for i in dates:
    df = pd.read_sql(query.format(date=i), con_engine)

    df.to_sql("tb_feature_store_cliente", con_engine, index=False, if_exists="append")

