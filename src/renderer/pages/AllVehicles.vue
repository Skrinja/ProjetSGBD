<template>
    <GoBackButton/>
    <router-link to="/vehicle/add">
        <button>Ajouter un véhicule</button>
    </router-link>
    <BaseCard class="vehicle" v-for="vehicle in vehicles" :key="vehicle.id" @click="goToDetails(vehicle.id)">
        <span>VRM : {{ vehicle.numVehicle }}</span>
        <span>Plaque : {{ vehicle.numPlate }}</span>
    </BaseCard>

</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import useVehicleService from '../composables/vehicleService';
import BaseCard from '../components/BaseCard.vue';
import { useRouter } from 'vue-router';
import GoBackButton from '../components/GoBackButton.vue';

const { vehicles, getAllVehicles } = useVehicleService();
const router = useRouter();

const goToDetails = (id: number) => {
    router.push(`/vehicle/${id}`)
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