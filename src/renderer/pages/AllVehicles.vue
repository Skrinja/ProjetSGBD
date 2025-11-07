<template>
    <GoBackButton/>
    <BaseCard class="vehicle" v-for="vehicle in vehicles" :key="vehicle.vin" @click="goToDetails(vehicle.vin)">
        <span>VRM : {{ vehicle.numVehicle }}</span>
        <span>Plaque : {{ vehicle.numPlate }}</span>
    </BaseCard>
    <router-link to="/add-vehicle">
        <button>Ajouter un véhicule</button>
    </router-link>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import useVehicleService from '../composables/vehicleService';
import BaseCard from '../components/BaseCard.vue';
import { useRouter } from 'vue-router';
import GoBackButton from '../components/GoBackButton.vue';

const { vehicles, getAllVehicles } = useVehicleService();
const router = useRouter();

const goToDetails = (vin:string) => {
    router.push(`/vehicle/${vin}`)
}

onMounted(async () =>{
    await getAllVehicles();
})
</script>
<style scoped>
.vehicle{
    cursor:pointer;
}
</style>