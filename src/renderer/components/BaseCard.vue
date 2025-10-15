<template>
    <div class="card">
        <slot></slot>
    </div>
</template>

<script lang="ts" setup>
</script>

<style>
.card {
    display: flex;
    flex-direction: column;
    border: 1px solid black;
    background-color: rgba(155, 155, 155, .8);
    padding: 1rem;
    margin-bottom: 1rem; 
}
</style>