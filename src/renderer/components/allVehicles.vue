<template>
    <ul>
        <li v-for="vehicle in vehicles">{{ vehicle }}</li>
    </ul>
    
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import useVehicleService from '../composables/vehicleService';

const { vehicles, getAllVehicles } = useVehicleService();

onMounted(async () =>{
    await getAllVehicles();
})
</script>