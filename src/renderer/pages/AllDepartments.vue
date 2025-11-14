<template>
    <GoBackButton/>
    <BaseCard class="department" v-for="department in departments" :key="department.id">
        <span>{{ department.name }}</span>
        <span>{{ department.serviceAddressNumber + ', ' + department.serviceAddressStreet }}</span>
    </BaseCard>
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

<style>

</style>