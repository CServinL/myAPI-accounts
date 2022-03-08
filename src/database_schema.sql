CREATE DATABASE IF NOT EXISTS myapi-accounts;
USE myapi-accounts;
CREATE TABLE IF NOT EXISTS myapi-accounts.accounts (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    user VARCHAR(10) NOT NULL,
    pass VARCHAR(64) NOT NULL
);
