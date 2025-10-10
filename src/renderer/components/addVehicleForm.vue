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
    <p v-if="successMessage">
        {{ successMessage }}
    </p>
    <p v-if="errorMessage">
        {{ errorMessage }}
    </p>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import useVehicleService from '../composables/vehicleService';


const numPlate = ref();
const numVehicle = ref();
const successMessage = ref('');
const errorMessage = ref('');

const { addVehicle } = useVehicleService();

const handleSubmit = async () => {
    let message = 'Véhicule sauvegardé !'; 
    if (
        !numPlate.value || 
        numVehicle.value === null || 
        isNaN(numVehicle.value) || 
        numVehicle.value <= 0
    ) {
        message = "Veuillez remplir tous les champs correctement (le numéro de véhicule doit être un nombre entier positif).";
        errorMessage.value = message;
        return;
    }

    try {
        await addVehicle({ numPlate: numPlate.value, numVehicle: numVehicle.value });
        numPlate.value = '';
        numVehicle.value = null;
        successMessage.value = message;
        
    } catch (error) {
        console.error("Erreur lors de l'ajout du véhicule:", error);
        message = "Une erreur est survenue lors de l'ajout."
        errorMessage.value = message;
    }
}
</script>