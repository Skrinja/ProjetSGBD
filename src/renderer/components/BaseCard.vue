<template>
    <div class="card">
        <slot></slot>
    </div>
</template>

<script setup lang="ts">
</script>

<style>
.card {
    display: flex;
    flex-direction: column;
    align-items: stretch; /* Aligne les enfants sur toute la largeur */
    background-color: #ffffff; /* Fond blanc */
    border: 1px solid #e2e8f0; /* Bordure grise claire */
    border-radius: 8px; /* Bords arrondis */
    padding: 1.5rem; /* Padding interne */
    margin: 0.5rem 0; /* Marge verticale */
    box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1); /* Ombre légère */
    width: 100%; /* Prend toute la largeur disponible */
    box-sizing: border-box; /* Inclut padding et bordure dans la largeur */
}
</style>