-- =================================================================
-- 4. INSERTION DES DONNÉES (SEEDING)
-- =================================================================

-- 1. Adresses de service
INSERT INTO `service_addresses` (`service_address_id`, `street`, `street_number`, `postal_code`, `city`, `country`) VALUES
(1, 'Rue de la Station', '10', '7000', 'Mons', 'Belgique'),
(2, 'Boulevard Tirou', '150', '6000', 'Charleroi', 'Belgique'),
(3, 'Avenue Louise', '54', '1050', 'Bruxelles', 'Belgique');

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
INSERT INTO `staff` (`employee_id`, `last_name`, `first_name`) VALUES
(101, 'Dupont', 'Jean'),
(102, 'Martin', 'Sophie'),
(103, 'Lambert', 'Michel');

-- 5. Accidents
INSERT INTO `accidents` (`accident_id`, `accident_date`, `street`, `street_number`, `postal_code`, `city`, `country`, `accident_type`, `damages`, `circumstances`) VALUES
(1, '2024-10-15', 'Rue Neuve', '1', '1000', 'Bruxelles', 'Belgique', 'Accident en droit', 'Pare-choc avant', 'Tiers a heurté le véhicule à l\'arrêt.'),
(2, '2024-11-01', 'Boulevard Tirou', '50', '6000', 'Charleroi', 'Belgique', 'Accident en faute', 'Aile avant gauche', 'Le conducteur a heurté un poteau.'),
(3, '2024-11-05', 'Parking Rive Gauche', '1', '6000', 'Charleroi', 'Belgique', 'Vandalisme', 'Rayures sur la portière', 'Actes de vandalisme sur le parking.');

-- 6. Départements
INSERT INTO `departments` (`department_id`, `department_name`, `service_address_id`) VALUES
(1, 'IT Mons', 1),
(2, 'Direction Charleroi', 2),
(3, 'Ventes Bruxelles', 3);

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