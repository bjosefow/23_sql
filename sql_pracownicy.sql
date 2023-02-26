CREATE DATABASE myemployees COLLATE utf8mb4_polish_ci;

#1
CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    salary INT NOT NULL,
    birth_date DATE NOT NULL,
    position VARCHAR(30) NOT NULL
);

#2
INSERT INTO employee 
	(first_name, last_name, salary, birth_date, position)
VALUES
	('Alicja', 'Nowak', 2050, '1992-04-02', 'sales'),
	('Tatiana', 'Fredzel', 3500, '1991-08-08', 'engineer'),
	('Boguslaw', 'Palec', 5000, '1982-10-10', 'manager'),
	('Katarzyna', 'Madrala', 7000, '1956-09-08', 'director'),
	('Piotr', 'Truc', 5600, '1998-02-01', 'lawyer'),
	('Milena', 'Gotowa', 6300, '1977-02-01', 'accountant');
    
#3
select * from employee ORDER BY last_name;

#4
select * from employee where position = 'director';

###5
select * from employee where extract(year from curdate()) - extract( year from birth_date) >= 30;

#6
select first_name, last_name, salary, birth_date, position, salary * 1.1 as salary_with_raise from employee where position = 'director';

###7
select * from employee ORDER BY birth_date desc limit 1;

#8
drop table employee;

#9
CREATE TABLE position (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    description VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

#10
CREATE TABLE address (
	id INT PRIMARY KEY AUTO_INCREMENT,
    zip_code VARCHAR(10) NOT NULL,
    street_with_number_house VARCHAR(30) NOT NULL,
    city VARCHAR(20) NOT NULL
);

#11
CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address_id INT NOT NULL,
    position_id INT NOT NULL,
	FOREIGN KEY (address_id) REFERENCES address (id),
    FOREIGN KEY (position_id) REFERENCES position (id)
);

#12
INSERT INTO position
	(name, description, salary)
VALUES
	('engineer','solves technical problems', 5000),
    ('director','main representative of the company', 15000),
    ('manager','manages a company', 7600);

INSERT INTO address
	(zip_code, street_with_number_house, city)
VALUES
	('50678','Jagiellonow 22','Warszawa'),
	('21220','Kosciuszki 33','Szczecin'),
	('67400','Lesna 12','Wroclaw'),
	('67407','Wiatrowa 6','Gdansk'),
	('67407','Glowna 88','Kolobrzeg');
    
INSERT INTO employee
	(first_name, last_name, address_id, position_id)
VALUES
	('Matylda', 'Moro', 1, 3),
    ('Miroslaw', 'Adalewki', 2, 1),
    ('Adela', 'Zbych', 3, 1),
    ('Michal', 'Radosc', 4, 1),
    ('Boguslawa', 'Kachel', 5, 2);
    
#13
select employee.first_name, employee.last_name, 
position.name, position.description, position.salary, 
address.zip_code, address.street_with_number_house, address.city 
from employee join position join address 
on employee.address_id = address.id and employee.position_id = position.id;

#14

select sum(position.salary) as salatry_sum_for_position 
from employee join position on employee.position_id = position.id;

#15
select e.first_name, e.last_name, a.zip_code, a.street_with_number_house, a.city
from employee e join address a on e.address_id = a.id 
where a.zip_code = '67407';

    