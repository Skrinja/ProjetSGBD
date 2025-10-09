<template>
  <h1>Gestionnaire de Véhicules</h1>
  
  <button @click="currentView = 'list'" v-if="currentView === 'form'">
    Retour à la Liste
  </button>
  <button @click="currentView = 'form'" v-if="currentView === 'list'">
    Ajouter un Véhicule
  </button>
  
  <div v-if="currentView === 'list'">
    <allVehicles/>
  </div>

  <div v-else-if="currentView === 'form'">
    <addVehicleForm/>
  </div>
  
</template>

<script setup>
import { ref } from 'vue';
import allVehicles from './renderer/components/allVehicles.vue';
import addVehicleForm from './renderer/components/addVehicleForm.vue';

const currentView = ref('list'); 
</script>