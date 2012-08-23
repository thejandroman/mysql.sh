CREATE DATABASE IF NOT EXISTS mysqlshTest;

CREATE TABLE IF NOT EXISTS mysqlshTest.`unitTest1` (
`id` INT (11) NOT NULL AUTO_INCREMENT,
`string` VARCHAR(100) NOT NULL,
`date` TEXT NOT NULL,
PRIMARY KEY (`id`)
) ENGINE = MyISAM DEFAULT CHARSET = latin1;

insert ignore into mysqlshTest.unitTest1 (string,date) VALUES ('this Has Spaces',NOW());
insert ignore into mysqlshTest1.unitTest1 (string,date) VALUES ('thisHasNoSpaces',NOW());
