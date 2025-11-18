<template>
    <div class="page-header">
        <h1>Services</h1>
        </div>
    
    <GoBackButton/>

    <div class="department-list">
        <BaseCard class="department-card" v-for="department in departments" :key="department.id">
            <span class="department-name">{{ department.name }}</span>
            <span class="department-address">{{ department.serviceAddressNumber + ', ' + department.serviceAddressStreet }}</span>
        </BaseCard>
    </div>
</template>

<script setup lang="ts">
import GoBackButton from '../components/GoBackButton.vue';
import BaseCard from '../components/BaseCard.vue';
import useDepartmentService from '../composables/departmentService';
import { onMounted } from 'vue';

const { departments, getAllDepartments } = useDepartmentService();

onMounted(async () =>{
    await getAllDepartments();
})

</script>

<style scoped>
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.department-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1rem;
}

.department-card {
    align-items: flex-start; /* Aligne le contenu à gauche */
}

.department-name {
    font-size: 1.2rem;
    font-weight: 600;
    color: #1e293b;
    margin-bottom: 0.25rem;
}

.department-address {
    font-size: 0.95rem;
    color: #475569;
}
</style>