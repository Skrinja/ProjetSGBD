<template>
    <router-link to="/">
        <button class="back-home-btn">Retour à l'accueil</button>
    </router-link>
</template>
<script setup lang="ts">
</script>

<style scoped>
.back-home-btn {
    position: fixed;
    bottom: 20px;
    right: 20px; /* Changé pour être à droite */
    padding: 10px 20px;
    background-color: #475569; /* Gris */
    box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
    z-index: 100;
}

.back-home-btn:hover {
    background-color: #334155;
}
</style>