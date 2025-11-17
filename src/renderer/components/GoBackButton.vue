<template>
    <button @click="goBack" class="go-back-btn">⟵ Retour</button>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter();

const goBack = () => {
    router.back();
}

</script>

<style scoped>
.go-back-btn {
    background-color: transparent;
    color: #475569; /* Gris */
    padding: 0.25rem 0.5rem;
    margin: 0 0 1rem 0; /* Marge en bas */
    font-size: 0.95rem;
    font-weight: 500;
}
.go-back-btn:hover {
    background-color: #f1f5f9; /* Fond très léger au survol */
    color: #1e293b;
}
</style>