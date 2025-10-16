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