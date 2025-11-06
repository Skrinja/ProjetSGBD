<template>
    <div v-if="vehicle">
        <h1>Détails du Véhicule {{ vehicle.numVehicle }}</h1>
        <router-link to="/vehicles">
            <button>Retour à la liste</button>
        </router-link>
        <BaseCard>
            <p><strong>N° de Châssis :</strong> {{ vehicle.vin }}</p>
            <p><strong>Plaque :</strong> {{ vehicle.numPlate }}</p>
            <p><strong>VRM :</strong> {{ vehicle.numVehicle }}</p>
            <p><strong>Marque :</strong> {{ vehicle.brand }}</p>
            <p><strong>Modèle :</strong> {{ vehicle.model }}</p>
            <p><strong>Mise en circulation :</strong> {{ new Date(vehicle.year).toLocaleDateString('fr-FR') }}</p>
            <p><strong>Type de carburant :</strong> {{ vehicle.fuel }}</p>
            <p><strong>Type de permis :</strong> {{ vehicle.licenseType }}</p>
            <p><strong>Configuration :</strong> {{ vehicle.configuration }}</p>
            <p><strong>Date du contrôle technique :</strong> {{ new Date(vehicle.technicalInspectionDate).toLocaleDateString('fr-FR') }}</p>
            <p><strong>ID Département :</strong> {{ vehicle.departmentId }}</p>
            <p><strong>taille des pneus :</strong> {{ vehicle.tireSize }}</p>
            <p><strong>Numéro d'assurance :</strong> {{ vehicle.insuranceNumber }}</p>
            <p><strong>Omnium :</strong> {{ vehicle.omnium ? 'Oui' : 'Non' }}</p>
            <p><strong>Contrat d'entretien :</strong> {{ vehicle.maintenanceContract ? 'Oui' : 'Non' }}</p>
            <p><strong>Date de fin de contrat d'entretien :</strong> {{ new Date(vehicle.maintenanceContractEndDate).toLocaleDateString('fr-FR') }}</p>
            <p><strong>Kilométrage de fin de contrat d'entretien :</strong> {{ vehicle.maintenanceContractEndKm }}</p>
            <p><strong>Numéro de contrat d'entretien :</strong> {{ vehicle.maintenanceContractNumber }}</p>
            <p><strong>Véhicule déclassé :</strong> {{ vehicle.decommissioned ? 'Oui' : 'Non' }}</p>
            <p><strong>Autres informations :</strong> {{ vehicle.otherInformation }}</p>
        </BaseCard>
    </div>
    <div v-else>
        <p>Chargement des données du véhicule...</p>
    </div>
    <BackHomeButton />
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';
import useVehicleService from '../composables/vehicleService';
import BaseCard from '../components/BaseCard.vue';
import Vehicle from 'src/shared/vehicle';
import BackHomeButton from '../components/BackHomeButton.vue';

const route = useRoute();
const { getVehicleByVin } = useVehicleService();
const vehicle = ref<Vehicle>();

onMounted(async () => {
    const vin = route.params.vin as string;
    if (vin) {
        vehicle.value = await getVehicleByVin(vin);
    }
});
</script>

<style scoped>
button {
    margin-top: 1rem;
}

p {
    text-align: left;
    width: 100%;
}
</style>