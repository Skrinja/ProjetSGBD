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