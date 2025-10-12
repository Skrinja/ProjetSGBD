<template>
    <h2>Ajouter un Nouveau Véhicule</h2>
    <form @submit.prevent="handleSubmit"> <!-- @ = raccourci de v-on et .prevent empeche le submit de rafraichir la page -->
        <div>
            <label for="num-plate"></label>
            <input id="num-plate" v-model="numPlate" required placeholder="Plaque d'immatriculation" />
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
import useSetMessageService from '../composables/setMessageService';

const numPlate = ref();
const numVehicle = ref();

const { addVehicle } = useVehicleService();
const { successMessage, errorMessage, setMessage } = useSetMessageService();

const resetForm = () => {
    numPlate.value = '';
    numVehicle.value = null;
}

const handleSubmit = async () => {
    if (
        !numPlate.value ||
        !numVehicle.value ||
        isNaN(numVehicle.value) ||
        numVehicle.value <= 0
    ) {
        setMessage('error', "Erreur dans la saisie");
        return;
    }

    try {
        await addVehicle({ numPlate: numPlate.value, numVehicle: numVehicle.value });
        setMessage('success', "Véhicule sauvegardé !");
        resetForm();

    } catch (error) {
        console.error("Erreur lors de l'ajout du véhicule:", error);
        setMessage('error', "Un problème est survenu");
    }
}
</script>