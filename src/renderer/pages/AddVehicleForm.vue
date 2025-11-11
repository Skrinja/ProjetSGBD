<template>
    <GoBackButton/>
    <h2>Ajouter un Nouveau Véhicule</h2>
    <form @submit.prevent="handleSubmit">
        <div>
            <input v-model="vin" required placeholder="N° de châssis (VIN)" />
        </div>
        <div>
            <input v-model="numPlate" required placeholder="Plaque d'immatriculation" />
        </div>
        <div>
            <input v-model.number="numVehicle" type="number" required placeholder="VRM" />
        </div>
        <div>
            <input v-model="brand" required placeholder="Marque" />
        </div>
        <div>
            <input v-model="model" required placeholder="Modèle" />
        </div>
        <div>
            <label for="year">Date de mise en circulation</label>
            <input id="year" v-model="year" type="date" required />
        </div>
        <div>
            <label for="fuel-type">Carburant</label>
            <select id="fuel-type" v-model="fuel" required>
                <option v-for="fuelType in fuelTypes" :key="fuelType" :value="fuelType">
                    {{ fuelType }}
                </option>
            </select>
        </div>
        <div>
            <label for="license-type">Permis nécessaire</label>
            <select id="license-type" v-model="licenseType" required>
                <option v-for="licenseType in licenseTypes" :key="licenseType" :value="licenseType">
                    {{ licenseType }}
                </option>
            </select>
        </div>
        <div>
            <label for="vehicle-configuration">Configuration du véhicule</label>
            <select id="vehicle-configuration" v-model="vehicleConfiguration" required>
                <option v-for="configuration in vehicleConfigurations" :key="configuration" :value="configuration">
                    {{ configuration }}
                </option>
            </select>
        </div>
        <div>
            <label for="tech-date">Date prochain contrôle technique</label>
            <input id="tech-date" v-model="technicalInspectionDate" type="date" required />
        </div>
        <div>
            <input v-model.number="departmentId" type="number" required placeholder="ID du département *" />
        </div>

        <div>
            <input v-model="tireSize" placeholder="Taille des pneus" />
        </div>
        <div>
            <input v-model="insuranceNumber" placeholder="N° d'assurance" />
        </div>
        <div>
            <textarea v-model="otherInformation" placeholder="Autres informations"></textarea>
        </div>
        <div>
            <input v-model="maintenanceContractNumber" placeholder="N° contrat maintenance" />
        </div>
        <div>
            <label for="maintenance-date">Date fin contrat d'entretien</label>
            <input id="maintenance-date" v-model="maintenanceContractEndDate" type="date" />
        </div>
        <div>
            <input v-model.number="maintenanceContractEndKm" type="number" placeholder="KM fin contrat maint." />
        </div>
        <div>
            <label>
                <input v-model="omnium" type="checkbox" />
                Omnium
            </label>
        </div>
        <div>
            <label>
                <input v-model="maintenanceContract" type="checkbox" />
                Contrat d'entretien
            </label>
        </div>
        <div>
            <label>
                <input v-model="decommissioned" type="checkbox" />
                Véhicule déclassé
            </label>
        </div>
        <button type="submit">Sauvegarder</button>
    </form>
    <p v-if="successMessage" style="color: green;">{{ successMessage }}</p>
    <p v-if="errorMessage" style="color: red;">{{ errorMessage }}</p>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import useVehicleService from '../composables/vehicleService';
import useSetMessageService from '../composables/setMessageService';
import { FuelType, LicenseType, VehicleConfiguration } from '../../shared/enums/vehicleEnum';
import GoBackButton from '../components/GoBackButton.vue';

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

const fuelTypes = ref(Object.values(FuelType));
const licenseTypes = ref(Object.values(LicenseType));
const vehicleConfigurations = ref(Object.values(VehicleConfiguration));
const { addVehicle } = useVehicleService();
const { successMessage, errorMessage, setMessage } = useSetMessageService();

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
    departmentId.value = undefined; // undefined pour stocker Null dans la DB si non rempli
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
    if (!vin.value || !numPlate.value || !numVehicle.value) {
        setMessage('error', "Veuillez remplir tous les champs.");
        return;
    }
    try {
        await addVehicle({
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
        });
        setMessage('success', "Véhicule sauvegardé !");
        resetForm();
    } catch (error) {
        console.error("Erreur lors de l'ajout du véhicule:", error);
        setMessage('error', "Un problème est survenu");
    }
};
</script>

<style scoped>
form {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    margin-top: 1rem;
}
input, select {
    padding: 8px;
    width: 100%;
    box-sizing: border-box;
}
</style>