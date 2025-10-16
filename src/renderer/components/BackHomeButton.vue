<template>
    <button class="back-home" @click="handleClick">retour à l'accueil</button>
</template>
<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter();

const handleClick = () => {
    router.push('/')
}
</script>

<style scoped>
button {
    position: fixed;
    bottom: 20px;
    left: 20px;
    padding: 10px 20px;
}
</style>