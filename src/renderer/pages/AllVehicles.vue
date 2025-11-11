<template>
    <GoBackButton/>
    <router-link to="/add-vehicle">
        <button>Ajouter un véhicule</button>
    </router-link>
    <BaseCard class="vehicle" v-for="vehicle in vehicles" :key="vehicle.vin" @click="goToDetails(vehicle.vin)">
        <span>VRM : {{ vehicle.numVehicle }}</span>
        <span>Plaque : {{ vehicle.numPlate }}</span>
        <button @click.stop="handleDeleteClick(vehicle.vin)">❌</button> <!-- .stop pour empêcher la propagation du clic au parent et ne faire que celui-ci -->
    </BaseCard>

</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import useVehicleService from '../composables/vehicleService';
import BaseCard from '../components/BaseCard.vue';
import { useRouter } from 'vue-router';
import GoBackButton from '../components/GoBackButton.vue';

const { vehicles, getAllVehicles, deleteVehicle } = useVehicleService();
const router = useRouter();

const goToDetails = (vin:string) => {
    router.push(`/vehicle/${vin}`)
}

onMounted(async () =>{
    await getAllVehicles();
})

const handleDeleteClick = async (vin: string) => {
    if (confirm('Êtes-vous sûr de vouloir supprimer ce véhicule ?')) {
        await deleteVehicle(vin);
    }

}

</script>
<style scoped>
.vehicle{
    cursor:pointer;
}
</style>