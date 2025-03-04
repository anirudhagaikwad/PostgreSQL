-- PostgreSQL Data Insertion

-- Insert data into regions
INSERT INTO regions(region_id, region_name) VALUES (1, 'Europe');
INSERT INTO regions(region_id, region_name) VALUES (2, 'Americas');
INSERT INTO regions(region_id, region_name) VALUES (3, 'Asia');
INSERT INTO regions(region_id, region_name) VALUES (4, 'Middle East and Africa');

-- Insert data into countries
INSERT INTO countries(country_id, country_name, region_id) VALUES ('AR', 'Argentina', 2);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('AU', 'Australia', 3);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('BE', 'Belgium', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('BR', 'Brazil', 2);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('CA', 'Canada', 2);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('CH', 'Switzerland', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('CN', 'China', 3);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('DE', 'Germany', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('DK', 'Denmark', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('EG', 'Egypt', 4);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('FR', 'France', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('IN', 'India', 3);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('IT', 'Italy', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('JP', 'Japan', 3);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('MX', 'Mexico', 2);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('UK', 'United Kingdom', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('US', 'United States of America', 2);

-- Insert data into locations
INSERT INTO locations(street_address, postal_code, city, state_province, country_id) VALUES ('2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO locations(street_address, postal_code, city, state_province, country_id) VALUES ('2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO locations(street_address, postal_code, city, state_province, country_id) VALUES ('2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');

-- Insert data into jobs
INSERT INTO jobs(job_title, min_salary, max_salary) VALUES ('Public Accountant', 4200.00, 9000.00);
INSERT INTO jobs(job_title, min_salary, max_salary) VALUES ('Accounting Manager', 8200.00, 16000.00);
INSERT INTO jobs(job_title, min_salary, max_salary) VALUES ('Programmer', 4000.00, 10000.00);
INSERT INTO jobs(job_title, min_salary, max_salary) VALUES ('Finance Manager', 8200.00, 16000.00);
INSERT INTO jobs(job_title, min_salary, max_salary) VALUES ('Marketing Manager', 9000.00, 15000.00);

-- Insert data into departments
INSERT INTO departments(department_name, location_id) VALUES ('Administration', 1700);
INSERT INTO departments(department_name, location_id) VALUES ('Marketing', 1800);
INSERT INTO departments(department_name, location_id) VALUES ('IT', 1400);
INSERT INTO departments(department_name, location_id) VALUES ('Human Resources', 2400);
INSERT INTO departments(department_name, location_id) VALUES ('Sales', 2500);

-- Insert data into employees
INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES ('Steven', 'King', 'steven.king@engine.org', '515.123.4567', '1987-06-17', 4, 24000.00, NULL, 9);
INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES ('Neena', 'Kochhar', 'neena.kochhar@engine.org', '515.123.4568', '1989-09-21', 5, 17000.00, 100, 9);
INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES ('Lex', 'De Haan', 'lex.dehaan@engine.org', '515.123.4569', '1993-01-13', 5, 17000.00, 100, 9);
INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES ('Alexander', 'Hunold', 'alex.hunold@engine.org', '590.423.4567', '1990-01-03', 9, 9000.00, 102, 6);
INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES ('Bruce', 'Ernst', 'bruce.ernst@engine.org', '590.423.4568', '1991-05-21', 9, 6000.00, 103, 6);
INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES ('David', 'Austin', 'david.austin@engine.org', '590.423.4569', '1997-06-25', 9, 4800.00, 103, 6);
INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES ('Nancy', 'Greenberg', 'nancy.greenberg@engine.org', '515.124.4569', '1994-08-17', 7, 12000.00, 101, 10);

-- Inset data into dependents
INSERT INTO dependents(first_name, last_name, relationship, employee_id) VALUES ('Penelope', 'Gietz', 'Child', 206);
INSERT INTO dependents(first_name, last_name, relationship, employee_id) VALUES ('Paul', 'Gietz', 'Spouse', 206);
INSERT INTO dependents(first_name, last_name, relationship, employee_id) VALUES ('Alice', 'Doe', 'Child', 107);
INSERT INTO dependents(first_name, last_name, relationship, employee_id) VALUES ('Bob', 'Smith', 'Child', 110);