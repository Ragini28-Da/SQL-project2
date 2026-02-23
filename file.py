import pandas as pd
df = pd.read_csv("data.csv")
#print(df.head(5))
#print(df.info())
#print(df.tail())
#print(df.describe())
#print(df.describe(include='all'))
#print(df.isnull().sum())
#if there is any empty value in 
#df['Review_Rating'] = (
#df.groupby('category')['Review_Rating']
 #     .transform(lambda x: x.fillna(x.median()))
#)
#print(df['Review_Rating'])
#print(df.isnull().sum())
df.columns=df.columns.str.lower()
#df.columns=df.columns.str.replace(' ','_')
#print(df.columns)

#labels=['young_adult','adult','middle_aged','senior']
#df['aged_group']=pd.qcut(df['age'],q=4,labels=labels)
#print(df[['age','aged_group']].head(10))

#frequency_mapping={
 #   "Weekly":7,
#    "Quarterly":90,
#    "Monthly":30
#}

#df['frequency_of_mapping']=df['frequency_of_purchases'].map(frequency_mapping)
#print(df[['frequency_of_mapping','frequency_of_purchases']])



#print(df[['Discount_Applied','Promo_Code']].head(10))
      
import mysql.connector

# 1️⃣ Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="ragha",
    database="company_db"
)

cursor = conn.cursor()

# 2️⃣ Create table if it doesn't exist
cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT
)
""")

# 3️⃣ Insert data
data = [
    ("Bob", 15),
    ("Charlie", 17),
    ("Diana", 16),
    ("Rasha", 20),
    ("Aden", 25),
    ("Ben", 22)
]

sql = "INSERT INTO students (name, age) VALUES (%s, %s)"
cursor.executemany(sql, data)
conn.commit()
print(f"{cursor.rowcount} rows inserted successfully ✅")

# 4️⃣ Close connection
cursor.close()
conn.close()

