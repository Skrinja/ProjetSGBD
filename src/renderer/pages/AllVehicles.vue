<template>
    <div class="page-header">
        <h1>Gestion des Véhicules</h1>
        <router-link to="/vehicle/add" class="button-link">
            Ajouter un véhicule
        </router-link>
    </div>
    
    <GoBackButton/>
    
    <div class="vehicle-list">
        <BaseCard class="vehicle-card" v-for="vehicle in vehicles" :key="vehicle.id" @click="goToDetails(vehicle.id)">
            <div class="vehicle-info">
                <span class="vehicle-vrm">VRM : {{ vehicle.numVehicle }}</span>
                <span class="vehicle-plate">Plaque : {{ vehicle.numPlate }}</span>
            </div>
            <span class="vehicle-details-link">Détails ➔</span>
        </BaseCard>
    </div>
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
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.vehicle-list {
    display: grid;
    grid-template-columns: 1fr; /* Une colonne par défaut */
    gap: 1rem;
}

/* Pour les écrans plus larges, on peut passer à 2 colonnes */
@media (min-width: 768px) {
    .vehicle-list {
        grid-template-columns: repeat(2, 1fr);
    }
}

.vehicle-card {
    cursor: pointer;
    flex-direction: row; /* Met les infos et le lien côte à côte */
    justify-content: space-between;
    align-items: center;
    transition: background-color 0.2s ease;
}

.vehicle-card:hover {
    background-color: #f8fafc; /* Léger fond au survol */
}

.vehicle-info {
    display: flex;
    flex-direction: column;
}

.vehicle-vrm {
    font-size: 1.1rem;
    font-weight: 600;
    color: #1e293b;
}

.vehicle-plate {
    font-size: 0.9rem;
    color: #475569;
}

.vehicle-details-link {
    font-size: 0.9rem;
    font-weight: 500;
    color: #2563eb;
}
</style>