<template>
    <div class="home-bar">
        <BaseCard>
            <button class="go-to-vehicles" @click="handleClickVehicle">Véhicules</button>
            <p>{{ vehicles.length }}</p> 
        </BaseCard>
        <BaseCard>
            <button class="go-to-interventions">Interventions</button>
            <p>(Nbr interventions)</p>
        </BaseCard>
        <BaseCard>
            <button class="go-to-accidents">Accidents</button>
            <p>(Nbr accidents)</p>
        </BaseCard>
        <BaseCard>
            <button class="go-to-department" @click="handleClickDepartment">Services</button>
            <p>{{ departments.length }}</p>
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

    onMounted(async () => {
        await getAllVehicles();
        await getAllDepartments();
    });
</script>

<style>
.home-bar {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 1rem;
    gap : 1rem;
}
</style>