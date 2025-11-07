<template>
    <button @click="goBack">↤</button>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter();

const goBack = () => {
    router.back();
}

</script>