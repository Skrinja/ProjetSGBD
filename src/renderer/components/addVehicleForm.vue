<template>
    <h2>Ajouter un Nouveau Véhicule</h2>
    <form @submit.prevent="handleSubmit">
        <div>
            <label for="plate"></label>
            <input id="plate" v-model="numPlate" required placeholder="Plaque d'immatriculation"/>
        </div>
        
        <div>
            <label for="vehicle-num"></label>
            <input id="vehicle-num" v-model.number="numVehicle" required placeholder="VRM" />
        </div>
        
        <button type="submit">Sauvegarder</button>
    </form>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import useVehicleService from '../composables/vehicleService';

const numPlate = ref();
const numVehicle = ref(); 

const { addVehicle } = useVehicleService();

const handleSubmit = async () => {
    if (!numPlate.value || numVehicle.value <= 0) {
        alert("Veuillez remplir tous les champs correctement.");
        return;
    }

    try {
        await addVehicle(numPlate.value, numVehicle.value.toString());

        numPlate.value = '';
        numVehicle.value = 0;
        
    } catch (error) {
        console.error("Erreur lors de l'ajout du véhicule:", error);
        alert("Une erreur est survenue lors de l'ajout.");
    }
}
</script>