<template>
    <div class="page-header">
        <h1>Véhicules</h1>
        <router-link to="/vehicle/add" class="button-link">
            Ajouter un véhicule
        </router-link>
    </div>
    
    <GoBackButton/>

    <div class="search-box">
        <input type="text" placeholder="Rechercher..." v-model="searchQuery" @keyup.enter="handleSearch"/>
        <select v-model="searchColumn">
            <option v-for="column in seartchableColumns" :key="column.value" :value="column.value">
                {{ column.label }}
            </option>
        </select>
    </div>

    <div class="filter-box">
        <label for="decommissioned-filter">Statut Déclassé :</label>
        <select id="decommissioned-filter" v-model="decommissionedFilter" @change="handleFilterByDecommissioned">
            <option value="all">Tous</option>
            <option value="decommissioned">Oui</option>
            <option value="not-decommissioned">Non</option>
        </select>
    </div>
    
    <div class="vehicle-list">
        <div class="list-header">
            <span class="header-vrm">VRM</span>
            <span class="header-plate">Plaque</span>
            <span class="header-brand-model">Marque / Modèle</span>
            <span class="header-department">Service</span>
            <span class="header-config">Configuration</span>
            <span class="header-license">Permis</span>
            <span class="header-decommissioned">Déclassé</span>
        </div>
        
        <BaseCard class="vehicle-card" v-for="vehicle in vehicles" :key="vehicle.id" @click="goToDetails(vehicle.id)">
            <span class="vehicle-vrm">{{ vehicle.numVehicle }}</span>
            <span class="vehicle-plate">{{ vehicle.numPlate }}</span>
            <span class="vehicle-brand-model">{{ vehicle.brand }} {{ vehicle.model }}</span>
            <span class="vehicle-department">{{ vehicle.departmentName }}</span>
            <span class="vehicle-configuration">{{ vehicle.configuration }}</span>
            <span class="vehicle-license">{{ vehicle.licenseType }}</span>
            <span class="vehicle-decommissioned">{{ vehicle.decommissioned ? 'Oui' : 'Non' }}</span>
        </BaseCard>
    </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import useVehicleService from '../composables/vehicleService';
import BaseCard from '../components/BaseCard.vue';
import { useRouter } from 'vue-router';
import GoBackButton from '../components/GoBackButton.vue';
import { ref } from 'vue';

const { vehicles, getAllVehicles, searchByNumVehicle, searchByNumPlate, filterByDecommissioned, searchByBrandAndModel} = useVehicleService();
const router = useRouter();

const goToDetails = (id: number) => {
    router.push(`/vehicle/${id}`)
}

onMounted(async () =>{
    await getAllVehicles();
})

const searchQuery = ref('');
const searchColumn = ref('numVehicle');
const seartchableColumns = [
    {label: 'VRM', value: 'numVehicle'},
    {label: 'Plaque', value: 'numPlate'},
    {label: 'Marque ou Modèle', value: 'brandModel'},
]; 

const handleSearch = async () => { // Je vais mettre toutes les recherches ici avec un switch case
    if (!searchQuery.value) {
        await filterByDecommissioned(decommissionedFilter.value);
        return;
    }
    switch (searchColumn.value) {
        case 'numVehicle':
            const numValue = Number(searchQuery.value);
            searchByNumVehicle(numValue);
            break;
        case 'numPlate':
            searchByNumPlate(searchQuery.value);
            break;
        case 'brandModel':
            searchByBrandAndModel(searchQuery.value); 
            break;
    }
}

const decommissionedFilter = ref<'all' | 'decommissioned' | 'not-decommissioned'>('all');

const handleFilterByDecommissioned = async () => {
    searchQuery.value = '';
    await filterByDecommissioned(decommissionedFilter.value);
}

</script>

<style scoped>
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

/* Style de base pour la liste: colonnes empilées (mobile-first) */
.vehicle-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

/* L'en-tête de la grille est masqué sur les petits écrans */
.list-header {
    display: none;
}

/* Styles de la carte sur les petits écrans (BaseCard utilise display: flex; flex-direction: column) */
.vehicle-card {
    cursor: pointer;
    /* Reset BaseCard properties to allow customization */
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    padding: 1rem 1.5rem; 
    transition: background-color 0.2s ease;
}

.vehicle-card:hover {
    background-color: #f8fafc;
}

/* Affichage des champs en bloc sur les petits écrans */
.vehicle-card > span {
    display: block; 
    margin-bottom: 0.25rem;
    font-size: 0.9rem;
    color: #475569;
}

.vehicle-vrm {
    font-size: 1.1rem;
    font-weight: 600;
    color: #1e293b;
}

/* Rapproche le lien de détail du bas sur les petits écrans */
.vehicle-details-link {
    margin-top: 0.5rem;
    color: #2563eb;
    align-self: flex-end; /* Pousse le lien à droite */
}

/* --- Vue Tabulaire (Tablette / Desktop) --- */
@media (min-width: 768px) {
    .vehicle-list {
        /* Supprime les marges individuelles pour grouper les cartes dans la grille */
        gap: 0;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        overflow: hidden;
    }

    /* Mise en page de la grille pour l'en-tête et les lignes (les cartes) */
    .list-header, .vehicle-card {
        display: grid;
        /* 8 colonnes : VRM | Plaque | Marque/Modèle | Service | Config | Permis | Déclassé | Détails */
        grid-template-columns: minmax(70px, 0.5fr) minmax(100px, 1fr) minmax(150px, 1.5fr) minmax(100px, 1fr) minmax(100px, 1fr) 70px 70px 70px;
        gap: 1rem;
        align-items: center;
        padding: 0.75rem 1.5rem;
    }
    
    /* Style de l'en-tête */
    .list-header {
        display: grid;
        background-color: #e2e8f0;
        font-weight: 600;
        color: #475569;
        font-size: 0.9rem;
    }

    /* Style des lignes de véhicule (BaseCard) */
    .vehicle-card {
        border: none;
        border-radius: 0;
        border-bottom: 1px solid #f1f5f9;
        box-shadow: none;
        flex-direction: initial; /* Annule flex-direction: column de BaseCard */
        
    }

    .vehicle-card:last-child {
        border-bottom: none;
    }
    
    /* Affichage des champs dans la grille - alignement */
    .vehicle-card > span {
        margin: 0;
        font-size: 1rem;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .vehicle-vrm {
        font-weight: 600;
        color: #1e293b;
    }

    .vehicle-details-link {
        text-align: right;
        font-size: 0.95rem;
        align-self: center;
        margin: 0;
    }

    .search-box {
        display: flex;
        gap: 0.5rem;
        margin-bottom: 1rem;
    }
}

/* Styles pour le filtre de statut déclassé */
.filter-box {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
    padding: 0.5rem 0;
}

.filter-box label {
    font-weight: 500;
    color: #475569;
}

.filter-box select {
    padding: 0.2rem;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    font-size: 1rem;
    transition: border-color 0.2s, box-shadow 0.2s;
}
</style>