<template>
    <GoBackButton/>
    <h2 v-if="!idParam">Ajouter un Nouveau Véhicule</h2>
    <h2 v-else>Modifier le Véhicule (VRM : {{ numVehicle }})</h2>

    <form @submit.prevent="handleSubmit">
        <BaseCard>
            <h3>Informations Principales</h3>
            <div class="form-grid">
                <div class="form-group">
                    <label for="vin">N° de châssis (VIN) *</label>
                    <input id="vin" v-model="vin" required placeholder="N° de châssis (VIN)" />
                </div>
                <div class="form-group">
                    <label for="numPlate">Plaque d'immatriculation *</label>
                    <input id="numPlate" v-model="numPlate" required placeholder="Plaque d'immatriculation" />
                </div>
                <div class="form-group">
                    <label for="numVehicle">VRM *</label>
                    <input id="numVehicle" v-model.number="numVehicle" type="number" required placeholder="VRM" />
                </div>
                <div class="form-group">
                    <label for="brand">Marque *</label>
                    <input id="brand" v-model="brand" required placeholder="Marque" />
                </div>
                <div class="form-group">
                    <label for="model">Modèle *</label>
                    <input id="model" v-model="model" required placeholder="Modèle" />
                </div>
                <div class="form-group">
                    <label for="year">Date de mise en circulation *</label>
                    <input id="year" v-model="year" type="date" required />
                </div>
                <div class="form-group">
                    <label for="fuel-type">Carburant *</label>
                    <select id="fuel-type" v-model="fuel" required>
                        <option v-for="fuelType in fuelTypes" :key="fuelType" :value="fuelType">
                            {{ fuelType }}
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="license-type">Permis nécessaire *</label>
                    <select id="license-type" v-model="licenseType" required>
                        <option v-for="type in licenseTypes" :key="type" :value="type">
                            {{ type }}
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="vehicle-configuration">Configuration *</label>
                    <select id="vehicle-configuration" v-model="vehicleConfiguration" required>
                        <option v-for="config in vehicleConfigurations" :key="config" :value="config">
                            {{ config }}
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="tech-date">Prochain contrôle technique *</label>
                    <input id="tech-date" v-model="technicalInspectionDate" type="date" required />
                </div>
                <div class="form-group">
                    <label for="department">Service *</label>
                    <select id="department" v-model.number="departmentId" required>
                        <option :value="undefined" disabled>Sélectionnez un service</option>
                        <option v-for="dept in departments" :key="dept.id" :value="dept.id">
                            {{ dept.name }}
                        </option>
                    </select>
                </div>
                 <div class="form-group">
                    <label for="tireSize">Taille des pneus</label>
                    <input id="tireSize" v-model="tireSize" placeholder="Taille des pneus" />
                </div>
            </div>
        </BaseCard>

        <BaseCard>
            <h3>Contrat & Assurance</h3>
            <div class="form-grid">
                <div class="form-group">
                    <label for="insuranceNumber">N° d'assurance</label>
                    <input id="insuranceNumber" v-model="insuranceNumber" placeholder="N° d'assurance" />
                </div>
                <div class="form-group">
                    <label for="maintenanceContractNumber">N° contrat maintenance</label>
                    <input id="maintenanceContractNumber" v-model="maintenanceContractNumber" placeholder="N° contrat maintenance" />
                </div>
                <div class="form-group">
                    <label for="maintenance-date">Date fin contrat</label>
                    <input id="maintenance-date" v-model="maintenanceContractEndDate" type="date" />
                </div>
                <div class="form-group">
                    <label for="maintenanceContractEndKm">KM fin contrat</label>
                    <input id="maintenanceContractEndKm" v-model.number="maintenanceContractEndKm" type="number" placeholder="KM fin contrat maint." />
                </div>
            </div>
             <div class="checkbox-group">
                <label>
                    <input v-model="omnium" type="checkbox" />
                    Omnium
                </label>
                <label>
                    <input v-model="maintenanceContract" type="checkbox" />
                    Contrat d'entretien
                </label>
            </div>
        </BaseCard>
        
        <BaseCard>
            <h3>Autre</h3>
             <div class="form-grid-full">
                <div class="form-group">
                    <label for="otherInformation">Autres informations</label>
                    <textarea id="otherInformation" v-model="otherInformation" placeholder="Autres informations"></textarea>
                </div>
                <div class="checkbox-group single">
                    <label>
                        <input v-model="decommissioned" type="checkbox" />
                        Véhicule déclassé
                    </label>
                </div>
             </div>
        </BaseCard>

        <div class="form-actions">
            <button type="submit">Sauvegarder</button>
            <p v-if="successMessage" class="success-message">{{ successMessage }}</p>
            <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
        </div>
    </form>
    
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import useVehicleService from '../composables/vehicleService';
import useSetMessageService from '../composables/setMessageService';
import { FuelType, LicenseType, VehicleConfiguration } from '../../shared/enums/vehicleEnum';
import GoBackButton from '../components/GoBackButton.vue';
import useDepartmentService from '../composables/departmentService';
import BaseCard from '../components/BaseCard.vue';

// Références pour les champs du formulaire
const vin = ref('');
const numPlate = ref('');
const numVehicle = ref<number>();
const brand = ref('');
const model = ref('');
const year = ref('');
const fuel = ref<FuelType>(FuelType.Petrol);
const licenseType = ref<LicenseType>(LicenseType.B);
const vehicleConfiguration = ref<VehicleConfiguration>(VehicleConfiguration.Stripping);
const technicalInspectionDate = ref('');
const departmentId = ref<number>();
const tireSize = ref('');
const insuranceNumber = ref('');
const otherInformation = ref('');
const maintenanceContractNumber = ref('');
const maintenanceContractEndDate = ref('');
const maintenanceContractEndKm = ref<number>();
const omnium = ref(false);
const maintenanceContract = ref(false);
const decommissioned = ref(false);

const router = useRouter();
const route = useRoute();
const idParam = ref(Number(route.params.id));

// Listes pour les selects
const fuelTypes = ref(Object.values(FuelType));
const licenseTypes = ref(Object.values(LicenseType));
const vehicleConfigurations = ref(Object.values(VehicleConfiguration));

// Services
const { addVehicle, updateVehicle, getVehicleById } = useVehicleService();
const { successMessage, errorMessage, setMessage } = useSetMessageService();
const { departments, getAllDepartments } = useDepartmentService();


onMounted(async () => {
    await getAllDepartments();
    
    if (idParam.value) {
        const vehicle = await getVehicleById(idParam.value);
        if (vehicle) {
            vin.value = vehicle.vin;
            numPlate.value = vehicle.numPlate;
            numVehicle.value = vehicle.numVehicle;
            brand.value = vehicle.brand;
            model.value = vehicle.model;
            year.value = new Date(vehicle.year).toISOString().substring(0, 10);
            fuel.value = vehicle.fuel;
            licenseType.value = vehicle.licenseType;
            vehicleConfiguration.value = vehicle.configuration;
            technicalInspectionDate.value = new Date(vehicle.technicalInspectionDate).toISOString().substring(0, 10);
            departmentId.value = vehicle.departmentId || undefined;
            tireSize.value = vehicle.tireSize || '';
            insuranceNumber.value = vehicle.insuranceNumber || '';
            otherInformation.value = vehicle.otherInformation || '';
            maintenanceContractNumber.value = vehicle.maintenanceContractNumber || '';
            maintenanceContractEndDate.value = vehicle.maintenanceContractEndDate ? new Date(vehicle.maintenanceContractEndDate).toISOString().substring(0, 10) : '';
            maintenanceContractEndKm.value = vehicle.maintenanceContractEndKm || undefined;
            omnium.value = vehicle.omnium;
            maintenanceContract.value = vehicle.maintenanceContract;
            decommissioned.value = vehicle.decommissioned;
        }
    }
});

const resetForm = () => {
    vin.value = '';
    numPlate.value = '';
    numVehicle.value = undefined;
    brand.value = '';
    model.value = '';
    year.value = '';
    fuel.value = FuelType.Petrol;
    licenseType.value = LicenseType.B;
    vehicleConfiguration.value = VehicleConfiguration.Stripping;
    technicalInspectionDate.value = '';
    departmentId.value = undefined;
    tireSize.value = '';
    insuranceNumber.value = '';
    otherInformation.value = '';
    maintenanceContractNumber.value = '';
    maintenanceContractEndDate.value = '';
    maintenanceContractEndKm.value = undefined;
    omnium.value = false;
    maintenanceContract.value = false;
    decommissioned.value = false;
};

const handleSubmit = async () => {
    if (!vin.value || !numPlate.value || !numVehicle.value || !departmentId.value) {
        setMessage('error', "Veuillez remplir tous les champs obligatoires (*).");
        return;
    }

    const vehicleData = {
            id: Number(idParam.value) || undefined,
            vin: vin.value,
            numPlate: numPlate.value,
            numVehicle: numVehicle.value,
            brand: brand.value,
            model: model.value,
            year: new Date(year.value),
            fuel: fuel.value,
            licenseType: licenseType.value,
            configuration: vehicleConfiguration.value,
            technicalInspectionDate: new Date(technicalInspectionDate.value),
            departmentId: departmentId.value,
            tireSize: tireSize.value || undefined,
            insuranceNumber: insuranceNumber.value || undefined,
            otherInformation: otherInformation.value || undefined,
            maintenanceContractNumber: maintenanceContractNumber.value || undefined,
            maintenanceContractEndDate: maintenanceContractEndDate.value ? new Date(maintenanceContractEndDate.value) : undefined,
            maintenanceContractEndKm: maintenanceContractEndKm.value || undefined,
            omnium: omnium.value,
            maintenanceContract: maintenanceContract.value,
            decommissioned: decommissioned.value,
        };

    try {
        if (idParam.value) {
            await updateVehicle(vehicleData);
            router.push(`/vehicle/${idParam.value}`);
        } else {
            await addVehicle(vehicleData);
            setMessage('success', 'Véhicule ajouté avec succès.');
            resetForm();
        }
    } catch (error) {
        setMessage('error', `Erreur lors de la sauvegarde du véhicule : ${(error as Error).message}`);
    }
};

</script>

<style scoped>
form {
    display: flex;
    flex-direction: column;
    gap: 1.5rem; /* Espace entre les cartes */
    margin-top: 1rem;
}

form .card {
    padding-top: 1rem;
    padding-bottom: 1.5rem;
}

form h3 {
    font-size: 1.2rem;
    color: #1e293b;
    border-bottom: 1px solid #e2e8f0;
    padding-bottom: 0.5rem;
    margin-bottom: 1.5rem;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1rem 1.5rem;
}

.form-grid-full {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1rem;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.form-group label {
    font-size: 0.9rem;
    font-weight: 500;
    color: #475569;
}

input[type="text"],
input[type="number"],
input[type="date"],
select,
textarea {
    padding: 0.6rem;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    font-size: 1rem;
    width: 100%;
    box-sizing: border-box; /* Assure que le padding ne dépasse pas */
    transition: border-color 0.2s, box-shadow 0.2s;
}

input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: #2563eb;
    box-shadow: 0 0 0 2px #bfdbfe;
}

textarea {
    min-height: 80px;
    resize: vertical;
}

.checkbox-group {
    display: flex;
    gap: 1.5rem;
    margin-top: 1rem;
    padding-top: 1rem;
    border-top: 1px solid #f1f5f9;
}
.checkbox-group.single {
    border-top: none;
    padding-top: 0;
}

.checkbox-group label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 1rem;
    color: #334155;
}

input[type="checkbox"] {
    width: 1.2em;
    height: 1.2em;
    accent-color: #2563eb;
}

.form-actions {
    margin-top: 1rem;
    padding: 1rem;
    background-color: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.form-actions button {
    font-size: 1rem;
    padding: 0.75rem 1.5rem;
}

.success-message {
    color: green;
    margin-top: 1rem;
    margin-bottom: 0;
}

.error-message {
    color: #dc2626; /* Rouge */
    margin-top: 1rem;
    margin-bottom: 0;
}
</style>