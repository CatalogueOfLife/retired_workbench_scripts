REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'ITIS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Assembly_ITIS`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Buffer_ITIS`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Piping_ITIS`.* TO 'WORMS'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'SpmWeb'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Assembly_SpmWeb`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Buffer_SpmWeb`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Piping_SpmWeb`.* TO 'WORMS'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'Fishbase'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Assembly_FishBase`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Buffer_FishBase`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Piping_FishBase`.* TO 'WORMS'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Assembly_WoRMS_Asteroidea`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Buffer_WoRMS_Asteroidea`.* TO 'WORMS'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `Piping_WoRMS_Asteroidea`.* TO 'WORMS'@'localhost';

