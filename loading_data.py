import pandas as pd
import mysql.connector  # Use psycopg2 for PostgreSQL

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

# Loop through each row in the DataFrame
for index, row in df.iterrows():
    fire_id = row["fire_id"]
    fire_name = row["fire_name"]
    fire_size = row["fire_size"]
    discovery_date = row["discovery_date"]
    cause = row["cause"]
    state_id = row["state_id"]
    county_name = row["county_name"]  # We need to map this to county_id

    # Query to find the correct county_id
    cursor.execute("""
        SELECT county_id FROM counties 
        WHERE state_id = %s AND county_name LIKE %s
    """, (state_id, f"%{county_name}%"))

    county_id_result = cursor.fetchone()

    if county_id_result:
        county_id = county_id_result[0]  # Extract the county_id
    else:
        print(f"Warning: No match found for {county_name} in state {state_id}")
        continue  # Skip this row if no matching county_id

    # Insert the data into the wildfire table
    insert_query = """
        INSERT INTO wildfire (fire_id, fire_name, fire_size, discovery_date, cause, state_id, county_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    
    cursor.execute(insert_query, (fire_id, fire_name, fire_size, discovery_date, cause, state_id, county_id))

# Commit changes and close the connection
conn.commit()
cursor.close()
conn.close()

print("Wildfire data successfully inserted!")
