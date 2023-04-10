-- -----------------------------------------------------
-- Schema HOADB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `HOADB` ;

-- -----------------------------------------------------
-- Schema HOADB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HOADB` DEFAULT CHARACTER SET utf8 ;
USE `HOADB` ;

-- -----------------------------------------------------
-- Table `HOADB`.`ref_collectiondays`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`ref_collectiondays` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`ref_collectiondays` (
  `days` INT(2) NOT NULL,
  PRIMARY KEY (`days`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`ref_regions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`ref_regions` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`ref_regions` (
  `regions` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`regions`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`provinces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`provinces` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`provinces` (
  `province` VARCHAR(45) NOT NULL,
  `region` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`province`),
  INDEX `FKAMELIA01_idx` (`region` ASC) VISIBLE,
  CONSTRAINT `FKAMELIA01`
    FOREIGN KEY (`region`)
    REFERENCES `HOADB`.`ref_regions` (`regions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`zipcodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`zipcodes` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`zipcodes` (
  `barangay` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`barangay`, `city`, `province`),
  INDEX `FKNORM06_idx` (`province` ASC) VISIBLE,
  CONSTRAINT `FKNORM06`
    FOREIGN KEY (`province`)
    REFERENCES `HOADB`.`provinces` (`province`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`hoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`hoa` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`hoa` (
  `hoa_name` VARCHAR(45) NOT NULL,
  `ofcaddr_streetno` VARCHAR(10) NOT NULL,
  `ofcaddr_street` VARCHAR(45) NOT NULL,
  `ofcaddr_barangay` VARCHAR(45) NOT NULL,
  `ofcaddr_city` VARCHAR(45) NOT NULL,
  `ofcaddr_province` VARCHAR(45) NOT NULL,
  `ofcaddr_lattitude` DECIMAL(7,4) NOT NULL,
  `ofcaddr_longitude` DECIMAL(7,2) NOT NULL,
  `year_establishment` DATE NOT NULL,
  `website` VARCHAR(45) NULL,
  `subdivision_name` VARCHAR(45) NOT NULL,
  `req_scannedarticles` VARCHAR(45) NULL,
  `req_notarizedbylaws` VARCHAR(45) NULL,
  `req_minutes` VARCHAR(45) NULL,
  `req_attendance` VARCHAR(45) NULL,
  `req_certification` VARCHAR(45) NULL,
  `req_codeofethics` VARCHAR(45) NULL,
  `req_regularmonthly` DECIMAL(9,2) NULL,
  `req_collectionday` INT(2) NOT NULL COMMENT 'Checking the \nintegrity of the \ndomain values is \nagreed to be \nhandled by the \nDB Application\n',
  PRIMARY KEY (`hoa_name`),
  INDEX `FK003_idx` (`req_collectionday` ASC) VISIBLE,
  INDEX `FKNORM08_idx` (`ofcaddr_barangay` ASC, `ofcaddr_city` ASC, `ofcaddr_province` ASC) VISIBLE,
  CONSTRAINT `FK003`
    FOREIGN KEY (`req_collectionday`)
    REFERENCES `HOADB`.`ref_collectiondays` (`days`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKNORM08`
    FOREIGN KEY (`ofcaddr_barangay` , `ofcaddr_city` , `ofcaddr_province`)
    REFERENCES `HOADB`.`zipcodes` (`barangay` , `city` , `province`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`hoa_geninfosheets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`hoa_geninfosheets` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`hoa_geninfosheets` (
  `hoa_name` VARCHAR(45) NOT NULL,
  `gen_infosheet` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`hoa_name`, `gen_infosheet`),
  CONSTRAINT `FK001`
    FOREIGN KEY (`hoa_name`)
    REFERENCES `HOADB`.`hoa` (`hoa_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`people` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`people` (
  `peopleid` INT(4) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `email` VARCHAR(45) NULL,
  `facebook` VARCHAR(45) NULL,
  `picturefile` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  PRIMARY KEY (`peopleid`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `picturefile_UNIQUE` (`picturefile` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`homeowner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`homeowner` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`homeowner` (
  `ho_id` INT(4) NOT NULL,
  `hostart_date` DATE NOT NULL,
  `undertaking` TINYINT(1) NOT NULL,
  `want_member` TINYINT(1) NOT NULL,
  `other_streetno` VARCHAR(45) NULL,
  `other_street` VARCHAR(45) NULL,
  `other_barangay` VARCHAR(45) NULL,
  `other_city` VARCHAR(45) NULL,
  `other_province` VARCHAR(45) NULL,
  `other_longitude` DECIMAL(7,4) NULL,
  `other_lattitude` DECIMAL(7,4) NULL,
  `other_email` VARCHAR(45) NULL,
  `other_mobile` BIGINT(10) NULL,
  PRIMARY KEY (`ho_id`),
  UNIQUE INDEX `other_email_UNIQUE` (`other_email` ASC) VISIBLE,
  UNIQUE INDEX `other_mobile_UNIQUE` (`other_mobile` ASC) VISIBLE,
  INDEX `FKNORM03_idx` (`other_barangay` ASC, `other_city` ASC, `other_province` ASC) VISIBLE,
  CONSTRAINT `FKSENATOR05`
    FOREIGN KEY (`ho_id`)
    REFERENCES `HOADB`.`people` (`peopleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKNORM03`
    FOREIGN KEY (`other_barangay` , `other_city` , `other_province`)
    REFERENCES `HOADB`.`zipcodes` (`barangay` , `city` , `province`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`household`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`household` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`household` (
  `household_id` INT(4) NOT NULL,
  PRIMARY KEY (`household_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`properties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`properties` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`properties` (
  `property_code` VARCHAR(10) NOT NULL,
  `hoa_name` VARCHAR(45) NOT NULL,
  `size` DECIMAL(6,2) NOT NULL,
  `turnover_date` DATE NULL,
  `ho_id` INT(4) NULL,
  `household_id` INT(4) NULL,
  PRIMARY KEY (`property_code`, `hoa_name`),
  INDEX `FKBENSON03_idx` (`hoa_name` ASC) VISIBLE,
  INDEX `FKBENSON04_idx` (`ho_id` ASC) VISIBLE,
  INDEX `FKJASON05_idx` (`household_id` ASC) VISIBLE,
  UNIQUE INDEX `household_id_UNIQUE` (`household_id` ASC) VISIBLE,
  CONSTRAINT `FKBENSON03`
    FOREIGN KEY (`hoa_name`)
    REFERENCES `HOADB`.`hoa` (`hoa_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKBENSON04`
    FOREIGN KEY (`ho_id`)
    REFERENCES `HOADB`.`homeowner` (`ho_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKJASON05`
    FOREIGN KEY (`household_id`)
    REFERENCES `HOADB`.`household` (`household_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`residents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`residents` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`residents` (
  `resident_id` INT(4) NOT NULL,
  `renter` TINYINT(1) NOT NULL,
  `relationship` VARCHAR(45) NOT NULL,
  `undertaking` TINYINT(1) NOT NULL,
  `authorized` ENUM('Yes', 'No') NOT NULL,
  `household_id` INT(4) NULL,
  `last_update` DATE NOT NULL,
  PRIMARY KEY (`resident_id`),
  INDEX `FKGABRIEL01_idx` (`household_id` ASC) VISIBLE,
  CONSTRAINT `FKGABRIEL01`
    FOREIGN KEY (`household_id`)
    REFERENCES `HOADB`.`household` (`household_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKSENATOR06`
    FOREIGN KEY (`resident_id`)
    REFERENCES `HOADB`.`people` (`peopleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`ref_positions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`ref_positions` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`ref_positions` (
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`position`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`person` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`person` (
  `name` VARCHAR(45) NOT NULL,
  `mobileno` BIGINT(10) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `mobileno_UNIQUE` (`mobileno` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`elections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`elections` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`elections` (
  `election_date` DATE NOT NULL,
  `election_venue` VARCHAR(45) NOT NULL,
  `quorum` TINYINT(1) NOT NULL,
  `outsider_wname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`election_date`),
  INDEX `FKNORM20_idx` (`outsider_wname` ASC) VISIBLE,
  CONSTRAINT `FKNORM20`
    FOREIGN KEY (`outsider_wname`)
    REFERENCES `HOADB`.`person` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`officer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`officer` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`officer` (
  `ho_id` INT(4) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `election_date` DATE NOT NULL,
  `availability_time` ENUM('M', 'A') NOT NULL COMMENT 'M -Morning\nA - Afternoon\n',
  `M` TINYINT(1) NOT NULL,
  `T` TINYINT(1) NOT NULL,
  `W` TINYINT(1) NOT NULL,
  `H` TINYINT(1) NOT NULL,
  `F` TINYINT(1) NOT NULL,
  `S` TINYINT(1) NOT NULL,
  `N` TINYINT(1) NOT NULL,
  INDEX `FKBENSON01_idx` (`position` ASC) VISIBLE,
  PRIMARY KEY (`ho_id`, `position`, `election_date`),
  INDEX `FKNORM01_idx` (`election_date` ASC) VISIBLE,
  CONSTRAINT `FKBENSON01`
    FOREIGN KEY (`position`)
    REFERENCES `HOADB`.`ref_positions` (`position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKGABRIEL06`
    FOREIGN KEY (`ho_id`)
    REFERENCES `HOADB`.`homeowner` (`ho_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKNORM01`
    FOREIGN KEY (`election_date`)
    REFERENCES `HOADB`.`elections` (`election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`ref_ornumbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`ref_ornumbers` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`ref_ornumbers` (
  `ornum` INT(9) NOT NULL,
  PRIMARY KEY (`ornum`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`resident_idcards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`resident_idcards` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`resident_idcards` (
  `card_number` INT(4) NOT NULL,
  `requested_date` DATE NOT NULL,
  `request_reason` VARCHAR(45) NOT NULL,
  `provided_date` DATE NULL,
  `ornum` INT(9) NULL,
  `fee` DECIMAL(9,2) NOT NULL,
  `resident_id` INT(4) NOT NULL,
  `cancelled` TINYINT(1) NOT NULL,
  `ofcr_hoid` INT(4) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `election_date` DATE NOT NULL,
  UNIQUE INDEX `ORnum_UNIQUE` (`ornum` ASC) VISIBLE,
  PRIMARY KEY (`card_number`),
  INDEX `FKGABRIEL02_idx` (`resident_id` ASC) VISIBLE,
  INDEX `FKSENATOR01_idx` (`ofcr_hoid` ASC, `position` ASC, `election_date` ASC) VISIBLE,
  CONSTRAINT `FKJERICHO01`
    FOREIGN KEY (`ornum`)
    REFERENCES `HOADB`.`ref_ornumbers` (`ornum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKGABRIEL02`
    FOREIGN KEY (`resident_id`)
    REFERENCES `HOADB`.`residents` (`resident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKSENATOR01`
    FOREIGN KEY (`ofcr_hoid` , `position` , `election_date`)
    REFERENCES `HOADB`.`officer` (`ho_id` , `position` , `election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`people_mobile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`people_mobile` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`people_mobile` (
  `peopleid` INT(4) NOT NULL,
  `mobileno` BIGINT(10) NOT NULL,
  PRIMARY KEY (`peopleid`, `mobileno`),
  CONSTRAINT `FKSENATOR10`
    FOREIGN KEY (`peopleid`)
    REFERENCES `HOADB`.`people` (`peopleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`assets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`assets` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`assets` (
  `asset_id` INT(4) NOT NULL,
  `asset_name` VARCHAR(45) NOT NULL,
  `asset_description` VARCHAR(45) NOT NULL,
  `acquisition_date` DATE NOT NULL,
  `forrent` TINYINT(1) NOT NULL,
  `asset_value` DECIMAL(9,2) NOT NULL,
  `type_asset` ENUM('P', 'E', 'F', 'O') NOT NULL COMMENT 'P - Property\nE - Equipment\nF - F&F\nO - Others\n',
  `status` ENUM('W', 'D', 'P', 'S', 'X') NOT NULL COMMENT 'W - Working\nD - Deterioted\nP - For Repair\nS - For Disposal\nX - Disposed',
  `loc_lattitude` DECIMAL(7,4) NOT NULL,
  `loc_longiture` DECIMAL(7,4) NOT NULL,
  `hoa_name` VARCHAR(45) NOT NULL,
  `enclosing_asset` INT(4) NULL,
  PRIMARY KEY (`asset_id`),
  INDEX `FKTYE05_idx` (`hoa_name` ASC) VISIBLE,
  INDEX `FKTYE07_idx` (`enclosing_asset` ASC) VISIBLE,
  CONSTRAINT `FKTYE05`
    FOREIGN KEY (`hoa_name`)
    REFERENCES `HOADB`.`hoa` (`hoa_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKTYE07`
    FOREIGN KEY (`enclosing_asset`)
    REFERENCES `HOADB`.`assets` (`asset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`officer_presidents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`officer_presidents` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`officer_presidents` (
  `ho_id` INT(4) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `election_date` DATE NOT NULL,
  PRIMARY KEY (`ho_id`, `position`, `election_date`),
  CONSTRAINT `FKTYE50`
    FOREIGN KEY (`ho_id` , `position` , `election_date`)
    REFERENCES `HOADB`.`officer` (`ho_id` , `position` , `election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`asset_transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`asset_transactions` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`asset_transactions` (
  `asset_id` INT(4) NOT NULL,
  `transaction_date` DATE NOT NULL,
  `trans_hoid` INT(4) NOT NULL,
  `trans_position` VARCHAR(45) NOT NULL,
  `trans_electiondate` DATE NOT NULL,
  `isdeleted` TINYINT(1) NOT NULL,
  `approval_hoid` INT(4) NULL,
  `approval_position` VARCHAR(45) NULL,
  `approval_electiondate` DATE NULL,
  `ornum` INT(9) NULL,
  `transaction_type` ENUM('R', 'T', 'A') NOT NULL,
  PRIMARY KEY (`asset_id`, `transaction_date`),
  INDEX `FKLANZ15_idx` (`trans_hoid` ASC, `trans_position` ASC, `trans_electiondate` ASC) VISIBLE,
  INDEX `FKLANZ16_idx` (`approval_hoid` ASC, `approval_position` ASC, `approval_electiondate` ASC) VISIBLE,
  INDEX `FKLANZ17_idx` (`ornum` ASC) VISIBLE,
  UNIQUE INDEX `ornum_UNIQUE` (`ornum` ASC) VISIBLE,
  CONSTRAINT `FKLANZ01`
    FOREIGN KEY (`asset_id`)
    REFERENCES `HOADB`.`assets` (`asset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKLANZ15`
    FOREIGN KEY (`trans_hoid` , `trans_position` , `trans_electiondate`)
    REFERENCES `HOADB`.`officer` (`ho_id` , `position` , `election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKLANZ16`
    FOREIGN KEY (`approval_hoid` , `approval_position` , `approval_electiondate`)
    REFERENCES `HOADB`.`officer_presidents` (`ho_id` , `position` , `election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKLANZ17`
    FOREIGN KEY (`ornum`)
    REFERENCES `HOADB`.`ref_ornumbers` (`ornum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`asset_activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`asset_activity` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`asset_activity` (
  `asset_id` INT(4) NOT NULL,
  `activity_date` DATE NOT NULL,
  `activity_description` VARCHAR(45) NULL,
  `tent_start` DATE NULL,
  `tent_end` DATE NULL,
  `act_start` DATE NULL,
  `act_end` DATE NULL,
  `cost` DECIMAL(9,2) NULL,
  `status` ENUM('S', 'O', 'C') NOT NULL COMMENT 'S - Scheduled\nO - Ongoing\nC - Completed\n',
  PRIMARY KEY (`asset_id`, `activity_date`),
  CONSTRAINT `FKLANZ11`
    FOREIGN KEY (`asset_id` , `activity_date`)
    REFERENCES `HOADB`.`asset_transactions` (`asset_id` , `transaction_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`monthly_billing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`monthly_billing` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`monthly_billing` (
  `bill_id` INT NOT NULL,
  `month` INT(2) NOT NULL,
  `year` INT(4) NOT NULL,
  `generated_date` DATE NOT NULL,
  `deduction` FLOAT NULL,
  `collection_day` INT(2) NULL,
  `regular_dues` FLOAT NOT NULL,
  `unpaid` FLOAT NULL,
  `discount` FLOAT NULL,
  `total` INT NOT NULL,
  `resident_id` INT NOT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `fk_resident_id_1_idx` (`resident_id` ASC) VISIBLE,
  CONSTRAINT `fk_resident_id_1`
    FOREIGN KEY (`resident_id`)
    REFERENCES `HOADB`.`residents` (`resident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`incident_report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`incident_report` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`incident_report` (
  `incident_id` INT NOT NULL,
  `incident_date` DATE NOT NULL,
  `incident_disc` VARCHAR(100) NOT NULL,
  `penalty` FLOAT NOT NULL,
  `rule_no` INT NOT NULL,
  `hoa_officer` INT NOT NULL,
  `bill_id` INT NOT NULL,
  PRIMARY KEY (`incident_id`),
  INDEX `FKBILLID_idx` (`bill_id` ASC) VISIBLE,
  INDEX `FKHOAOFFICER1_idx` (`hoa_officer` ASC) VISIBLE,
  CONSTRAINT `FKBILLID`
    FOREIGN KEY (`bill_id`)
    REFERENCES `HOADB`.`monthly_billing` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKHOAOFFICER1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `HOADB`.`officer` (`ho_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`asset_transfer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`asset_transfer` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`asset_transfer` (
  `asset_id` INT(4) NOT NULL,
  `schedule_date` DATE NOT NULL,
  `act_date` DATE NULL,
  `source_lattitude` DECIMAL(7,4) NOT NULL,
  `source_longitude` DECIMAL(7,4) NOT NULL,
  `dest_latittude` DECIMAL(7,4) NOT NULL,
  `dest_longitude` DECIMAL(7,4) NOT NULL,
  `transfer_cost` DECIMAL(9,2) NULL,
  `status` ENUM('S', 'O', 'C') NOT NULL COMMENT 'S - Scheduled\nO - Ongoing\nC - Completed\n',
  `completename` VARCHAR(45) NOT NULL,
  `incident_id` INT NULL,
  INDEX `FKNORM35_idx` (`completename` ASC) VISIBLE,
  PRIMARY KEY (`asset_id`, `schedule_date`),
  INDEX `FKINCIDENT2_idx` (`incident_id` ASC) VISIBLE,
  CONSTRAINT `FKNORM88`
    FOREIGN KEY (`completename`)
    REFERENCES `HOADB`.`person` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKAT07`
    FOREIGN KEY (`asset_id` , `schedule_date`)
    REFERENCES `HOADB`.`asset_transactions` (`asset_id` , `transaction_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKINCIDENT2`
    FOREIGN KEY (`incident_id`)
    REFERENCES `HOADB`.`incident_report` (`incident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`asset_rentals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`asset_rentals` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`asset_rentals` (
  `asset_id` INT(4) NOT NULL,
  `rental_date` DATE NOT NULL,
  `reservation_date` DATE NOT NULL,
  `resident_id` INT(4) NOT NULL,
  `rental_amount` DECIMAL(9,2) NULL,
  `discount` DECIMAL(9,2) NULL,
  `status` ENUM('R', 'C', 'O', 'N') NOT NULL COMMENT 'R - Reserved\nC - Cancelled\nO - On-Rent\nN - Returned\n',
  `inspection_details` LONGTEXT NULL,
  `assessed_value` DECIMAL(9,2) NULL,
  `accept_hoid` INT(4) NULL,
  `accept_position` VARCHAR(45) NULL,
  `accept_electiondate` DATE NULL,
  `return_date` DATE NULL,
  `incident_id` INT NULL,
  PRIMARY KEY (`asset_id`, `rental_date`),
  INDEX `FKTYE10_idx` (`accept_hoid` ASC, `accept_position` ASC, `accept_electiondate` ASC) VISIBLE,
  INDEX `FKTYE63_idx` (`resident_id` ASC) VISIBLE,
  INDEX `FKINCIDENT1_idx` (`incident_id` ASC) VISIBLE,
  CONSTRAINT `FKTYE10`
    FOREIGN KEY (`accept_hoid` , `accept_position` , `accept_electiondate`)
    REFERENCES `HOADB`.`officer` (`ho_id` , `position` , `election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKTYE63`
    FOREIGN KEY (`resident_id`)
    REFERENCES `HOADB`.`residents` (`resident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKLANZ10`
    FOREIGN KEY (`asset_id` , `rental_date`)
    REFERENCES `HOADB`.`asset_transactions` (`asset_id` , `transaction_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKINCIDENT1`
    FOREIGN KEY (`incident_id`)
    REFERENCES `HOADB`.`incident_report` (`incident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`donors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`donors` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`donors` (
  `donorname` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`donorname`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`asset_donations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`asset_donations` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`asset_donations` (
  `donation_id` INT(4) NOT NULL,
  `donor_completename` VARCHAR(45) NOT NULL,
  `donation_formfile` VARCHAR(45) NULL,
  `date_donation` DATE NOT NULL,
  `accept_hoid` INT(4) NOT NULL,
  `accept_position` VARCHAR(45) NOT NULL,
  `accept_electiondate` DATE NOT NULL,
  `isdeleted` TINYINT(1) NOT NULL,
  `approval_hoid` INT(4) NULL,
  `approval_position` VARCHAR(45) NULL,
  `approval_electiondate` DATE NULL,
  PRIMARY KEY (`donation_id`),
  INDEX `FKTYE40_idx` (`accept_hoid` ASC, `accept_position` ASC, `accept_electiondate` ASC) VISIBLE,
  INDEX `FKTYE68_idx` (`approval_hoid` ASC, `approval_position` ASC, `approval_electiondate` ASC) VISIBLE,
  INDEX `FKNORM30_idx` (`donor_completename` ASC) VISIBLE,
  CONSTRAINT `FKTYE40`
    FOREIGN KEY (`accept_hoid` , `accept_position` , `accept_electiondate`)
    REFERENCES `HOADB`.`officer` (`ho_id` , `position` , `election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKTYE68`
    FOREIGN KEY (`approval_hoid` , `approval_position` , `approval_electiondate`)
    REFERENCES `HOADB`.`officer_presidents` (`ho_id` , `position` , `election_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKNORM30`
    FOREIGN KEY (`donor_completename`)
    REFERENCES `HOADB`.`donors` (`donorname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`donated_assets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`donated_assets` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`donated_assets` (
  `donation_id` INT(4) NOT NULL,
  `asset_id` INT(4) NOT NULL,
  `amount_donated` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`donation_id`, `asset_id`),
  INDEX `FKTYE30_idx` (`asset_id` ASC) VISIBLE,
  CONSTRAINT `FKTYE30`
    FOREIGN KEY (`asset_id`)
    REFERENCES `HOADB`.`assets` (`asset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKTYE31`
    FOREIGN KEY (`donation_id`)
    REFERENCES `HOADB`.`asset_donations` (`donation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`donation_pictures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`donation_pictures` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`donation_pictures` (
  `donation_id` INT(4) NOT NULL,
  `picturefile` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`donation_id`, `picturefile`),
  CONSTRAINT `FKTYE70`
    FOREIGN KEY (`donation_id`)
    REFERENCES `HOADB`.`asset_donations` (`donation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`bill_payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`bill_payment` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`bill_payment` (
  `orno` INT NOT NULL,
  `payment_date` DATE NOT NULL,
  `residentid` INT NOT NULL,
  `hoa_officer` INT NOT NULL,
  `bill_id` INT NOT NULL,
  `payment_type` ENUM('Full', 'Partial', 'Advanced') NOT NULL,
  `payment_amount` FLOAT NOT NULL,
  PRIMARY KEY (`orno`),
  INDEX `FKRESID_idx` (`residentid` ASC) VISIBLE,
  INDEX `FKHOAOFFICER2_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `FKBILL1_idx` (`bill_id` ASC) VISIBLE,
  CONSTRAINT `FKORNO1`
    FOREIGN KEY (`orno`)
    REFERENCES `HOADB`.`ref_ornumbers` (`ornum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKRESID`
    FOREIGN KEY (`residentid`)
    REFERENCES `HOADB`.`residents` (`resident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKHOAOFFICER2`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `HOADB`.`officer` (`ho_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKBILL1`
    FOREIGN KEY (`bill_id`)
    REFERENCES `HOADB`.`monthly_billing` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HOADB`.`evidence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HOADB`.`evidence` ;

CREATE TABLE IF NOT EXISTS `HOADB`.`evidence` (
  `evidence_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `desc` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `accepting_officer` INT NOT NULL,
  `resident_id` INT NOT NULL,
  `incident_id` INT NOT NULL,
  PRIMARY KEY (`evidence_id`),
  INDEX `FKACCEPTOFC_idx` (`accepting_officer` ASC) VISIBLE,
  INDEX `FKRESID3_idx` (`resident_id` ASC) VISIBLE,
  INDEX `FKINCID_idx` (`incident_id` ASC) VISIBLE,
  CONSTRAINT `FKACCEPTOFC`
    FOREIGN KEY (`accepting_officer`)
    REFERENCES `HOADB`.`officer` (`ho_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKRESID3`
    FOREIGN KEY (`resident_id`)
    REFERENCES `HOADB`.`residents` (`resident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKINCID`
    FOREIGN KEY (`incident_id`)
    REFERENCES `HOADB`.`incident_report` (`incident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


# SET SQL_MODE=@OLD_SQL_MODE;
# SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
# SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `HOADB`.`ref_collectiondays`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (1);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (2);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (3);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (4);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (5);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (6);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (7);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (8);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (9);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (10);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (11);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (12);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (13);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (14);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (15);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (16);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (17);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (18);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (19);
INSERT INTO `HOADB`.`ref_collectiondays` (`days`) VALUES (20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`ref_regions`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`ref_regions` (`regions`) VALUES ('NCR');
INSERT INTO `HOADB`.`ref_regions` (`regions`) VALUES ('IV-A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`provinces`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`provinces` (`province`, `region`) VALUES ('National Capital Region', 'NCR');
INSERT INTO `HOADB`.`provinces` (`province`, `region`) VALUES ('Oriental Mindoro', 'IV-A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`zipcodes`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`zipcodes` (`barangay`, `city`, `province`, `zipcode`) VALUES ('Tunasan', 'Muntinlupa', 'National Capital Region', '1770');
INSERT INTO `HOADB`.`zipcodes` (`barangay`, `city`, `province`, `zipcode`) VALUES ('Alabang', 'Muntinlupa', 'National Capital Region', '1775');
INSERT INTO `HOADB`.`zipcodes` (`barangay`, `city`, `province`, `zipcode`) VALUES ('Poblacion', 'Calapan', 'Oriental Mindoro', '1800');
INSERT INTO `HOADB`.`zipcodes` (`barangay`, `city`, `province`, `zipcode`) VALUES ('Bayanan', 'Lamesa', 'Oriental Mindoro', '1801');
INSERT INTO `HOADB`.`zipcodes` (`barangay`, `city`, `province`, `zipcode`) VALUES ('Bayanan', 'Muntinlupa', 'National Capital Region', '1771');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`hoa`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`hoa` (`hoa_name`, `ofcaddr_streetno`, `ofcaddr_street`, `ofcaddr_barangay`, `ofcaddr_city`, `ofcaddr_province`, `ofcaddr_lattitude`, `ofcaddr_longitude`, `year_establishment`, `website`, `subdivision_name`, `req_scannedarticles`, `req_notarizedbylaws`, `req_minutes`, `req_attendance`, `req_certification`, `req_codeofethics`, `req_regularmonthly`, `req_collectionday`) VALUES ('SMH', '10', 'Jade St', 'Bayanan', 'Muntinlupa', 'National Capital Region', 10.456, 20.324, '2005-05-04', 'www.smh.com', 'Saint Mary\'s Homes', 'smh_articles.pdf', 'smh_bylaws.pdf', 'smh_minutes.pdf', 'smh_attendance.pdf', 'smh_certification.pdf', 'smh_codeofethics.pdf', 350.00, 18);
INSERT INTO `HOADB`.`hoa` (`hoa_name`, `ofcaddr_streetno`, `ofcaddr_street`, `ofcaddr_barangay`, `ofcaddr_city`, `ofcaddr_province`, `ofcaddr_lattitude`, `ofcaddr_longitude`, `year_establishment`, `website`, `subdivision_name`, `req_scannedarticles`, `req_notarizedbylaws`, `req_minutes`, `req_attendance`, `req_certification`, `req_codeofethics`, `req_regularmonthly`, `req_collectionday`) VALUES ('SJH', '15', 'Chico St', 'Bayanan', 'Muntinlupa', 'National Capital Region', 14.234, 29.293, '2003-12-13', 'www.sjh.com', 'Sait Joseph Homes', 'sjh_articles.pdf', 'sjh_bylaws.pdf', 'sjh_minutes.pdf', 'sjh_attendance.pdf', 'sjh_certification.pdf', 'sjh_codeofethics.pdf', 250, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`hoa_geninfosheets`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property01.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh__property02.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property03.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property04.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property05.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property06.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property07.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property08.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property09.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property10.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property11.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property12.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property13.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property14.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SMH', 'smh_property15.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property01.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property02.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property03.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property04.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property05.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property06.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property07.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property08.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property09.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property10.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property11.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property12.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property13.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property14.pdf');
INSERT INTO `HOADB`.`hoa_geninfosheets` (`hoa_name`, `gen_infosheet`) VALUES ('SJH', 'sjh_property15.pdf');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`people`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9001, 'Mendoza', 'Rose', 'F', 'rose.m@gmail.com', 'www.facebook.com/rose.m', 'rosem.png', '1990-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9002, 'Leandro', 'George', 'M', 'george.l@gmail.com', 'www.facebook.com/george.l', 'georgel.png', '1990-01-02');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9003, 'Hamil', 'Dan', 'M', 'dan.h@gmail.com', 'www.facebook.com/dan.h', 'danh.png', '1990-01-03');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9004, 'Robles', 'Esteban', 'M', 'esteban.r@gmail.com', 'www.facebook.com/esteban.r', 'estebanr.png', '1991-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9005, 'Go', 'Sara', 'F', 'sara.g@gmail.com', 'www.facebook.com/sara.g', 'sarag.png', '1992-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9006, 'Yulo', 'Leo', 'M', 'leo.y@gmail.com', 'www.facebook.com/leo.y', 'leoy.png', '1993-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9007, 'Policarpio', 'Paul', 'M', 'paul,p@gmail.com', 'www.facebook.com/paul.p', 'paulp.png', '1994-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9008, 'Reyes', 'Edward', 'M', 'edward.r@gmail.com', 'www.facebook.com/edward.r', 'edwardr.png', '1990-01-04');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9009, 'Wong', 'Sandro', 'M', 'sandro.w@gmail.com', 'www.facebook.com/sandro.w', 'sandrow.png', '1990-01-05');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9010, 'Que', 'Hadrian', 'M', 'hadrian.q@gmail.com', 'www.facebook.com/hadrian.q', 'hadrianq.png', '1990-01-06');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9011, 'Tang', 'Kathrine', 'F', 'katrine.t@gmail.com', 'www.facebook.com/katrine.t', 'katrinet.png', '1993-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9012, 'Flores', 'Carlos', 'M', 'carlos.f@gmail.com', 'www.facebook.com/carlos.f', 'carlosf.png', '1994-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9013, 'Danilo', 'Vivian', 'F', 'vivian.d@gmail.com', 'www.facebook.com/vivan.d', 'viviand.png', '1995-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9014, 'Valenzuela', 'Boying', 'M', 'b.valenzuela@gmail.com', 'www.facebook.com/b.valenzuela', 'bvalenzuela.png', '1997-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9015, 'Baco', 'Manolo', 'M', 'manolo.b@gmail.com', 'www.facebook.com/manolo.b', 'manolob.png', '1998-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9016, 'Silang', 'Renato', 'M', 'renato.s@gmail.com', 'www.facebook.com/renato.s', 'renatos.png', '1990-03-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9017, 'Magtibay', 'Inigo', 'M', 'inigo.m@gmail.com', 'www.facebook.com/inigo.m', 'inigom.png', '1999-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9018, 'Jose', 'Hendrick', 'M', 'hendrick.j@gmail.com', 'www.facebook.com/hendrick.j', 'hendrickj.png', '1996-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9019, 'Ko', 'George', 'M', NULL, 'www.facebook.com/george.k', 'georgek.png', '1995-01-01');
INSERT INTO `HOADB`.`people` (`peopleid`, `lastname`, `firstname`, `gender`, `email`, `facebook`, `picturefile`, `birthday`) VALUES (9020, 'Lamsin', 'Ryan', 'M', NULL, 'www.facebook.com/ryan.l', 'ryanl.png', '1992-01-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`homeowner`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9001, '2002-05-04', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9002, '2002-05-02', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9003, '2002-02-01', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9004, '2002-04-04', 1, 1, '24', 'Macopa St', 'Alabang', 'Muntinlupa', 'National Capital Region', 13.233, 15.235, 'tanya@gmail.com', 9999203321);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9005, '2002-05-14', 1, 1, '30', 'National Highway', 'Tunasan', 'Muntinlupa', 'National Capital Region', 24.5, 23.233, 'francine@gmail.com', 9923090992);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9006, '2002-02-05', 1, 1, '31', 'Apple St.', 'Tunasan', 'Muntinlupa', 'National Capital Region', NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9007, '2002-05-06', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9008, '2002-04-12', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9009, '2002-04-05', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9010, '2022-03-15', 1, 1, '19', 'National Road', 'Poblacion', 'Calapan', 'Oriental Mindoro', NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9011, '2022-03-12', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9012, '2022-04-01', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9013, '2022-04-10', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9014, '2022-02-19', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `HOADB`.`homeowner` (`ho_id`, `hostart_date`, `undertaking`, `want_member`, `other_streetno`, `other_street`, `other_barangay`, `other_city`, `other_province`, `other_longitude`, `other_lattitude`, `other_email`, `other_mobile`) VALUES (9015, '2022-03-27', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`household`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`household` (`household_id`) VALUES (6001);
INSERT INTO `HOADB`.`household` (`household_id`) VALUES (6002);
INSERT INTO `HOADB`.`household` (`household_id`) VALUES (6003);
INSERT INTO `HOADB`.`household` (`household_id`) VALUES (6004);
INSERT INTO `HOADB`.`household` (`household_id`) VALUES (6005);
INSERT INTO `HOADB`.`household` (`household_id`) VALUES (6006);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`properties`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B01L01', 'SJH', 25, '2003-01-01', 9001, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B01L02', 'SJH', 25, '2003-01-02', 9001, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B01L03', 'SJH', 25, '2003-01-03', 9002, 6001);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B01L04', 'SJH', 25, '2003-01-04', 9002, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B01L05', 'SJH', 25, '2003-01-05', 9001, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B02L01', 'SJH', 25, '2003-01-05', 9004, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B02L02', 'SJH', 25, '2003-01-04', 9005, 6002);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B02L03', 'SJH', 25, '2003-01-03', 9006, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B02L04', 'SJH', 25, '2003-01-02', 9001, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B02L05', 'SJH', 25, '2003-01-01', 9004, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B03L01', 'SJH', 25, '2003-01-01', 9006, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B03L02', 'SJH', 25, '2003-01-01', 9007, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B03L03', 'SJH', 25, '2003-01-05', 9008, 6003);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B03L04', 'SJH', 25, '2003-01-04', 9009, 6004);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B03L05', 'SJH', 25, '2003-01-03', 9011, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B01L01', 'SMH', 40, '2003-01-02', 9012, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L01', 'SJH', 30, '2003-01-02', 9013, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L02', 'SJH', 30, '2003-01-05', 9014, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L03', 'SJH', 30, '2003-01-03', 9003, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L05', 'SJH', 40, '2003-01-03', 9010, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L06', 'SJH', 25, '2003-01-01', 9015, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L07', 'SJH', 30, '2003-01-01', 9010, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L08', 'SJH', 25, '2003-01-01', 9011, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L09', 'SJH', 25, '2003-01-05', 9012, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L10', 'SJH', 25, '2003-01-03', 9013, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L11', 'SJH', 25, '2003-01-01', 9014, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L12', 'SJH', 100, '2003-01-05', 9015, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L13', 'SJH', 40, '2003-01-03', 9006, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L14', 'SJH', 40, '2003-01-04', 9007, NULL);
INSERT INTO `HOADB`.`properties` (`property_code`, `hoa_name`, `size`, `turnover_date`, `ho_id`, `household_id`) VALUES ('B04L15', 'SJH', 40, '2003-01-01', 9003, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`residents`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9002, 0, 'None', 1, 'Yes', 6001, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9008, 1, 'None', 1, 'Yes', 6003, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9009, 1, 'None', 1, 'No', 6004, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9018, 0, 'Relative', 1, 'No', 6006, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9005, 1, 'None', 1, 'Yes', 6002, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9016, 1, 'Friend', 1, 'No', 6005, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9017, 0, 'Friend', 1, 'No', 6006, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9019, 0, 'Relative', 1, 'No', 6002, '2022-06-10');
INSERT INTO `HOADB`.`residents` (`resident_id`, `renter`, `relationship`, `undertaking`, `authorized`, `household_id`, `last_update`) VALUES (9020, 1, 'Landlord', 1, 'Yes', 6003, '2022-06-10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`ref_positions`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`ref_positions` (`position`) VALUES ('President');
INSERT INTO `HOADB`.`ref_positions` (`position`) VALUES ('Vice-President');
INSERT INTO `HOADB`.`ref_positions` (`position`) VALUES ('Treasurer');
INSERT INTO `HOADB`.`ref_positions` (`position`) VALUES ('Auditor');
INSERT INTO `HOADB`.`ref_positions` (`position`) VALUES ('Secretary');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`person`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`person` (`name`, `mobileno`) VALUES ('Jose Ignacio', 09817776666);
INSERT INTO `HOADB`.`person` (`name`, `mobileno`) VALUES ('Maria Estrella', 09816667777);
INSERT INTO `HOADB`.`person` (`name`, `mobileno`) VALUES ('Juan Estanislao', 09823335454);
INSERT INTO `HOADB`.`person` (`name`, `mobileno`) VALUES ('Kyle Rosalita', 09285443322);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`elections`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`elections` (`election_date`, `election_venue`, `quorum`, `outsider_wname`) VALUES ('2022-06-01', 'Clubhouse', 1, 'Jose Ignacio');
INSERT INTO `HOADB`.`elections` (`election_date`, `election_venue`, `quorum`, `outsider_wname`) VALUES ('2022-12-01', 'Gymnasium', 1, 'Maria Estrella');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`officer`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9001, 'President', '2022-06-10', '2022-12-10', '2022-06-01', 'A', 1, 1, 0, 0, 0, 1, 0);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9002, 'Vice-President', '2022-06-10', '2022-12-10', '2022-06-01', 'A', 0, 1, 0, 1, 0, 1, 1);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9003, 'Secretary', '2022-06-10', '2022-12-10', '2022-06-01', 'M', 0, 1, 1, 0, 0, 1, 0);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9004, 'Treasurer', '2022-06-10', '2022-12-10', '2022-06-01', 'M', 1, 1, 1, 1, 1, 0, 0);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9005, 'Auditor', '2022-06-10', '2022-12-10', '2022-06-01', 'M', 1, 1, 1, 1, 0, 0, 1);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9004, 'President', '2022-12-10', '2023-12-10', '2022-12-01', 'M', 1, 0, 0, 1, 0, 0, 1);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9003, 'Vice-President', '2022-12-10', '2023-12-10', '2022-12-01', 'M', 1, 0, 0, 1, 1, 1, 0);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9009, 'Secretary', '2023-01-10', '2023-12-10', '2022-12-01', 'A', 0, 1, 0, 1, 0, 0, 1);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9010, 'Treasurer', '2023-01-10', '2023-12-10', '2022-12-01', 'A', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9011, 'Auditor', '2022-12-10', '2023-12-10', '2022-12-01', 'M', 1, 1, 1, 1, 0, 1, 1);
INSERT INTO `HOADB`.`officer` (`ho_id`, `position`, `start_date`, `end_date`, `election_date`, `availability_time`, `M`, `T`, `W`, `H`, `F`, `S`, `N`) VALUES (9012, 'Auditor', '2022-06-10', '2022-12-10', '2022-06-01', 'M', 1, 1, 1, 1, 0, 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`ref_ornumbers`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000001);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000002);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000003);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000004);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000005);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000006);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000007);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000008);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000009);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000010);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000011);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000012);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000013);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000014);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000015);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000016);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000017);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000018);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000019);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000020);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000021);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000022);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000023);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000024);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000025);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000026);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000027);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000028);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000029);
INSERT INTO `HOADB`.`ref_ornumbers` (`ornum`) VALUES (3000030);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`resident_idcards`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`resident_idcards` (`card_number`, `requested_date`, `request_reason`, `provided_date`, `ornum`, `fee`, `resident_id`, `cancelled`, `ofcr_hoid`, `position`, `election_date`) VALUES (5201, '2022-11-03', 'Security', '2022-11-04', NULL, 0.0, 9002, 1, 9004, 'President', '2022-12-01');
INSERT INTO `HOADB`.`resident_idcards` (`card_number`, `requested_date`, `request_reason`, `provided_date`, `ornum`, `fee`, `resident_id`, `cancelled`, `ofcr_hoid`, `position`, `election_date`) VALUES (5202, '2022-11-05', 'Security', '2022-11-05', 3000002, 100, 9002, 0, 9004, 'President', '2022-12-01');
INSERT INTO `HOADB`.`resident_idcards` (`card_number`, `requested_date`, `request_reason`, `provided_date`, `ornum`, `fee`, `resident_id`, `cancelled`, `ofcr_hoid`, `position`, `election_date`) VALUES (5203, '2022-11-05', 'Barangay Identification', '2022-11-05', NULL, 0.00, 9016, 1, 9003, 'Vice-President', '2022-12-01');
INSERT INTO `HOADB`.`resident_idcards` (`card_number`, `requested_date`, `request_reason`, `provided_date`, `ornum`, `fee`, `resident_id`, `cancelled`, `ofcr_hoid`, `position`, `election_date`) VALUES (5204, '2022-11-10', 'Barangay Identification', '2022-11-15', 3000003, 100, 9016, 0, 9010, 'Treasurer', '2022-12-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`people_mobile`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9001, 9200000001);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9002, 9200000002);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9003, 9200000003);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9004, 9200000004);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9005, 9200000005);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9006, 9200000006);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9007, 9200000010);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9008, 9200000011);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9009, 9200000012);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9010, 9200000013);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9011, 9200000014);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9012, 9200000021);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9013, 9200000032);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9014, 9200000043);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9015, 9200000024);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9016, 9200000090);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9017, 9200000091);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9018, 9200000191);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9019, 9200000392);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9020, 9200000493);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9014, 9200000594);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9013, 9200000695);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9018, 9200000696);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9005, 9200000697);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9003, 9200000698);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9009, 9200000699);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9008, 9200000700);
INSERT INTO `HOADB`.`people_mobile` (`peopleid`, `mobileno`) VALUES (9005, 9200000763);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`assets`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5001, 'Chair', 'Upuang Duwende', '2022-01-01', 0, 100, 'F', 'W', 100.435, 100.436, 'SJH', NULL);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5002, 'Chair', 'Upuang Maliit', '2022-01-02', 0, 100, 'F', 'W', 100.435, 100.436, 'SJH', NULL);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5003, 'Chair', 'Upuang Malaki', '2022-01-01', 0, 100, 'F', 'W', 100.435, 100.436, 'SJH', NULL);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5004, 'Table', 'Lamesa', '2022-02-01', 0, 100, 'F', 'W', 101.435, 101.435, 'SJH', NULL);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5005, 'Meeting Room', 'Maritesan', '2022-02-01', 0, 100000, 'P', 'W', 101.435, 101.435, 'SJH', NULL);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5006, 'Conference Room', 'Malaking Maritesan', '2002-02-02', 0, 100000, 'P', 'W', 101.435, 101.435, 'SJH', NULL);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5007, 'TV', 'Television', '2022-01-04', 0, 50000, 'E', 'W', 101.435, 101.435, 'SJH', 5006);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5008, 'TV', 'Television', '2022-03-01', 1, 50000, 'E', 'W', 101.435, 101.437, 'SJH', NULL);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5009, 'Vase', 'Vase', '2022-05-01', 0, 350, 'O', 'W', 101.333, 101.333, 'SJH', 5006);
INSERT INTO `HOADB`.`assets` (`asset_id`, `asset_name`, `asset_description`, `acquisition_date`, `forrent`, `asset_value`, `type_asset`, `status`, `loc_lattitude`, `loc_longiture`, `hoa_name`, `enclosing_asset`) VALUES (5010, 'Vase', 'Vase', '2022-03-02', 1, 350, '0', 'W', 101.333, 101.333, 'SJH', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`officer_presidents`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`officer_presidents` (`ho_id`, `position`, `election_date`) VALUES (9001, 'President', '2022-06-01');
INSERT INTO `HOADB`.`officer_presidents` (`ho_id`, `position`, `election_date`) VALUES (9004, 'President', '2022-12-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`asset_transactions`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5001, '2022-12-20', 9003, 'Vice-President', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5001, '2022-12-21', 9003, 'Vice-President', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5002, '2022-12-21', 9003, 'Vice-President', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5003, '2022-12-23', 9011, 'Auditor', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5008, '2022-12-23', 9011, 'Auditor', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5010, '2022-12-23', 9011, 'Auditor', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5008, '2022-12-24', 9009, 'Secretary', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5005, '2022-12-21', 9009, 'Secretary', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5005, '2022-12-23', 9011, 'Auditor', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `HOADB`.`asset_transactions` (`asset_id`, `transaction_date`, `trans_hoid`, `trans_position`, `trans_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`, `ornum`, `transaction_type`) VALUES (5007, '2022-12-23', 9011, 'Auditor', '2022-12-01', 0, NULL, NULL, NULL, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`asset_activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`asset_activity` (`asset_id`, `activity_date`, `activity_description`, `tent_start`, `tent_end`, `act_start`, `act_end`, `cost`, `status`) VALUES (5001, '2022-12-20', 'Repair and Wash', '2022-12-21', '2022-12-21', '2022-12-21', '2022-12-21', 100, 'C');
INSERT INTO `HOADB`.`asset_activity` (`asset_id`, `activity_date`, `activity_description`, `tent_start`, `tent_end`, `act_start`, `act_end`, `cost`, `status`) VALUES (5001, '2022-12-21', 'Repaint', '2022-12-22', '2022-12-23', '2022-12-22', '2022-12-22', 400, 'C');
INSERT INTO `HOADB`.`asset_activity` (`asset_id`, `activity_date`, `activity_description`, `tent_start`, `tent_end`, `act_start`, `act_end`, `cost`, `status`) VALUES (5002, '2022-12-21', 'Repair', '2022-12-22', '2022-12-22', '2022-12-22', '2022-12-22', 0, 'C');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`asset_transfer`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`asset_transfer` (`asset_id`, `schedule_date`, `act_date`, `source_lattitude`, `source_longitude`, `dest_latittude`, `dest_longitude`, `transfer_cost`, `status`, `completename`, `incident_id`) VALUES (5005, '2022-12-21', '2022-12-23', 100.430, 100.530, 150.550, 150.560, 50, 'C', 'Juan Estanislao', NULL);
INSERT INTO `HOADB`.`asset_transfer` (`asset_id`, `schedule_date`, `act_date`, `source_lattitude`, `source_longitude`, `dest_latittude`, `dest_longitude`, `transfer_cost`, `status`, `completename`, `incident_id`) VALUES (5005, '2022-12-23', '2022-12-23', 243.550, 254.223, 212.445, 212.422, 100, 'C', 'Kyle Rosalita', NULL);
INSERT INTO `HOADB`.`asset_transfer` (`asset_id`, `schedule_date`, `act_date`, `source_lattitude`, `source_longitude`, `dest_latittude`, `dest_longitude`, `transfer_cost`, `status`, `completename`, `incident_id`) VALUES (5007, '2022-12-23', '2022-12-23', 423.212, 353.234, 255.256, 123.532, 100, 'C', 'Kyle Rosalita', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`asset_rentals`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`asset_rentals` (`asset_id`, `rental_date`, `reservation_date`, `resident_id`, `rental_amount`, `discount`, `status`, `inspection_details`, `assessed_value`, `accept_hoid`, `accept_position`, `accept_electiondate`, `return_date`, `incident_id`) VALUES (5008, '2022-12-23', '2022-12-20', 9016, 50, 0, 'N', 'All returned OK', 0, 9009, 'Secretary', '2022-12-01', '2022-12-23', NULL);
INSERT INTO `HOADB`.`asset_rentals` (`asset_id`, `rental_date`, `reservation_date`, `resident_id`, `rental_amount`, `discount`, `status`, `inspection_details`, `assessed_value`, `accept_hoid`, `accept_position`, `accept_electiondate`, `return_date`, `incident_id`) VALUES (5010, '2022-12-23', '2022-12-20', 9017, 50, 0, 'N', 'All returned OK', 0, 9010, 'Treasurer', '2022-12-01', '2022-12-25', NULL);
INSERT INTO `HOADB`.`asset_rentals` (`asset_id`, `rental_date`, `reservation_date`, `resident_id`, `rental_amount`, `discount`, `status`, `inspection_details`, `assessed_value`, `accept_hoid`, `accept_position`, `accept_electiondate`, `return_date`, `incident_id`) VALUES (5008, '2022-12-24', '2022-12-20', 9018, 50, 0, 'N', 'Some Damage', 500, 9010, 'Treasurer', '2022-12-01', '2022-12-25', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`donors`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`donors` (`donorname`, `address`) VALUES ('Ramon Magsaysay', 'Quezon City');
INSERT INTO `HOADB`.`donors` (`donorname`, `address`) VALUES ('Edgardo Tangchoco', 'Manila');
INSERT INTO `HOADB`.`donors` (`donorname`, `address`) VALUES ('Romeo Joselito', 'Pasay');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`asset_donations`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`asset_donations` (`donation_id`, `donor_completename`, `donation_formfile`, `date_donation`, `accept_hoid`, `accept_position`, `accept_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`) VALUES (6001, 'Ramon Magsaysay', '6001ramon.pdf', '2022-12-10', 9004, 'President', '2022-12-01', 0, NULL, NULL, NULL);
INSERT INTO `HOADB`.`asset_donations` (`donation_id`, `donor_completename`, `donation_formfile`, `date_donation`, `accept_hoid`, `accept_position`, `accept_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`) VALUES (6002, 'Edgardo Tangchoco', '6002edgardo.pdf', '2022-12-10', 9004, 'President', '2022-12-01', 0, NULL, NULL, NULL);
INSERT INTO `HOADB`.`asset_donations` (`donation_id`, `donor_completename`, `donation_formfile`, `date_donation`, `accept_hoid`, `accept_position`, `accept_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`) VALUES (6003, 'Edgardo Tangchoco', '6003edgardo.pdf', '2022-12-10', 9004, 'President', '2022-12-01', 0, NULL, NULL, NULL);
INSERT INTO `HOADB`.`asset_donations` (`donation_id`, `donor_completename`, `donation_formfile`, `date_donation`, `accept_hoid`, `accept_position`, `accept_electiondate`, `isdeleted`, `approval_hoid`, `approval_position`, `approval_electiondate`) VALUES (6004, 'Romeo Joselito', '6004romeo.pdf', '2022-12-11', 9003, 'Vice-President', '2022-12-01', 0, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`donated_assets`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`donated_assets` (`donation_id`, `asset_id`, `amount_donated`) VALUES (6001, 5004, 1000);
INSERT INTO `HOADB`.`donated_assets` (`donation_id`, `asset_id`, `amount_donated`) VALUES (6002, 5005, 2000);
INSERT INTO `HOADB`.`donated_assets` (`donation_id`, `asset_id`, `amount_donated`) VALUES (6003, 5006, 2000);
INSERT INTO `HOADB`.`donated_assets` (`donation_id`, `asset_id`, `amount_donated`) VALUES (6004, 5006, 2500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`donation_pictures`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`donation_pictures` (`donation_id`, `picturefile`) VALUES (6001, '6001-a.jpg');
INSERT INTO `HOADB`.`donation_pictures` (`donation_id`, `picturefile`) VALUES (6001, '6001-b.jpg');
INSERT INTO `HOADB`.`donation_pictures` (`donation_id`, `picturefile`) VALUES (6002, '6002.jpg');
INSERT INTO `HOADB`.`donation_pictures` (`donation_id`, `picturefile`) VALUES (6004, '6004-a.jpg');
INSERT INTO `HOADB`.`donation_pictures` (`donation_id`, `picturefile`) VALUES (6004, '6004-b.jpg');
INSERT INTO `HOADB`.`donation_pictures` (`donation_id`, `picturefile`) VALUES (6004, '6004-s.jpg');

COMMIT;

-- -----------------------------------------------------
-- Data for table `HOADB`.`ref_ornumbers`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`ref_ornumbers` (ornum) VALUES (3000031);
INSERT INTO `HOADB`.`ref_ornumbers` (ornum) VALUES (3000032);
INSERT INTO `HOADB`.`ref_ornumbers` (ornum) VALUES (3000033);
INSERT INTO `HOADB`.`ref_ornumbers` (ornum) VALUES (3000034);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`monthly_billing`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`monthly_billing` (bill_id, month, year, generated_date, deduction, collection_day, regular_dues, unpaid, discount, total, resident_id) VALUES (3000031, 1, 2023, '2023-01-06', 500, 10, 400, 150, 0.2, 210, 9002);
INSERT INTO `HOADB`.`monthly_billing` (bill_id, month, year, generated_date, deduction, collection_day, regular_dues, unpaid, discount, total, resident_id) VALUES (3000032, 2, 2023, '2023-02-06', 550, 10, 400, 220, 0.2, 214, 9005);
INSERT INTO `HOADB`.`monthly_billing` (bill_id, month, year, generated_date, deduction, collection_day, regular_dues, unpaid, discount, total, resident_id) VALUES (3000033, 3, 2023, '2023-03-06', 600, 10, 500, 310, 0.2, 282, 9008);
INSERT INTO `HOADB`.`monthly_billing` (bill_id, month, year, generated_date, deduction, collection_day, regular_dues, unpaid, discount, total, resident_id) VALUES (3000034, 4, 2023, '2023-04-06', 650, 10, 500, 190, 0.2, 248, 9009);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HOADB`.`bill_payment`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`bill_payment` (orno, payment_date, residentid, hoa_officer, bill_id, payment_type, payment_amount) VALUES (3000031, '2023-01-11', 9016, 9010, 3000031, 'Full', 210);
INSERT INTO `HOADB`.`bill_payment` (orno, payment_date, residentid, hoa_officer, bill_id, payment_type, payment_amount) VALUES (3000032, '2023-02-20', 9018, 9004, 3000032, 'Full', 214);
INSERT INTO `HOADB`.`bill_payment` (orno, payment_date, residentid, hoa_officer, bill_id, payment_type, payment_amount) VALUES (3000033, '2023-03-13', 9019, 9004, 3000033, 'Full', 282);
INSERT INTO `HOADB`.`bill_payment` (orno, payment_date, residentid, hoa_officer, bill_id, payment_type, payment_amount) VALUES (3000034, '2023-04-12', 9020, 9010, 3000034, 'Full', 248);

COMMIT;

-- -----------------------------------------------------
-- Data for table `HOADB`.`incident_report`
-- -----------------------------------------------------
START TRANSACTION;
USE `HOADB`;
INSERT INTO `HOADB`.`incident_report` (incident_id, incident_date, incident_disc, penalty, rule_no, hoa_officer, bill_id) VALUES (1000, '2023-01-04', 'Broke private property', 500, 5, 9012, 3000031);
INSERT INTO `HOADB`.`incident_report` (incident_id, incident_date, incident_disc, penalty, rule_no, hoa_officer, bill_id) VALUES (1001, '2023-02-05', 'Broke public property', 550, 9, 9012, 3000032);
INSERT INTO `HOADB`.`incident_report` (incident_id, incident_date, incident_disc, penalty, rule_no, hoa_officer, bill_id) VALUES (1002, '2023-03-03', 'Overdue payments', 600, 7, 9011, 3000033);
INSERT INTO `HOADB`.`incident_report` (incident_id, incident_date, incident_disc, penalty, rule_no, hoa_officer, bill_id) VALUES (1003, '2023-04-03', 'Trespassed private property', 650, 6, 9011, 3000034);

COMMIT;