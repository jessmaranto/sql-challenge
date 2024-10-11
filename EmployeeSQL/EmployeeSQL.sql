-- Drop Tables if Existing
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE titles (
    title_id INT PRIMARY KEY, 
    title VARCHAR(255) NOT NULL
);

CREATE TABLE Departments (
    dept_no SERIAL PRIMARY KEY,
    emp_title_id INT,
    title VARCHAR(50) NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id) 
);

CREATE TABLE Employees (
    emp_no SERIAL PRIMARY KEY,
    emp_title_id INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    birth_date DATE, 
    sex VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id) 
);

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no INT NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no) 
);

CREATE TABLE dept_manager (
    dept_no INT NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);
