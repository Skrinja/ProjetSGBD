-- #################################################################
-- # SCRIPT DE CRÉATION ET D'INSERTION COMPLET
-- # (Corrigé pour utiliser 'id' comme PK et 'Banalis_')
-- #################################################################

-- 0. Nettoyage et Création de la DB
DROP DATABASE IF EXISTS fleet_management;
CREATE DATABASE IF NOT EXISTS fleet_management
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE fleet_management;

SET FOREIGN_KEY_CHECKS=0; -- Désactivation temporaire pour la création

-- =================================================================
-- 1. BASE TABLES CREATION
-- =================================================================

CREATE TABLE Users (
    user_id VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL COMMENT 'hasher le mdp avant insertion !'
) ENGINE=InnoDB;


CREATE TABLE Service_Addresses (
    service_address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    street_number VARCHAR(10),
    postal_code VARCHAR(10),
    city VARCHAR(100) NOT NULL,
    country VARCHAR(50)
) ENGINE=InnoDB;


CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    service_address_id INT NOT NULL,
    FOREIGN KEY (service_address_id) REFERENCES Service_Addresses(service_address_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Providers (
    provider_id INT AUTO_INCREMENT PRIMARY KEY,
    provider_name VARCHAR(100) NOT NULL,
    street VARCHAR(255),
    street_number VARCHAR(10),
    postal_code VARCHAR(10),
    city VARCHAR(100),
    country VARCHAR(50)
) ENGINE=InnoDB;


CREATE TABLE Staff (
    employee_id INT PRIMARY KEY,
    badge_number VARCHAR(50) UNIQUE NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE Accidents (
    accident_id INT AUTO_INCREMENT PRIMARY KEY,
    accident_date DATE NOT NULL,
    accident_time TIME,
    street VARCHAR(255) NOT NULL,
    street_number VARCHAR(10) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    accident_type ENUM('Accident en faute', 'Accident en droit', 'Accident indécis', 'Vandalisme', 'Dégâts en faute', 'Dégâts en droit') NOT NULL,
    damages TEXT NOT NULL,
    circumstances TEXT NOT NULL,
    report_number VARCHAR(50),
    info_number VARCHAR(50),
    ref_insurance VARCHAR(50),
    other_party_info TEXT,
    documents JSON,
    repair_completed BOOLEAN DEFAULT FALSE
) ENGINE=InnoDB;


-- =================================================================
-- 2. DEPENDENT TABLES CREATION
-- =================================================================

CREATE TABLE Vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY, -- <<< MODIFIÉ : Nouvelle Clé Primaire
    vin VARCHAR(50) NOT NULL UNIQUE COMMENT 'Vehicle Identification Number', -- <<< MODIFIÉ : N''est plus PK, mais est UNIQUE
    vehicle_number INT NOT NULL UNIQUE,
    license_plate VARCHAR(20) NOT NULL UNIQUE,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    manufacture_date DATE NOT NULL,
    fuel_type ENUM('Essence', 'Diesel', 'Hybride', 'Electrique') NOT NULL,
    license_type ENUM('AM', 'A1', 'A2', 'A', 'B', 'C1', 'C', 'D1', 'D', 'E') NOT NULL,
    
    -- <<< CORRIGÉ ICI : L'ENUM doit être 'Banalis_' pour correspondre au schema.prisma
    vehicle_configuration ENUM('Stripping', 'Battenburg', 'Banalis_', 'Civil') NOT NULL,
    
    technical_inspection_expiry_date DATE NOT NULL,
    tire_size VARCHAR(50),
    insurance_number VARCHAR(75),
    omnium BOOLEAN DEFAULT FALSE,
    maintenance_contract BOOLEAN DEFAULT FALSE,
    maintenance_contract_end_km INT,
    maintenance_contract_end_date DATE,
    maintenance_contract_number VARCHAR(75),
    decommissioned_vehicle BOOLEAN DEFAULT FALSE,
    other_info TEXT,
    documents JSON,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    provider_id INT NOT NULL,
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Staff_Accidents (
    employee_id INT,
    accident_id INT,
    accident_role ENUM('Conducteur', 'Passager', 'Témoin') NOT NULL,
    PRIMARY KEY (employee_id, accident_id),
    FOREIGN KEY (employee_id) REFERENCES Staff(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (accident_id) REFERENCES Accidents(accident_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Interventions (
    intervention_id INT AUTO_INCREMENT PRIMARY KEY,
    intervention_type ENUM('Pneu', 'Réparation sous contrat', 'Réparation hors contrat', 'Dépannage', 'Carrosserie', 'Prêt') NOT NULL,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    details TEXT NOT NULL,
    garage_entry_date DATETIME,
    garage_exit_date DATETIME,
    intervention_completed BOOLEAN DEFAULT FALSE,
    vehicle_id INT NOT NULL, -- <<< MODIFIÉ (remplace vehicle_vin)
    user_id VARCHAR(36) NOT NULL,
    accident_id INT NULL,
    provider_id INT NOT NULL,
    documents JSON,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(id) ON DELETE RESTRICT ON UPDATE CASCADE, -- <<< MODIFIÉ (pointe vers Vehicles.id)
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (accident_id) REFERENCES Accidents(accident_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    documents JSON,
    invoice_number VARCHAR(50) NOT NULL UNIQUE,
    invoice_paid BOOLEAN DEFAULT FALSE,
    intervention_id INT NOT NULL,
    FOREIGN KEY (intervention_id) REFERENCES Interventions(intervention_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS=1; -- Réactivation des vérifications

-- =================================================================
-- 3. TRIGGERS CREATION
-- =================================================================

DELIMITER //

CREATE TRIGGER before_vehicle_insert_normalize_plate
BEFORE INSERT ON Vehicles
FOR EACH ROW
BEGIN
    SET NEW.license_plate = UPPER(NEW.license_plate);
    SET NEW.license_plate = REPLACE(NEW.license_plate, ' ', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '-', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '.', '');
END;
//

CREATE TRIGGER before_vehicle_update_normalize_plate
BEFORE UPDATE ON Vehicles
FOR EACH ROW
BEGIN
    SET NEW.license_plate = UPPER(NEW.license_plate);
    SET NEW.license_plate = REPLACE(NEW.license_plate, ' ', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '-', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '.', '');
END;
//

CREATE TRIGGER after_intervention_update_update_accident
AFTER UPDATE ON Interventions
FOR EACH ROW
BEGIN
    IF NEW.intervention_completed = TRUE AND OLD.intervention_completed = FALSE AND NEW.accident_id IS NOT NULL THEN
        UPDATE Accidents
        SET repair_completed = TRUE
        WHERE accident_id = NEW.accident_id;
    END IF;
END;
//

DELIMITER ;