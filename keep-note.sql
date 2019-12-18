CREATE TABLE User(user_id VARCHAR(20), user_name VARCHAR(20) not null, user_added_date DATETIME not null, user_password VARCHAR(20) not null, user_mobile VARCHAR(20),PRIMARY KEY (user_id));
CREATE TABLE Note(note_id INT(3) primary key, note_title VARCHAR(20) not null, note_content VARCHAR(50) , note_status VARCHAR(20) not null, note_creation_date DATETIME not null);
CREATE TABLE Category(category_id INT(3) primary key, category_name VARCHAR(20) not null, category_descr VARCHAR(20), category_creation_date DATETIME not null, category_creator VARCHAR(20) not null);
CREATE TABLE Reminder(reminder_id INT(3) primary key, reminder_name VARCHAR(20) not null, reminder_descr VARCHAR(20), reminder_type VARCHAR(20), reminder_creation_date DATETIME not null, reminder_creator VARCHAR(20));
CREATE TABLE NoteCategory(notecategory_id INT(3), note_id INT(3), category_id INT(3) ,CONSTRAINT NoteCategory_notecategory_id PRIMARY KEY(notecategory_id));
CREATE TABLE NoteReminder(notereminder_id INT(3), note_id INT(3), reminder_id INT(3),
CONSTRAINT NoteReminder_notereminder_id_pk PRIMARY KEY(notereminder_id));
CREATE TABLE UserNote(usernote_id INT(3), user_id VARCHAR(20) not null, note_id INT(3) not null,
CONSTRAINT UserNote_usernote_id_pk PRIMARY KEY(usernote_id));
INSERT INTO User VALUES('11','amit','2019-12-16 10:10:10','P@ssword','8976191225');
INSERT INTO User VALUES('12','Sumit','2019-12-16 10:10:10','P@ssword','8976191297');
INSERT INTO Note VALUES(11,'JAVA','Learn Java in 2 Weeks','In Progress','2019-12-16 10:10:10');
INSERT INTO Note VALUES(12,'ASP','Learn ASP in 2 Weeks','In Progress','2019-12-16 10:10:10');
INSERT INTO Category VALUES(11,'Language','Programming Language','2019-12-16 10:10:10','Amit');
INSERT INTO Category VALUES(12,'Literature','Literature Language','2019-12-16 10:10:10','Sumit');
INSERT INTO Reminder VALUES(11,'Meeting','Team Meeting','Urgent','2019-12-16 10:10:10','Amit');
INSERT INTO Reminder VALUES(12,'Outing','Team Outing','Urgent','2019-12-16 10:10:10','Sumit');
INSERT INTO Notecategory VALUES(11,11,11);
INSERT INTO Notecategory VALUES(12,12,12);
INSERT INTO NoteReminder VALUES(11,11,11);
INSERT INTO NoteReminder VALUES(12,12,12);
INSERT INTO UserNote VALUES(11,'11',11);
INSERT INTO UserNote VALUES(12,'12',12);
INSERT INTO UserNote VALUES(13,'11',11);
INSERT INTO Note VALUES(13,'ASP','Learn ASP in 2 Weeks','In Progress','2019-12-16 10:10:10');
INSERT INTO UserNote VALUES(14,'12',13);
INSERT INTO Note VALUES(14,'JAVA','Learn JAVA in 2 Weeks','Done','2019-12-16 10:10:10');
INSERT INTO Notecategory VALUES(13,14,12);
INSERT INTO Reminder VALUES(13,'Meeting','Team Meeting','Urgent','2019-12-16 10:10:10','Amit');
INSERT INTO NoteReminder VALUES(13,14,12);
SELECT r.reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator FROM Reminder r JOIN NoteReminder nr ON nr.reminder_id=r.reminder_id;
SELECT r.reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator FROM Reminder r JOIN NoteReminder nr ON nr.reminder_id=r.reminder_id JOIN Note n ON n.note_id=nr.note_id;
SELECT n.note_id , note_title , note_content , note_status , note_creation_date from Note n JOIN UserNote un ON n.note_id=un.note_id JOIN User u ON u.user_id=un.user_id;
SELECT n.note_id , note_title , note_content , note_status , note_creation_date from Note n JOIN NoteCategory nc ON n.note_id=nc.note_id JOIN Category c ON c.category_id=nc.category_id;
SELECT * FROM Category where category_creation_date > '2019-10-12 10:10:10';
SELECT note_id from UserNote where user_id='11';
SELECT * FROM Note WHERE note_creation_date='2019-12-16 10:10:10';
SELECT * FROM USER WHERE user_id='11' and user_password='P@ssword';
SET SQL_SAFE_UPDATES=0;
UPDATE Note set note_content='Learn Java in 4 Weeks' where note_id=11;
DELIMITER $$
CREATE TRIGGER Delete_All_Note
BEFORE DELETE ON Note
FOR EACH ROW
BEGIN
DELETE un FROM UserNote WHERE un.note_id=old.note_id;
DELETE nr FROM NoteReminder WHERE nr.note_id=old.note_id;
DELETE nc FROM NoteCategory WHERE nc.note_id=old.note_id;
END$$
DELIMITER ;
DELETE FROM Note where note_id=11;
select * from note;
DELIMITER $$
CREATE TRIGGER Delete_All_User
BEFORE DELETE ON User
FOR EACH ROW
BEGIN
DELETE un FROM UserNote WHERE un.user_id=old.user_id;
END$$
DELIMITER ;
DELETE FROM User where user_id='12';
DELETE FROM Note WHERE note_id IN (SELECT note_id from UserNote where user_id='11');
DELETE FROM Note WHERE note_id IN (SELECT note_id from NoteCategory where category_id=11);