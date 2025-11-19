<template>
    <h1>Tableau de bord</h1>
    <div class="home-grid">
        <BaseCard class="home-card" @click="handleClickVehicle">
            <span class="card-title">Véhicules</span>
            <span class="card-count">{{ vehicles.length }}</span>
            <span class="card-link">Gérer les véhicules ➔</span>
        </BaseCard>
        <BaseCard class="home-card">
            <span class="card-title">Interventions</span>
            <span class="card-count">0</span> <span class="card-link">Voir les interventions ➔</span>
        </BaseCard>
        <BaseCard class="home-card">
            <span class="card-title">Accidents</span>
            <span class="card-count">0</span> <span class="card-link">Consulter les dossiers ➔</span>
        </BaseCard>
        <BaseCard class="home-card" @click="handleClickDepartment">
            <span class="card-title">Services</span>
            <span class="card-count">{{ departments.length }}</span>
            <span class="card-link">Voir les services ➔</span>
        </BaseCard>
    </div>
</template>

<script setup lang="ts">
    import { useRouter } from 'vue-router';
    import BaseCard from '../components/BaseCard.vue';
    import useVehicleService from '../composables/vehicleService';
    import { onMounted } from 'vue';
    import useDepartmentService from '../composables/departmentService';

    const { vehicles, getAllVehicles } = useVehicleService();
    const { departments, getAllDepartments } = useDepartmentService();
    const router = useRouter();

    const handleClickVehicle = () => {
        router.push('/vehicles');
    }

    const handleClickDepartment = () => {
        router.push('/departments')
    }

    onMounted(async () => { // A OPTI POUR NE PAS TOUT CHARGER A CHAQUE FOIS (On veut juste le nombre)
        await getAllVehicles();
        await getAllDepartments();
    });
</script>

<style scoped>
.home-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* Grille responsive */
    gap: 1.5rem;
    padding: 1rem 0;
}

.home-card {
    cursor: pointer;
    transition: all 0.2s ease;
    background-color: #ffffff;
    align-items: flex-start; /* Aligne le contenu à gauche */
    padding: 1.5rem;
}

.home-card:hover {
    transform: translateY(-5px); /* Effet de lévitation */
    box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
}

.card-title {
    font-size: 1.2rem;
    font-weight: 600;
    color: #334155;
    margin-bottom: 0.5rem;
}

.card-count {
    font-size: 2.5rem;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 1rem;
}

.card-link {
    font-size: 0.9rem;
    font-weight: 500;
    color: #2563eb;
}
</style>