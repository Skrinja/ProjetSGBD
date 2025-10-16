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
    align-items: center;
    border: 1px solid black;
    background-color: rgba(37, 95, 255, 0.8);
    padding: 1rem;
    margin: 1rem; 
}
</style>