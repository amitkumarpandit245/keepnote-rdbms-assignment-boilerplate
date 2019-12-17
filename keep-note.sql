create database keepnote;
show databases;

-- Query For Keep Note Application--
CREATE TABLE User(user_id INT(3), user_name VARCHAR(20), user_added_date DATE, user_password VARCHAR(20), user_mobile BIGINT(10),CONSTRAINT User_user_id_pk PRIMARY KEY(user_id));
INSERT INTO User VALUES(11,'amit','2019-12-16','P@ssword',8976191225);
SELECT * FROM USER WHERE user_id=11 and user_password='P@ssword';

CREATE TABLE Note(note_id INT(3), note_title VARCHAR(20), note_content VARCHAR(50), note_status VARCHAR(20), note_creation_date DATE, CONSTRAINT Note_note_id_pk PRIMARY KEY(note_id));
INSERT INTO Note VALUES(11,'JAVA','Learn Java in 2 Weeks','In Progress','2019-12-16');
SELECT * FROM Note WHERE note_creation_date='2019-12-16';
UPDATE Note set note_content='Learn Java in 4 Weeks' where note_id=11;
SELECT n.note_id , note_title , note_content , note_status , note_creation_date from Note n JOIN UserNote un ON n.note_id=un.note_id JOIN User u ON u.user_id=un.user_id;
SELECT n.note_id , note_title , note_content , note_status , note_creation_date from Note n JOIN NoteCategory nc ON n.note_id=nc.note_id JOIN Category c ON c.category_id=nc.category_id;
DELETE FROM Note WHERE note_id IN (SELECT note_id from UserNote where user_id=11);
DELETE FROM Note WHERE note_id IN (SELECT note_id from NoteCategory where category_id=11);

CREATE TABLE Category(category_id INT(2), category_name VARCHAR(20), category_descr VARCHAR(20), category_creation_date DATE, category_creator VARCHAR(20), CONSTRAINT Category_category_id_pk PRIMARY KEY(category_id));
INSERT INTO Category VALUES(11,'Language','Programming Language','2019-12-16','Amit');
SELECT * FROM Category where category_creation_date > '2019-10-12';

CREATE TABLE Reminder(reminder_id INT(2), reminder_name VARCHAR(20), reminder_descr VARCHAR(20), reminder_type VARCHAR(20), reminder_creation_date DATE, reminder_creator VARCHAR(20),CONSTRAINT Reminder_reminder_id_pk PRIMARY KEY(reminder_id));
INSERT INTO Reminder VALUES(11,'Meeting','Team Meeting','Urgent','2019-12-16','Amit');
SELECT r.reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator FROM Reminder r JOIN NoteReminder nr ON nr.reminder_id=r.reminder_id;
SELECT r.reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator FROM Reminder r JOIN NoteReminder nr ON nr.reminder_id=r.reminder_id JOIN Note n ON n.note_id=nr.note_id;

CREATE TABLE NoteCategory(notecategory_id INT(2), note_id INT(2), category_id INT(2),CONSTRAINT NoteCategory_notecategory_id PRIMARY KEY(notecategory_id) ,CONSTRAINT NoteCategory_note_id FOREIGN KEY(note_id) REFERENCES Note(note_id), CONSTRAINT NoteCategory_category_id FOREIGN KEY(category_id) REFERENCES Category(category_id));
INSERT INTO Notecategory VALUES(12,11,11);
CREATE TABLE NoteReminder(notereminder_id INT(2), note_id INT(2), reminder_id INT(2),
CONSTRAINT NoteReminder_notereminder_id_pk PRIMARY KEY(notereminder_id),
CONSTRAINT NoteReminder_note_id_fk FOREIGN KEY(note_id) REFERENCES Note(note_id),
CONSTRAINT NoteReminder_reminder_id_fk FOREIGN KEY(reminder_id) REFERENCES Reminder(reminder_id)
);
INSERT INTO NoteReminder VALUES(13,11,11);
CREATE TABLE UserNote(usernote_id INT(2), user_id INT(2), note_id INT(20),
CONSTRAINT UserNote_usernote_id_pk PRIMARY KEY(usernote_id),
CONSTRAINT UserNote_user_id_fk FOREIGN KEY(user_id) REFERENCES User(user_id),
CONSTRAINT UserNote_note_id_fk FOREIGN KEY(note_id) REFERENCES Note(note_id)
);
INSERT INTO UserNote VALUES(14,11,11);
SELECT note_id from UserNote where user_id=11;


drop table usernote;

/*
Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).
Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)
Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)
Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table when :
1. A particular note is deleted from Note table (all the matching records from UserNote, NoteReminder and NoteCategory should be removed automatically)
2. A particular user is deleted from User table (all the matching notes should be removed automatically)
*/