CREATE TABLE IF NOT EXISTS locations (
    state_id INT NOT NULL,
    county_id INT NOT NULL DEFAULT 0,
    place_id INT NOT NULL DEFAULT 0,
    PRIMARY KEY (state_id, county_id, place_id),
    state_name CHAR(2) NOT NULL,
    county_name VARCHAR(50) NOT NULL,
    place_name VARCHAR(50) NULL,
    UNIQUE (state_id, county_id, place_name)
);


CREATE TABLE IF NOT EXISTS wildfire (
    fire_id INT PRIMARY KEY,
    state_id INT NOT NULL,
    state_name CHAR(2),
    county_id INT,
    county_name VARCHAR(50),
    fire_name VARCHAR(50),
    fire_size DECIMAL(10, 2),
    discovery_date DATE,
    cause VARCHAR(50),
    FOREIGN KEY (state_id, county_id) REFERENCES locations(state_id, county_id)
);

CREATE TABLE IF NOT EXISTS housing (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    state_id INT NOT NULL,
    state_name CHAR(2) NOT NULL,
    county_id INT NOT NULL,
    county_name VARCHAR(50),
    region_name VARCHAR(50),
    assessment_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (state_id, county_id) REFERENCES locations(state_id, county_id)
);

CREATE TABLE IF NOT EXISTS rentals (
    rent_price_id INT AUTO_INCREMENT PRIMARY KEY,
    state_id INT NOT NULL,
    state_name CHAR(2) NOT NULL,
    county_id INT NOT NULL,
    county_name VARCHAR(50),
    region_name VARCHAR(50),
    assessment_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (state_id, county_id) REFERENCES locations(state_id, county_id)
);

CREATE TABLE IF NOT EXISTS census (
    state_id INT NOT NULL,
    county_id INT NOT NULL,
    place_id INT NOT NULL DEFAULT 0,
    true_pop_2010 INT CHECK (true_pop_2010 >= 0),
    pop_estimate_2011 INT,
    pop_estimate_2012 INT,
    pop_estimate_2013 INT,
    pop_estimate_2014 INT,
    pop_estimate_2015 INT,
    pop_estimate_2016 INT,
    pop_estimate_2017 INT,
    pop_estimate_2018 INT,
    pop_estimate_2019 INT,
    FOREIGN KEY (state_id, county_id, place_id) REFERENCES locations(state_id, county_id, place_id),
    UNIQUE (state_id, county_id, place_id)
);