BEGIN TRANSACTION; 

CREATE TABLE department 

( 

        dept_id SERIAL NOT NULL PRIMARY KEY, 
        
        dept_name VARCHAR(50) NOT NULL         

); 

CREATE TABLE project 

( 

        project_id SERIAL NOT NULL PRIMARY KEY, 

        project_name VARCHAR(50) NOT NULL, 

        Pro_startdate DATE NOT NULL 

); 

CREATE TABLE employee 

( 

        emp_id  SERIAL NOT NULL PRIMARY KEY, 

        job_title VARCHAR(30) NOT NULL, 

        last_name VARCHAR(30) NOT NULL, 

        first_name VARCHAR(30) NOT NULL, 

        gender    VARCHAR(10),  

        birth_date DATE NOT NULL, 

        hire_date DATE NOT NULL, 

        dept_id INTEGER NOT NULL, 
        
        project_id INTEGER NOT NULL,
       

         

        CONSTRAINT fk_department FOREIGN KEY (dept_id) REFERENCES department(dept_id),
        
        CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES project(project_id) 

); 

  

  

COMMIT TRANSACTION; 

INSERT INTO project (project_name, pro_startdate)
VALUES ('ice cream', '2019-01-01'),
       ('spicy drink','2019-02-01'),
       ('bitter snack', '2019-03-01'),
       ('cold food','2019-04-01');
       
INSERT INTO department(dept_name)
VALUES ('production'),
       ('marketing'),
       ('supply chain'),
       ('sale');
       
INSERT INTO employee (job_title,last_name,first_name,gender,birth_date,hire_date, dept_id, project_id)  
VALUES ('Production Manager', 'Chongsam', 'Andy', 'Male','1980-01-01', '2010-01-01', 1,1),  
       ('Production Supervisor','Choinski','Nicole','Female','1990-02-03','2012-01-01',1,2),  
       ('Marketing Manager', 'Jeung', 'Jeff', 'Male','1985-01-05', '2017-01-01', 2,3),  
       ('Marketing Supervisor','Fields','Andorra','Female','1990-11-03','2018-01-01',2,4),   
       ('Supply Chain Manager', 'Dofour', 'Greg', 'Male','1970-01-01', '2019-01-01',3,1),  
       ('Supply Chain Supervisor','Idema','Patricia','Female','1996-05-03','2015-01-20',3,2),  
       ('Sales Manager', 'Sutzer', 'Tim', 'Male','1980-06-01', '2017-01-06',4,3),  
       ('Sales Supervisor','Tek','Casey','Female','1998-07-03','2019-08-01',4, 4);        



                        