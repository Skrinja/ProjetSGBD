<template>
  <h1>Véhicules</h1>
  
  <button @click="currentView = 'list'" v-if="currentView === 'form'">
    Retour à la Liste
  </button>
  <button @click="currentView = 'form'" v-if="currentView === 'list'">
    Ajouter un Véhicule
  </button>
  
  <div v-if="currentView === 'list'">
    <AllVehicles/>
  </div>

  <div v-else-if="currentView === 'form'">
    <AddVehicleForm/>
  </div>

  <BackHomeButton/>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import AllVehicles from '../components/AllVehicles.vue';
import AddVehicleForm from '../components/AddVehicleForm.vue';
import BackHomeButton from '../components/BackHomeButton.vue';

const currentView = ref('list');
</script>