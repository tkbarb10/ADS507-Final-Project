import pandas as pd
import mysql.connector 

# Establish database connection
conn = mysql.connector.connect(
    host="your_host",
    user="your_user",
    password="your_password",
    database="your_database"
)
cursor = conn.cursor()

# Load your wildfire, housing, or rental dataset
df = pd.read_csv("wildfire_data.csv")  # Replace with your actual dataset

data_to_insert = list(df[["fire_id", "fire_name", "fire_size", "discovery_date", "cause", "state_id", "county_id"]].itertuples(index=False, name=None))



    # Insert the data into the wildfire table
insert_query = """
INSERT INTO wildfire (fire_id, fire_name, fire_size, discovery_date, cause, state_id, county_id)
VALUES (%s, %s, %s, %s, %s, %s, %s)
"""
    
cursor.executemany(insert_query, data_to_insert)

# Commit changes and close the connection
conn.commit()
cursor.close()
conn.close()

print("Wildfire data successfully inserted!")
