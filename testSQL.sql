CREATE DATABASE CompanyDB;
GO

USE CompanyDB;
GO

-- Bảng Employee
CREATE TABLE Employee (
    eid INT PRIMARY KEY IDENTITY(1,1),
    ename NVARCHAR(100),
    SalaryLevel DECIMAL(10, 2),
    role NVARCHAR(50),
    work NVARCHAR(100)
);

-- Bảng User
CREATE TABLE Users (
    userID INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) UNIQUE,
    pass NVARCHAR(50)
);

CREATE TABLE Connect (
    connectID INT PRIMARY KEY IDENTITY(1,1),
    userID INT FOREIGN KEY REFERENCES Users(userID),
    eid INT FOREIGN KEY REFERENCES Employee(eid)
);
-- Bảng Department
CREATE TABLE Department (
    work NVARCHAR(100) PRIMARY KEY,
    dName NVARCHAR(100),
    Type NVARCHAR(2) CHECK(Type IN ('WS', 'HO')) -- WS: Worksite, HO: Head Office
);

-- Bảng Product
CREATE TABLE Product (
    pId INT PRIMARY KEY IDENTITY(1,1),
    pName NVARCHAR(100),
    pQuantity INT
);

-- Bảng Plan
CREATE TABLE Plan (
    plID INT PRIMARY KEY IDENTITY(1,1),
    plName NVARCHAR(100),
    plStart DATE,
    plEnd DATE,
    plwork NVARCHAR(100) FOREIGN KEY REFERENCES Department(work)
);

-- Bảng Plan Campaign
CREATE TABLE PlanCampaign (
    pcID INT PRIMARY KEY IDENTITY(1,1),
    plID INT FOREIGN KEY REFERENCES Plan(plID),
    pId INT FOREIGN KEY REFERENCES Product(pId),
    pQuantity INT
);

-- Bảng Schedule Campaign
CREATE TABLE ScheduleCampaign (
    scID INT PRIMARY KEY IDENTITY(1,1),
    pcID INT FOREIGN KEY REFERENCES PlanCampaign(pcID),
    date DATE,
    scQuantity INT,
    KPI DECIMAL(5, 2)
);

-- Bảng Schedule Detail
CREATE TABLE ScheduleDetail (
    sdID INT PRIMARY KEY IDENTITY(1,1),
    scID INT FOREIGN KEY REFERENCES ScheduleCampaign(scID),
    eid INT FOREIGN KEY REFERENCES Employee(eid),
    KPI DECIMAL(5, 2)
);

-- Bảng Attendance
CREATE TABLE Attendance (
    aID INT PRIMARY KEY IDENTITY(1,1),
    sWork NVARCHAR(100) FOREIGN KEY REFERENCES Department(work),
    KPI DECIMAL(5, 2),
    Actual_output INT
);