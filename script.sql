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

-- =================================================================
-- 4. INSERTION DES DONNÉES (SEEDING)
-- =================================================================

-- 1. Adresses de service
INSERT INTO `service_addresses` (`service_address_id`, `street`, `street_number`, `postal_code`, `city`, `country`) VALUES
(1, 'Rue de la Station', '10', '1000', 'Bruxelles', 'Belgique'),
(2, 'Boulevard Tir', '150', '1000', 'Bruxelles', 'Belgique'),
(3, 'Avenue Louise', '54', '1050', 'Ixelles', 'Belgique');

-- 2. Utilisateurs
INSERT INTO `users` (`user_id`, `email`, `password`) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'admin@test.com', 'hashed_password_admin'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'mecanicien@test.com', 'hashed_password_meca'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'user@test.com', 'hashed_password_user');

-- 3. Fournisseurs (Providers)
INSERT INTO `providers` (`provider_id`, `provider_name`, `street`, `postal_code`, `city`) VALUES
(1, 'Garage Central Auto', 'Chaussée de Lodelinsart', '6060', 'Gilly'),
(2, 'Q-Team Pneus Service', 'Avenue Mascaux', '6001', 'Marcinelle'),
(3, 'Carrosserie L\'Etoile', 'Rue de la Pépinière', '1000', 'Bruxelles');

-- 4. Staff
INSERT INTO `staff` (`employee_id`, `last_name`, `first_name`, `badge_number`) VALUES
(101, 'Dupont', 'Jean', '425'),
(102, 'Martin', 'Sophie', '876'),
(103, 'Lambert', 'Michel', '927');

-- 5. Accidents
INSERT INTO `accidents` (`accident_id`, `accident_date`, `street`, `street_number`, `postal_code`, `city`, `country`, `accident_type`, `damages`, `circumstances`) VALUES
(1, '2024-10-15', 'Rue Neuve', '1', '1000', 'Bruxelles', 'Belgique', 'Accident en droit', 'Pare-choc avant', 'Tiers a heurté le véhicule à l\'arrêt.'),
(2, '2024-11-01', 'Boulevard Tirou', '50', '6000', 'Charleroi', 'Belgique', 'Accident en faute', 'Aile avant gauche', 'Le conducteur a heurté un poteau.'),
(3, '2024-11-05', 'Parking Rive Gauche', '1', '6000', 'Charleroi', 'Belgique', 'Vandalisme', 'Rayures sur la portière', 'Actes de vandalisme sur le parking.');

-- 6. Départements
INSERT INTO `departments` (`department_id`, `department_name`, `service_address_id`) VALUES
(1, 'ICT', 1),
(2, 'INT', 2),
(3, 'LOG', 3);

-- 7. Contacts
INSERT INTO `contacts` (`contact_id`, `last_name`, `first_name`, `email`, `provider_id`) VALUES
(1, 'Dubois', 'Marc', 'marc.dubois@centralauto.be', 1),
(2, 'Bernard', 'Luc', 'luc.bernard@qteam.be', 2),
(3, 'Petit', 'Alice', 'alice.petit@etoilecarro.be', 3);

-- 8. Staff_Accidents
INSERT INTO `staff_accidents` (`employee_id`, `accident_id`, `accident_role`) VALUES
(101, 2, 'Conducteur'),
(102, 1, 'Conducteur'),
(103, 3, 'Témoin');

-- 9. Véhicules
INSERT INTO `vehicles` (`id`, `vin`, `vehicle_number`, `license_plate`, `brand`, `model`, `manufacture_date`, `fuel_type`, `license_type`, `vehicle_configuration`, `technical_inspection_expiry_date`, `department_id`) VALUES
(1, 'VIN000000000000001', 1001, '1-ABC-001', 'Renault', 'Clio', '2022-01-15', 'Essence', 'B', 'Civil', '2025-01-15', 1),
(2, 'VIN000000000000002', 1002, '1-DEF-002', 'Peugeot', '308', '2023-05-20', 'Diesel', 'B', 'Stripping', '2025-05-20', 2),
(3, 'VIN000000000000003', 1003, '1-GHI-003', 'Volkswagen', 'Golf', '2021-11-30', 'Hybride', 'B', 'Banalis_', '2024-11-30', 1); -- <<< CORRIGÉ ICI

-- 10. Interventions
INSERT INTO `interventions` (`intervention_id`, `intervention_type`, `details`, `vehicle_id`, `user_id`, `provider_id`, `accident_id`) VALUES
(1, 'Pneu', 'Changement pneus avant suite à usure', 1, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 2, NULL),
(2, 'Carrosserie', 'Réparation aile avant gauche suite accident', 2, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 3, 2),
(3, 'Réparation hors contrat', 'Entretien annuel 40.000km', 3, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 1, NULL);

-- 11. Invoices
INSERT INTO `invoices` (`invoice_id`, `amount`, `invoice_number`, `intervention_id`) VALUES
(1, 250.75, 'F2024-001', 1),
(2, 1200.00, 'F2024-002', 2),
(3, 450.50, 'F2024-003', 3);