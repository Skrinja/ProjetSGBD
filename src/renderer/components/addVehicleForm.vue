<template>
    <h2>Ajouter un Nouveau Véhicule</h2>
    <form @submit.prevent="handleSubmit">
        <div>
            <label for="num-plate"></label>
            <input id="num-plate" v-model="numPlate" required placeholder="Plaque d'immatriculation"/>
        </div>
        
        <div>
            <label for="num-vehicle"></label>
            <input id="num-vehicle" v-model.number="numVehicle" required placeholder="VRM" />
        </div>
        
        <button type="submit">Sauvegarder</button>
    </form>
    <p v-if="successMessage" style="color: green; font-weight: bold; margin-top: 15px;">
        {{ successMessage }}
    </p>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import useVehicleService from '../composables/vehicleService';

const numPlate = ref();
const numVehicle = ref();
const successMessage = ref('');

const { addVehicle } = useVehicleService();

const handleSubmit = async () => {
    successMessage.value = ''; 
    if (
        !numPlate.value || 
        numVehicle.value === null || 
        isNaN(numVehicle.value) || 
        numVehicle.value <= 0
    ) {
        alert("Veuillez remplir tous les champs correctement (le numéro de véhicule doit être un nombre entier positif).");
        return;
    }

    try {
        await addVehicle(numPlate.value, numVehicle.value);
        numPlate.value = '';
        numVehicle.value = null;
        successMessage.value = 'Véhicule sauvegardé !'
        
    } catch (error) {
        console.error("Erreur lors de l'ajout du véhicule:", error);
        alert("Une erreur est survenue lors de l'ajout.");
    }
}
</script>