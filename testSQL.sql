use ABCcompany;

-- Role Table
CREATE TABLE Role (
    id INT PRIMARY KEY,
    name_role VARCHAR(255),
    salary FLOAT
);

-- Feature Table
CREATE TABLE Feature (
    id INT PRIMARY KEY,
    Feature_Name VARCHAR(255)
);

-- Role_Feature Table (Junction table for many-to-many relationship between Role and Feature)
CREATE TABLE Role_Feature (
    Role_id INT,
    Feature_id INT,
    PRIMARY KEY (Role_id, Feature_id),
    FOREIGN KEY (Role_id) REFERENCES Role(id),
    FOREIGN KEY (Feature_id) REFERENCES Feature(id)
);

-- Account Table
CREATE TABLE Account (
    ID INT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    rID INT,
    FOREIGN KEY (rID) REFERENCES Role(id)
);

-- Factory_Header Table
CREATE TABLE Factory_Header (
    id INT PRIMARY KEY,
    accID INT,
    facID INT,
    name VARCHAR(255),
    FOREIGN KEY (accID) REFERENCES Account(ID)
);
-- Worker Table
CREATE TABLE Worker (
    id INT PRIMARY KEY,
    facID INT,
    accID INT,
    name VARCHAR(255),
    total_KPI FLOAT,
    FOREIGN KEY (facID) REFERENCES Factory_Header(id),
    FOREIGN KEY (accID) REFERENCES Account(ID)
);


-- WS Table (Workstation)
CREATE TABLE WS (
    id INT PRIMARY KEY,
    hID INT,
    Factory_name VARCHAR(255),
    FOREIGN KEY (hID) REFERENCES Factory_Header(id)
);

-- Shift Table
CREATE TABLE Shift (
    id INT PRIMARY KEY,
    facID INT,
    name VARCHAR(255),
    [start] TIME,
    [end] TIME,
    FOREIGN KEY (facID) REFERENCES Factory_Header(id)
);

-- Daily_Worker Table
CREATE TABLE Daily_Worker (
    id INT PRIMARY KEY,
    wID INT,
    shiftID INT,
    KPI FLOAT,
    attended BIT,
    FOREIGN KEY (wID) REFERENCES Worker(id),
    FOREIGN KEY (shiftID) REFERENCES Shift(id)
);

-- Month_Shift_Plan Table
CREATE TABLE Month_Shift_Plan (
    id INT PRIMARY KEY,
    facID INT,
    Month INT,
    day DATE,
    wID INT,
    sID INT,
    FOREIGN KEY (facID) REFERENCES Factory_Header(id),
    FOREIGN KEY (wID) REFERENCES Worker(id),
    FOREIGN KEY (sID) REFERENCES Shift(id)
);

-- Product Table
CREATE TABLE Product (
    id INT PRIMARY KEY,
    Product_name VARCHAR(255),
    estimated INT
);
-- Plan Table
CREATE TABLE [Plan] (
    id INT PRIMARY KEY,
    pID INT,
    Quantity INT,
    done BIT,
    productID INT, -- Added productID to reference Product table
    FOREIGN KEY (productID) REFERENCES Product(id)
);

CREATE TABLE Plan_Detail (
    id INT PRIMARY KEY,
    date DATE,
    pID INT,
    facID INT,
    Quantity INT,
    note VARCHAR(255),
    done BIT,
    productID INT, -- Added productID to reference Product table
    FOREIGN KEY (pID) REFERENCES [Plan](id),
    FOREIGN KEY (facID) REFERENCES Factory_Header(id),
    FOREIGN KEY (productID) REFERENCES Product(id) -- Link to Product
);

