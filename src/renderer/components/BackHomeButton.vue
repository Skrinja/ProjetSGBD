<template>
    <router-link to="/">
        <button>Retour à l'accueil</button>
    </router-link>
</template>
<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter();

</script>

<style scoped>
button {
    position: fixed;
    bottom: 20px;
    left: 20px;
    padding: 10px 20px;
}
</style>