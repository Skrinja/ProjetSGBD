<template>
    <h2>Ajouter un Nouveau Véhicule</h2>
    <form @submit.prevent="handleSubmit">
        <div>
            <input v-model="vin" required placeholder="N° de châssis (VIN)" />
        </div>
        <div>
            <input v-model="numPlate" required placeholder="Plaque d'immatriculation" />
        </div>
        <div>
            <input v-model.number="numVehicle" type="number" required placeholder="VRM" />
        </div>
        <div>
            <input v-model="brand" required placeholder="Marque" />
        </div>
        <div>
            <input v-model="model" required placeholder="Modèle" />
        </div>
        <div>
            <label for="year">Date de mise en circulation</label>
            <input id="year" v-model="year" type="date" required />
        </div>
        <div>
            <label for="fuel-type">Carburant</label>
            <select id="fuel-type" v-model="fuel" required>
                <option v-for="fuelType in fuelTypes" :key="fuelType" :value="fuelType">
                    {{ fuelType }}
                </option>
            </select>
        </div>
        <button type="submit">Sauvegarder</button>
    </form>
    <p v-if="successMessage" style="color: green;">{{ successMessage }}</p>
    <p v-if="errorMessage" style="color: red;">{{ errorMessage }}</p>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import useVehicleService from '../composables/vehicleService';
import useSetMessageService from '../composables/setMessageService';
import { FuelType } from '../../shared/enums/vehicleEnum';

const vin = ref('');
const numPlate = ref('');
const numVehicle = ref<number>();
const brand = ref('');
const model = ref('');
const year = ref(''); 
const fuel = ref<FuelType>(FuelType.Petrol); 

const fuelTypes = ref(Object.values(FuelType));
const { addVehicle } = useVehicleService();
const { successMessage, errorMessage, setMessage } = useSetMessageService();

const resetForm = () => {
    vin.value = '';
    numPlate.value = '';
    numVehicle.value = null;
    brand.value = '';
    model.value = '';
    year.value = '';
    fuel.value = FuelType.Petrol;
};

const handleSubmit = async () => {
    if (!vin.value || !numPlate.value || !numVehicle.value) {
        setMessage('error', "Veuillez remplir tous les champs.");
        return;
    }
    try {
        await addVehicle({
            vin: vin.value,
            numPlate: numPlate.value,
            numVehicle: numVehicle.value,
            brand: brand.value,
            model: model.value,
            year: new Date(year.value), 
            fuel: fuel.value,
        });
        setMessage('success', "Véhicule sauvegardé !");
        resetForm();
    } catch (error) {
        console.error("Erreur lors de l'ajout du véhicule:", error);
        setMessage('error', "Un problème est survenu");
    }
};
</script>

<style scoped>
form {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    margin-top: 1rem;
}
input, select {
    padding: 8px;
    width: 100%;
    box-sizing: border-box;
}
</style>