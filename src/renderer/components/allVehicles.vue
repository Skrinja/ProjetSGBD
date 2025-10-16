<template>
    <BaseCard class="vehicle" v-for="vehicle in vehicles" :key="vehicle.vin" @click="goToDetails(vehicle.vin)">
        <span>VRM : {{ vehicle.numVehicle }}</span>
        <span>Plaque : {{ vehicle.numPlate }}</span>
    </BaseCard>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import useVehicleService from '../composables/vehicleService';
import BaseCard from './BaseCard.vue';
import { useRouter } from 'vue-router';

const { vehicles, getAllVehicles } = useVehicleService();
const router = useRouter();

const goToDetails = (vin:string) => {
    router.push(`/vehicle/${vin}`)
}

onMounted(async () =>{
    await getAllVehicles();
})
</script>
<style scopped>
.vehicle{
    cursor:pointer;
}
</style>