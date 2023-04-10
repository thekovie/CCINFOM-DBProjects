SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hoadb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hoadb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hoadb` DEFAULT CHARACTER SET utf8 ;
USE `hoadb` ;

-- -----------------------------------------------------
-- Table `hoadb`.`hoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`hoa` (
  `hoaname` VARCHAR(100) NOT NULL,
  `office_streetno` VARCHAR(20) NOT NULL,
  `office_street` VARCHAR(45) NOT NULL,
  `office_brgy` VARCHAR(45) NOT NULL,
  `office_city` VARCHAR(45) NOT NULL,
  `office_province` VARCHAR(45) NOT NULL,
  `office_region` VARCHAR(45) NOT NULL,
  `office_zip` VARCHAR(45) NOT NULL,
  `office_mapx` VARCHAR(45) NOT NULL,
  `office_mapy` VARCHAR(45) NOT NULL,
  `year_est` INT(4) NOT NULL,
  `website` VARCHAR(45) NULL,
  `subd_name` VARCHAR(45) NOT NULL,
  `monthly_dues` INT(2) NOT NULL,
  PRIMARY KEY (`hoaname`, `monthly_dues`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`hoa_docs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`hoa_docs` (
  `submission_type` INT NOT NULL,
  `doc_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`submission_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`hoa_submissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`hoa_submissions` (
  `hoa_hoaname` VARCHAR(100) NOT NULL,
  `hoa_docs_submission_type` INT NOT NULL,
  `submission_date` DATE NOT NULL,
  PRIMARY KEY (`hoa_hoaname`, `hoa_docs_submission_type`, `submission_date`),
  INDEX `fk_hoa_submissions_hoa_docs1_idx` (`hoa_docs_submission_type` ASC) VISIBLE,
  CONSTRAINT `fk_hoa_submissions_hoa`
    FOREIGN KEY (`hoa_hoaname`)
    REFERENCES `hoadb`.`hoa` (`hoaname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hoa_submissions_hoa_docs1`
    FOREIGN KEY (`hoa_docs_submission_type`)
    REFERENCES `hoadb`.`hoa_docs` (`submission_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`individual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`individual` (
  `individualid` INT NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `mi` VARCHAR(2) NULL,
  `email` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `facebook_url` VARCHAR(45) NULL,
  `pic_filename` VARCHAR(45) NOT NULL,
  `undertaking` TINYINT NOT NULL,
  PRIMARY KEY (`individualid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`homeowner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`homeowner` (
  `homeownerid` INT NOT NULL AUTO_INCREMENT,
  `residency_start` DATE NULL,
  `membership` TINYINT NOT NULL,
  `isresident` TINYINT NOT NULL,
  PRIMARY KEY (`homeownerid`),
  CONSTRAINT `homeownerid`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `hoadb`.`individual` (`individualid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`homeowner_addinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`homeowner_addinfo` (
  `add2_streetno` VARCHAR(20) NULL,
  `add2_street` VARCHAR(45) NULL,
  `add2_brgy` VARCHAR(45) NULL,
  `add2_city` VARCHAR(45) NULL,
  `add2_province` VARCHAR(45) NULL,
  `add2_mapx` VARCHAR(45) NULL,
  `add2_mapy` VARCHAR(45) NULL,
  `email2` VARCHAR(45) NULL,
  `homeownerid` INT NOT NULL,
  PRIMARY KEY (`homeownerid`),
  CONSTRAINT `fk_homeowner_addinfo_homeowner1`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `hoadb`.`homeowner` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`mobile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`mobile` (
  `mobilenum` INT(11) ZEROFILL NOT NULL,
  `individualid` INT NOT NULL,
  PRIMARY KEY (`mobilenum`),
  INDEX `fk_mobile_individual1_idx` (`individualid` ASC) VISIBLE,
  CONSTRAINT `fk_mobile_individual1`
    FOREIGN KEY (`individualid`)
    REFERENCES `hoadb`.`individual` (`individualid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`property`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`property` (
  `propertycode` VARCHAR(6) NOT NULL,
  `hoaname` VARCHAR(100) NOT NULL,
  `homeownerid` INT NOT NULL,
  `size` INT NOT NULL,
  `turnover_date` DATE NOT NULL,
  PRIMARY KEY (`propertycode`),
  INDEX `fk_property_homeowner1_idx` (`homeownerid` ASC) VISIBLE,
  INDEX `fk_property_hoa1_idx` (`hoaname` ASC) VISIBLE,
  CONSTRAINT `fk_property_homeowner1`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `hoadb`.`homeowner` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_property_hoa1`
    FOREIGN KEY (`hoaname`)
    REFERENCES `hoadb`.`hoa` (`hoaname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`household`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`household` (
  `householdid` INT NOT NULL,
  `propertycode` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`householdid`),
  INDEX `fk_household_property1_idx` (`propertycode` ASC) VISIBLE,
  CONSTRAINT `fk_household_property1`
    FOREIGN KEY (`propertycode`)
    REFERENCES `hoadb`.`property` (`propertycode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`resident`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`resident` (
  `residentid` INT NOT NULL,
  `renter` TINYINT NOT NULL,
  `rel_homeowner` VARCHAR(45) NOT NULL,
  `householdid` INT NOT NULL,
  `authorized` TINYINT NOT NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`residentid`),
  INDEX `fk_resident_household1_idx` (`householdid` ASC) VISIBLE,
  CONSTRAINT `residentid`
    FOREIGN KEY (`residentid`)
    REFERENCES `hoadb`.`individual` (`individualid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resident_household1`
    FOREIGN KEY (`householdid`)
    REFERENCES `hoadb`.`household` (`householdid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`payment` (
  `orno` INT NOT NULL,
  `amount` FLOAT NOT NULL,
  PRIMARY KEY (`orno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`hoa_officer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`hoa_officer` (
  `homeownerid` INT NOT NULL,
  `hoaname` VARCHAR(100) NOT NULL,
  `position` ENUM('President', 'Vice-President', 'Treasurer', 'Secretary') NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `elec_date` DATE NOT NULL,
  `elec_venue` VARCHAR(45) NOT NULL,
  `elec_quorum` TINYINT NOT NULL,
  `elec_witnessname` VARCHAR(100) NOT NULL,
  `elec_witnessmobile` INT(10) ZEROFILL NOT NULL,
  `avail_Mon` ENUM('M', 'A', 'NA') NOT NULL,
  `avail_Tue` ENUM('M', 'A', 'NA') NOT NULL,
  `avail_Wed` ENUM('M', 'A', 'NA') NOT NULL,
  `avail_Thu` ENUM('M', 'A', 'NA') NOT NULL,
  `avail_Fri` ENUM('M', 'A', 'NA') NOT NULL,
  `avail_Sat` ENUM('M', 'A', 'NA') NOT NULL,
  `avail_Sun` ENUM('M', 'A', 'NA') NOT NULL,
  PRIMARY KEY (`homeownerid`, `position`, `elec_date`),
  INDEX `fk_hoa_officer_homeowner1_idx` (`homeownerid` ASC) VISIBLE,
  INDEX `fk_hoa_officer_hoa1_idx` (`hoaname` ASC) VISIBLE,
  CONSTRAINT `fk_hoa_officer_homeowner1`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `hoadb`.`homeowner` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hoa_officer_hoa1`
    FOREIGN KEY (`hoaname`)
    REFERENCES `hoadb`.`hoa` (`hoaname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`resident_id`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`resident_id` (
  `cardno` INT NOT NULL,
  `request_date` DATE NOT NULL,
  `request_reason` VARCHAR(45) NOT NULL,
  `issue_date` DATE NOT NULL,
  `hoa_officer` INT NOT NULL,
  `residentid` INT NOT NULL,
  `status` ENUM('A', 'L', 'C') NOT NULL,
  `orno` INT NULL,
  PRIMARY KEY (`cardno`),
  INDEX `fk_resident_id_resident1_idx` (`residentid` ASC) VISIBLE,
  INDEX `fk_resident_id_payment1_idx` (`orno` ASC) VISIBLE,
  INDEX `hoa_officer_idx` (`hoa_officer` ASC) VISIBLE,
  CONSTRAINT `fk_resident_id_resident1`
    FOREIGN KEY (`residentid`)
    REFERENCES `hoadb`.`resident` (`residentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resident_id_payment1`
    FOREIGN KEY (`orno`)
    REFERENCES `hoadb`.`payment` (`orno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hoa_officer_1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`asset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`asset` (
  `assetid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `acq_date` DATE NOT NULL,
  `forrent` TINYINT NOT NULL,
  `value` FLOAT NOT NULL,
  `type` ENUM('P', 'E', 'F', 'O') NOT NULL,
  `status` ENUM('W', 'DE', 'FR', 'FD', 'DI') NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `location_mapx` VARCHAR(45) NOT NULL,
  `location_mapy` VARCHAR(45) NOT NULL,
  `location_assetid` INT NULL,
  `hoa_hoaname` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`assetid`),
  INDEX `fk_asset_asset1_idx` (`location_assetid` ASC) VISIBLE,
  INDEX `fk_asset_hoa1_idx` (`hoa_hoaname` ASC) VISIBLE,
  CONSTRAINT `fk_asset_asset1`
    FOREIGN KEY (`location_assetid`)
    REFERENCES `hoadb`.`asset` (`assetid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_hoa1`
    FOREIGN KEY (`hoa_hoaname`)
    REFERENCES `hoadb`.`hoa` (`hoaname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`asset_activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`asset_activity` (
  `asset_activityid` INT NOT NULL,
  `assetid` INT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `hoa_officer` INT NOT NULL,
  `tent_start` DATETIME NOT NULL,
  `tent_end` DATETIME NOT NULL,
  `actual_start` DATETIME NOT NULL,
  `actual_end` DATETIME NOT NULL,
  `orno` INT NULL,
  `status` ENUM('S', 'O', 'C', 'D') NOT NULL,
  PRIMARY KEY (`asset_activityid`),
  INDEX `fk_asset_activity_asset1_idx` (`assetid` ASC) VISIBLE,
  INDEX `hoa_officer_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `or_no_idx` (`orno` ASC) VISIBLE,
  CONSTRAINT `fk_asset_activity_asset1`
    FOREIGN KEY (`assetid`)
    REFERENCES `hoadb`.`asset` (`assetid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hoa_officer`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `or_no`
    FOREIGN KEY (`orno`)
    REFERENCES `hoadb`.`payment` (`orno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`delete_activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`delete_activity` (
  `asset_activityid` INT NOT NULL,
  `pres_approval` TINYINT NOT NULL,
  PRIMARY KEY (`asset_activityid`),
  INDEX `fk_delete_activity_asset_activity1_idx` (`asset_activityid` ASC) VISIBLE,
  CONSTRAINT `fk_delete_activity_asset_activity1`
    FOREIGN KEY (`asset_activityid`)
    REFERENCES `hoadb`.`asset_activity` (`asset_activityid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`monthly_dues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`monthly_dues` (
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
  `household_id` INT NOT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `household_id_idx` (`household_id` ASC) VISIBLE,
  CONSTRAINT `household_id`
    FOREIGN KEY (`household_id`)
    REFERENCES `hoadb`.`household` (`householdid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`incident_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`incident_report` (
  `incident_id` INT NOT NULL,
  `incident_date` DATE NOT NULL,
  `incident_desc` VARCHAR(45) NOT NULL,
  `penalty` FLOAT NOT NULL,
  `rule_no` INT NOT NULL,
  `hoa_officer` INT NOT NULL,
  `bill_id` INT NOT NULL,
  PRIMARY KEY (`incident_id`),
  INDEX `fk_other_dues_hoa_officer1_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `bill_id_idx` (`bill_id` ASC) VISIBLE,
  CONSTRAINT `fk_other_dues_hoa_officer1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_id`
    FOREIGN KEY (`bill_id`)
    REFERENCES `hoadb`.`monthly_dues` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`asset_transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`asset_transfer` (
  `asset_transferid` INT NOT NULL,
  `assetid` INT NOT NULL,
  `schedule` DATE NOT NULL,
  `hoa_officer` INT NOT NULL,
  `actual_date` DATE NOT NULL,
  `location_origin` VARCHAR(45) NOT NULL,
  `location_dest` VARCHAR(45) NOT NULL,
  `status` ENUM('S', 'O', 'C', 'D') NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `mi` VARCHAR(45) NULL,
  `mobilenum` INT(11) ZEROFILL NOT NULL,
  `orno` INT NULL,
  `incident_id` INT NULL,
  PRIMARY KEY (`asset_transferid`),
  INDEX `hoa_officer_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `fk_asset_transfer_asset1_idx` (`assetid` ASC) VISIBLE,
  INDEX `fk_asset_transfer_payment1_idx` (`orno` ASC) VISIBLE,
  INDEX `incident_id_idx` (`incident_id` ASC) VISIBLE,
  CONSTRAINT `fk_hoa_officer`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_transfer_asset1`
    FOREIGN KEY (`assetid`)
    REFERENCES `hoadb`.`asset` (`assetid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_transfer_payment1`
    FOREIGN KEY (`orno`)
    REFERENCES `hoadb`.`payment` (`orno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incident_id`
    FOREIGN KEY (`incident_id`)
    REFERENCES `hoadb`.`incident_report` (`incident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`delete_transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`delete_transfer` (
  `asset_transferid` INT NOT NULL,
  `pres_approval` TINYINT NOT NULL,
  PRIMARY KEY (`asset_transferid`),
  CONSTRAINT `fk_delete_transfer_asset_transfer1`
    FOREIGN KEY (`asset_transferid`)
    REFERENCES `hoadb`.`asset_transfer` (`asset_transferid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`asset_rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`asset_rental` (
  `asset_rentalid` INT NOT NULL,
  `renter_residentid` INT NOT NULL,
  `reservation_date` DATE NOT NULL,
  `rental_date` DATE NOT NULL,
  `hoa_officer` INT NOT NULL,
  `discount` DECIMAL(5,2) NOT NULL,
  `status` ENUM('RV', 'C', 'OR', 'RT', 'D') NOT NULL,
  `return_details` VARCHAR(200) NOT NULL,
  `orno` INT NULL,
  `incident_id` INT NULL,
  PRIMARY KEY (`asset_rentalid`),
  INDEX `hoa_officer_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `orno_idx` (`orno` ASC) VISIBLE,
  INDEX `fk_asset_rental_resident1_idx` (`renter_residentid` ASC) VISIBLE,
  INDEX `incident_id_idx` (`incident_id` ASC) VISIBLE,
  CONSTRAINT `fk_hoa_officer_5345345`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orno423423`
    FOREIGN KEY (`orno`)
    REFERENCES `hoadb`.`payment` (`orno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_rental_resident1`
    FOREIGN KEY (`renter_residentid`)
    REFERENCES `hoadb`.`resident` (`residentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incident_id_34234`
    FOREIGN KEY (`incident_id`)
    REFERENCES `hoadb`.`incident_report` (`incident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`delete_rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`delete_rental` (
  `asset_rentalid` INT NOT NULL,
  `pres_approval` TINYINT NULL,
  PRIMARY KEY (`asset_rentalid`),
  CONSTRAINT `fk_delete_rental_asset_rental1`
    FOREIGN KEY (`asset_rentalid`)
    REFERENCES `hoadb`.`asset_rental` (`asset_rentalid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`assets_rented`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`assets_rented` (
  `assetid` INT NOT NULL,
  `asset_rentalid` INT NOT NULL,
  `cost` FLOAT NOT NULL,
  PRIMARY KEY (`assetid`, `asset_rentalid`),
  INDEX `asset_rentalid_idx` (`asset_rentalid` ASC) VISIBLE,
  CONSTRAINT `assetid`
    FOREIGN KEY (`assetid`)
    REFERENCES `hoadb`.`asset` (`assetid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `asset_rentalid`
    FOREIGN KEY (`asset_rentalid`)
    REFERENCES `hoadb`.`asset_rental` (`asset_rentalid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`asset_donation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`asset_donation` (
  `asset_donationid` INT NOT NULL,
  `donor_lastname` VARCHAR(45) NOT NULL,
  `donor_firstname` VARCHAR(45) NOT NULL,
  `donor_mi` VARCHAR(45) NOT NULL,
  `donor_add` VARCHAR(45) NULL,
  `hoa_officer` INT NOT NULL,
  PRIMARY KEY (`asset_donationid`),
  INDEX `hoa_officer_idx` (`hoa_officer` ASC) VISIBLE,
  CONSTRAINT `hoa_officer_8390`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`donation_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`donation_event` (
  `asset_donationid` INT NOT NULL,
  `pic_filename` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`asset_donationid`, `pic_filename`),
  CONSTRAINT `fk_donation_event_asset_donation1`
    FOREIGN KEY (`asset_donationid`)
    REFERENCES `hoadb`.`asset_donation` (`asset_donationid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`items_donated`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`items_donated` (
  `asset_donationid` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `amount` FLOAT NULL,
  PRIMARY KEY (`asset_donationid`, `item_name`),
  CONSTRAINT `fk_asset_donationid_8989`
    FOREIGN KEY (`asset_donationid`)
    REFERENCES `hoadb`.`asset_donation` (`asset_donationid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`delete_donation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`delete_donation` (
  `pres_approval` TINYINT NOT NULL,
  `asset_donationid` INT NOT NULL,
  PRIMARY KEY (`pres_approval`, `asset_donationid`),
  INDEX `asset_donationid_idx` (`asset_donationid` ASC) VISIBLE,
  CONSTRAINT `fk_asset_donationid_1`
    FOREIGN KEY (`asset_donationid`)
    REFERENCES `hoadb`.`asset_donation` (`asset_donationid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`bill_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`bill_payment` (
  `orno` INT NOT NULL,
  `payment_date` DATE NOT NULL,
  `residentid` INT NOT NULL,
  `hoa_officer` INT NOT NULL,
  `bill_id` INT NOT NULL,
  `payment_type` ENUM('Full', 'Partial', 'Advanced') NOT NULL,
  PRIMARY KEY (`orno`),
  INDEX `fk_bill_payment_payment1_idx` (`orno` ASC) VISIBLE,
  INDEX `fk_bill_payment_resident1_idx` (`residentid` ASC) VISIBLE,
  INDEX `fk_bill_payment_hoa_officer1_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `bill_id_idx` (`bill_id` ASC) VISIBLE,
  CONSTRAINT `fk_bill_payment_payment1`
    FOREIGN KEY (`orno`)
    REFERENCES `hoadb`.`payment` (`orno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_payment_resident1`
    FOREIGN KEY (`residentid`)
    REFERENCES `hoadb`.`resident` (`residentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_payment_hoa_officer1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bill_id`
    FOREIGN KEY (`bill_id`)
    REFERENCES `hoadb`.`monthly_dues` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoadb`.`evidence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoadb`.`evidence` (
  `evidence_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `desc` VARCHAR(45) NOT NULL,
  `filename` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `accepting_officer` INT NOT NULL,
  `residentid` INT NOT NULL,
  `incident_id` INT NOT NULL,
  PRIMARY KEY (`evidence_id`),
  INDEX `fk_evidence_hoa_officer1_idx` (`accepting_officer` ASC) VISIBLE,
  INDEX `fk_evidence_resident1_idx` (`residentid` ASC) VISIBLE,
  INDEX `incident_id_idx` (`incident_id` ASC) VISIBLE,
  CONSTRAINT `fk_evidence_hoa_officer1`
    FOREIGN KEY (`accepting_officer`)
    REFERENCES `hoadb`.`hoa_officer` (`homeownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evidence_resident1`
    FOREIGN KEY (`residentid`)
    REFERENCES `hoadb`.`resident` (`residentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `incident_id`
    FOREIGN KEY (`incident_id`)
    REFERENCES `hoadb`.`incident_report` (`incident_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
