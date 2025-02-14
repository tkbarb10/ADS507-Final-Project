**Page for SQL code to load into database**

# Create Database

```sql
CREATE DATABASE IF NOT EXISTS wildfire_housing
```

# Create places table

```sql
CREATE TABLE IF NOT EXISTS locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for locations
    state_name CHAR(2) NOT NULL,
    state_id INT NOT NULL,
    county_id INT NOT NULL,
    county_name VARCHAR(40),
    places_id INT NOT NULL,
    place_name VARCHAR(50),                      -- City/Town/Village Name
    UNIQUE (state_id, county_name, place_name)    -- Prevents duplicate locations
);

```

# Create Wildfire table

```sql
CREATE TABLE IF NOT EXISTS wildfire (
    object_id int PRIMARY KEY, -- included with the wildfire data
    location_id INT NOT NULL,
    fire_name VARCHAR(20), --Lot of unknowns in this feature and a lot of repeats (like 'Grass fire') better to just delete?
    discovery_date date,
    cause VARCHAR(20), --we have two, one that's general and one specific, probably will just keep one
    state_id INT, --foreign key
    state_name CHAR(2),
    county_name VARCHAR(20),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
```


# Create Housing Table

```sql
CREATE TABLE IF NOT EXISTS housing (
    price_id INT AUTO_INCREMENT PRIMARY KEY, --Auto_incrementing for each new record since a new one will be added each month with updated price
    location_id INT NOT NULL,
    state_id INT NOT NULL, --Will need to make this a foreign_key
    state_name CHAR(2) NOT NULL, --Redundant?
    region_name VARCHAR(40), 
    county_name VARCHAR(20),
    eval_date date, --this will be the date the housing price was assessed
    price DECIMAL(10, 2),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
```

# Create Rentals Table

```sql
CREATE TABLE IF NOT EXISTS rentals (
    rent_id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT NOT NULL,
    state_id INT NOT NULL, --Will need this to be a foreign key
    state_name CHAR(2) NOT NULL,
    region_name VARCHAR(40),
    county_name VARCHAR(40),
    eval_date DATE,
    price DECIMAL (10,2),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
```



# Create Population Table

```sql
CREATE TABLE IF NOT EXISTS census_data (
    places_id INT PRIMARY KEY,
    location_id INT NOT NULL,
    county_name VARCHAR(40),
    census_2010 INT CHECK (census_2010 >= 0), --need to make sure the A values get ignored or replaced with Null
    pop_estimate_2011 INT,
    pop_estimate_2012 INT,
    pop_estimate_2013 INT,
    pop_estimate_2014 INT,
    pop_estimate_2015 INT,
    pop_estimate_2016 INT,
    pop_estimate_2017 INT,
    pop_estimate_2018 INT,
    pop_estimate_2019 INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
```