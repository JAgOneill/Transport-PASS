create database pmt_pass;
\c pmt_pass;

create table passenger_register(
passenger_id varchar(10) primary key,
passenger_name varchar(60),
email_id varchar(30),
phone_no varchar(10),
password varchar(20)
);

create table passenger_form(
application_form_id varchar(20) primary key,
passenger_name varchar(50),
full_address varchar(100),
passenger_dob date,
bus_route_from varchar(50),
bus_route_to varchar(50),
register_date date,
city varchar(30),
gender varchar(8),
submit_status int,
payment_status int,
approve_status int,
photo varchar(500),
aadhar_card varchar(500),
login_status int,
passenger_id varchar(10) references passenger_register on delete cascade on update cascade
);

create table admin_rejection_list(
rejection_id varchar(10) primary key,
description_of_rejection varchar(200),
application_form_id varchar(20) references passenger_form on delete cascade on update cascade
);

create table payment_details(
payment_id varchar(10) primary key,
payment_amount float,
application_form_id varchar(20) references passenger_form on delete cascade on update cascade
);

create table renew_pass(
renew_id varchar(10) primary key,
from_date date,
payment_status int,
application_form_id varchar(20) references passenger_form on delete cascade on update cascade
);
