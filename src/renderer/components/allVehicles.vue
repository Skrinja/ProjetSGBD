<template>
    <BaseCard v-for="vehicle in vehicles" :key="vehicle.numVehicle">
        <span>VRM : {{ vehicle.numVehicle }}</span>
        <span>Plaque : {{ vehicle.numPlate }}</span>
    </BaseCard>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import useVehicleService from '../composables/vehicleService';
import BaseCard from './BaseCard.vue';

const { vehicles, getAllVehicles } = useVehicleService();

onMounted(async () =>{
    await getAllVehicles();
})
</script>