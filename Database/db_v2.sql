create database if not exists uno_bank_v2;
use uno_bank_v2;
drop table if exists consumer_transaction;
drop table if exists card;
drop table if exists payee;
drop table if exists loan;
drop table if exists consumer_session;
drop table if exists favourites;
drop table if exists req_consumer;
drop table if exists consumer_account;
drop table if exists consumer;
drop table if exists branch;
drop table if exists bank;
drop table if exists account_limit;
drop table if exists transaction_limit;
drop table if exists otp;

CREATE TABLE IF NOT EXISTS otp (
	consumer_id VARCHAR(10),
    otp VARCHAR(7),
    sent VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS bank (
	bank_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    bank_name VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS branch (
    bank_ifsc VARCHAR(11) PRIMARY KEY,
    bank_bank_id INTEGER ,
    bank_branch VARCHAR(20),
    FOREIGN KEY (bank_bank_id)
        REFERENCES bank (bank_id)
);

CREATE TABLE IF NOT EXISTS account_limit (
    account_type VARCHAR(10) PRIMARY KEY,
    account_minimum_limit LONG,
    account_maximum_limit LONG
);

CREATE TABLE IF NOT EXISTS transaction_limit (
    transaction_method VARCHAR(10) PRIMARY KEY,
    transaction_minimum_limit LONG,
    transaction_maximum_limit LONG
);

CREATE TABLE IF NOT EXISTS consumer (
    consumer_id VARCHAR(10) PRIMARY KEY,
    consumer_first_name VARCHAR(20),
    consumer_last_name VARCHAR(20),
    consumer_phone_number VARCHAR(10),
    consumer_email VARCHAR(50),
    consumer_password VARCHAR(20),
    consumer_online_pin VARCHAR(4),
    is_face_recognized VARCHAR(2),
    bank_bank_ifsc VARCHAR(11),
    credit_points INT,
    activation TINYINT(1),
    FOREIGN KEY (bank_bank_ifsc)
        REFERENCES branch (bank_ifsc)
);

CREATE TABLE IF NOT EXISTS req_consumer (
	r_no INT AUTO_INCREMENT PRIMARY KEY,
    r_consumer_first_name VARCHAR(20),
    r_consumer_last_name VARCHAR(20),
    r_consumer_phone_number VARCHAR(10),
    r_consumer_email VARCHAR(50),
    r_consumer_password VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS loan (
    loan_number VARCHAR(16),
    bank_bank_ifsc VARCHAR(11),
    consumer_consumer_id VARCHAR(10),
    loan_amount LONG,
    FOREIGN KEY (bank_bank_ifsc)
        REFERENCES branch (bank_ifsc),
    FOREIGN KEY (consumer_consumer_id)
        REFERENCES consumer (consumer_id)
);

CREATE TABLE IF NOT EXISTS consumer_session (
    session_id VARCHAR(20) PRIMARY KEY,
    consumer_consumer_id VARCHAR(10),
    session_start_time TIME,
    session_end_time TIME,
    session_location_pincode VARCHAR(6),
    is_face_recognized VARCHAR(2),
    FOREIGN KEY (consumer_consumer_id)
        REFERENCES consumer (consumer_id)
);

CREATE TABLE IF NOT EXISTS consumer_account (
    account_number VARCHAR(10) PRIMARY KEY,
    account_account_type VARCHAR(10),
    consumer_consumer_id VARCHAR(10),
    account_balance LONG,
    FOREIGN KEY (account_account_type)
        REFERENCES account_limit (account_type),
    FOREIGN KEY (consumer_consumer_id)
        REFERENCES consumer (consumer_id)
);

CREATE TABLE IF NOT EXISTS payee (
    consumer_consumer_id VARCHAR(10),
    payee_name VARCHAR(20),
    payee_nick_name VARCHAR(20),
    payee_account_number VARCHAR(20),
    bank_bank_ifsc VARCHAR(11),
    FOREIGN KEY (consumer_consumer_id)
        REFERENCES consumer (consumer_id),
    FOREIGN KEY (bank_bank_ifsc)
        REFERENCES branch (bank_ifsc),
    PRIMARY KEY (consumer_consumer_id , payee_account_number)
);

CREATE TABLE IF NOT EXISTS card (
    card_number VARCHAR(16) PRIMARY KEY,
    card_type VARCHAR(10),
    card_pin VARCHAR(4),
    card_expiry_date VARCHAR(8),
    card_cvv VARCHAR(3),
    account_account_number VARCHAR(10),
    card_limit LONG,
    consumer_consumer_id VARCHAR(10),
    FOREIGN KEY (consumer_consumer_id)
        REFERENCES consumer (consumer_id),
    FOREIGN KEY (account_account_number)
        REFERENCES consumer_account (account_number)
);

CREATE TABLE IF NOT EXISTS consumer_transaction (
    transaction_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    transaction_time VARCHAR(20),
    bank_from_ifsc VARCHAR(11),
    account_from_account_number VARCHAR(10),
    bank_to_ifsc VARCHAR(11),
    account_to_account_number VARCHAR(10),
    transaction_transaction_method VARCHAR(10),
    transaction_amount LONG,
    transaction_status VARCHAR(10),
    transaction_charge INT,
    FOREIGN KEY (account_from_account_number)
        REFERENCES consumer_account (account_number),
    FOREIGN KEY (bank_from_ifsc)
        REFERENCES branch (bank_ifsc),
    FOREIGN KEY (bank_to_ifsc)
        REFERENCES branch (bank_ifsc)
);

CREATE TABLE IF NOT EXISTS favourites (
	fav_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    consumer_consumer_id VARCHAR(10),
    payee_name VARCHAR(20),
    payee_nick_name VARCHAR(20),
    bank_from_ifsc VARCHAR(11),
    account_from_account_number VARCHAR(10),
    bank_to_ifsc VARCHAR(11),
    account_to_account_number VARCHAR(10),
    transaction_amount LONG,
    FOREIGN KEY (consumer_consumer_id)
        REFERENCES consumer (consumer_id),
	FOREIGN KEY (account_from_account_number)
        REFERENCES consumer_account (account_number),
    FOREIGN KEY (bank_from_ifsc)
        REFERENCES branch (bank_ifsc),
    FOREIGN KEY (bank_to_ifsc)
        REFERENCES branch (bank_ifsc)
);

SELECT * FROM bank;
SELECT * FROM branch;
SELECT * FROM payee;
SELECT * FROM consumer_account;
SELECT * FROM consumer;
SELECT * FROM consumer_transaction;
SELECT * FROM favourites;
SELECT * FROM req_consumer;
SELECT * FROM card;

INSERT INTO `bank`(`bank_name`) VALUES ('UNO');
INSERT INTO `bank`(`bank_name`) VALUES ('ICICI');
INSERT INTO `bank`(`bank_name`) VALUES ('KVB');

INSERT INTO `branch`(`bank_ifsc`, `bank_bank_id`, `bank_branch`) VALUES ('UNOL0000001','1','Vadavalli');
INSERT INTO `branch`(`bank_ifsc`, `bank_bank_id`, `bank_branch`) VALUES ('ICIC0000033','2','Pricol Coimbatore');
INSERT INTO `branch`(`bank_ifsc`, `bank_bank_id`, `bank_branch`) VALUES ('ICIC0002140','2','Mettupalayam');
INSERT INTO `branch`(`bank_ifsc`, `bank_bank_id`, `bank_branch`) VALUES ('KVBL0001628','3','Annur');

INSERT INTO `consumer`(`consumer_id`, `consumer_first_name`, `consumer_last_name`, `consumer_phone_number`, `consumer_email`, `consumer_password`, `consumer_online_pin`, `bank_bank_ifsc`, `credit_points`, `activation`) VALUES ('15011','Darshan','S','9150460652','darshanguhan007@gmail.com','asdfg123!','0108','UNOL0000001', 100, 1);
INSERT INTO `consumer`(`consumer_id`, `consumer_first_name`, `consumer_last_name`, `consumer_phone_number`, `consumer_email`, `consumer_password`, `consumer_online_pin`, `bank_bank_ifsc`, `credit_points`, `activation`) VALUES ('15012','Amrith','V','9566017045','amrith1505@gmail.com','qwert123!','0209','UNOL0000001', 70, 1);
-- INSERT INTO `consumer`(`consumer_id`, `consumer_first_name`, `consumer_last_name`, `consumer_phone_number`, `consumer_email`, `consumer_password`, `consumer_online_pin`, `bank_bank_ifsc`, `credit_points`, `activation`) VALUES ('15013','Suvethaa','E','9025069560','suve@gmail.com','zxcvb123!','0000','UNOL0000001', 100, 0);

INSERT INTO `req_consumer`(`r_consumer_first_name`, `r_consumer_last_name`, `r_consumer_phone_number`, `r_consumer_email`, `r_consumer_password`) VALUES ('Suvethaa', 'E', '9025069560','suve@gmail.com','zxcvb123!');

INSERT INTO `account_limit`(`account_type`, `account_minimum_limit`, `account_maximum_limit`) VALUES ('Savings', 2000, 500000);

INSERT INTO `consumer_account`(`account_number`, `account_account_type`, `consumer_consumer_id`, `account_balance`) VALUES ('3480001930', 'Savings', '15011', 5000);
INSERT INTO `consumer_account`(`account_number`, `account_account_type`, `consumer_consumer_id`, `account_balance`) VALUES ('3480102931', 'Savings', '15012', 3000);

INSERT INTO `payee`(`consumer_consumer_id`, `payee_name`, `payee_nick_name`, `payee_account_number`, `bank_bank_ifsc`) VALUES ('15011', 'Amrith', 'Amrith', '3480102931', 'UNOL0000001');
INSERT INTO `payee`(`consumer_consumer_id`, `payee_name`, `payee_nick_name`, `payee_account_number`, `bank_bank_ifsc`) VALUES ('15011', 'Kaleem', 'Kaleem', '2345678901', 'UNOL0000001');

INSERT INTO `favourites`(`consumer_consumer_id`, `payee_name`, `payee_nick_name`, `bank_from_ifsc`, `account_from_account_number`, `bank_to_ifsc`, `account_to_account_number`, `transaction_amount`) VALUES ('15011', 'Amrith', 'Amrith', 'UNOL0000001', '3480001930', 'UNOL0000001', '3480102931', 300);

-- INSERT INTO `consumer_transaction`(`transaction_time`, `bank_from_ifsc`, `account_from_account_number`, `bank_to_ifsc`, `account_to_account_number`, `transaction_transaction_method`, `transaction_amount`, `transaction_status`, `transaction_charge`) VALUES ('2022-06-14 16:13:20', 'UNOL0000001', '3480001930', 'UNOL0000001', '3480102931', 'IMPS', 100, 'Debit', 0);