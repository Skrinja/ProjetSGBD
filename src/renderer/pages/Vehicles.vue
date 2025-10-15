<template>
  <h1>Véhicules</h1>
  
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
  
  <ButtonBackHome/>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import allVehicles from '../components/AllVehicles.vue';
import addVehicleForm from '../components/AddVehicleForm.vue';
import ButtonBackHome from '../components/BackHomeButton.vue';

const currentView = ref('list'); 
</script>