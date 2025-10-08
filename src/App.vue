<template>
  <h1>💖 Hello World!</h1>
  <p>Welcome to your Electron application.</p>
  <allVehicles/>
</template>

<script setup>
import allVehicles from './renderer/components/allVehicles.vue';
console.log('👋 This message is being logged by "App.vue", included via Vite');
</script>