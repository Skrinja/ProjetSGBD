<template>
  <div class="app-container">
    <SideBarNavigation />
    <main class="main-content">
      <RouterView />
    </main>
  </div>
</template>

<script setup lang="ts">
import SideBarNavigation from './renderer/components/SideBarNavigation.vue';
</script>

<style>
/* Styles globaux pour que l'application prenne toute la hauteur */
html, body {
  height: 100%;
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  overflow: hidden; /* Empêche le défilement sur le body */
}

#app {
  height: 100%;
}

.app-container {
  display: flex;
  height: 100vh; /* Assure que le conteneur principal prend toute la hauteur */
}

.main-content {
  flex-grow: 1; /* Permet au contenu principal de prendre tout l'espace restant */
  padding: 1.5rem;
  overflow-y: auto; /* Ajoute un défilement vertical au contenu principal si nécessaire */
  height: 100vh; /* Nécessaire pour que overflow-y fonctionne correctement */
  box-sizing: border-box; /* Inclut le padding dans le calcul de la hauteur */
}

button {
  cursor: pointer;
}
</style>