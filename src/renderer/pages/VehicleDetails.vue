<template>
    <div v-if="vehicle">
        <div class="page-header">
            <h1>Détails du Véhicule (VRM : {{ vehicle.numVehicle }})</h1>
            <div class="action-buttons">
                <button class="secondary" @click="goToEdit(vehicle.id)">✏️ Modifier</button>
                <button class="danger" @click="handleDeleteClick(vehicle.id)">❌ Supprimer</button>
            </div>
        </div>
        <GoBackButton/>
        
        <BaseCard class="details-card">
            <div class="details-grid">
                <p><strong>N° de Châssis :</strong> {{ vehicle.vin }}</p>
                <p><strong>Plaque :</strong> {{ vehicle.numPlate }}</p>
                <p><strong>VRM :</strong> {{ vehicle.numVehicle }}</p>
                <p><strong>Marque :</strong> {{ vehicle.brand }}</p>
                <p><strong>Modèle :</strong> {{ vehicle.model }}</p>
                <p><strong>Mise en circulation :</strong> {{ new Date(vehicle.year).toLocaleDateString('fr-FR') }}</p>
                <p><strong>Carburant :</strong> {{ vehicle.fuel }}</p>
                <p><strong>Type de permis :</strong> {{ vehicle.licenseType }}</p>
                <p><strong>Configuration :</strong> {{ vehicle.configuration }}</p>
                <p><strong>Prochain C.T. :</strong> {{ new Date(vehicle.technicalInspectionDate).toLocaleDateString('fr-FR') }}</p>
                <p><strong>Service :</strong> {{ vehicle.departmentName }}</p>
                <p><strong>Taille pneus :</strong> {{ vehicle.tireSize || 'N/A' }}</p>
                <p><strong>N° assurance :</strong> {{ vehicle.insuranceNumber || 'N/A' }}</p>
                <p><strong>Omnium :</strong> {{ vehicle.omnium ? 'Oui' : 'Non' }}</p>
                <p><strong>Contrat entretien :</strong> {{ vehicle.maintenanceContract ? 'Oui' : 'Non' }}</p>
                <p><strong>Fin contrat (date) :</strong> {{ vehicle.maintenanceContractEndDate ? new Date(vehicle.maintenanceContractEndDate).toLocaleDateString('fr-FR') : 'N/A' }}</p>
                <p><strong>Fin contrat (km) :</strong> {{ vehicle.maintenanceContractEndKm || 'N/A' }}</p>
                <p><strong>N° contrat :</strong> {{ vehicle.maintenanceContractNumber || 'N/A' }}</p>
                <p><strong>Déclassé :</strong> {{ vehicle.decommissioned ? 'Oui' : 'Non' }}</p>
                <p class="full-width"><strong>Autres informations :</strong> {{ vehicle.otherInformation || 'Aucune' }}</p>
            </div>
        </BaseCard>
    </div>
    <div v-else>
        <p>Chargement des données du véhicule...</p>
    </div>
    <BackHomeButton />
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import useVehicleService from '../composables/vehicleService';
import BaseCard from '../components/BaseCard.vue';
import Vehicle from 'src/shared/vehicle';
import BackHomeButton from '../components/BackHomeButton.vue';
import GoBackButton from '../components/GoBackButton.vue';

const route = useRoute();
const router = useRouter();
const { getVehicleById, deleteVehicle } = useVehicleService();
const vehicle = ref<Vehicle>();

onMounted(async () => {
    const id = Number(route.params.id);
    if (id) {
        vehicle.value = await getVehicleById(id);
    }
});

const handleDeleteClick = async (id: number) => {
    if (confirm('Êtes-vous sûr de vouloir supprimer ce véhicule ?')) {
        await deleteVehicle(id);
        router.push('/vehicles');
    }
}

const goToEdit = (id: number) => {
    router.push(`/vehicle/edit/${id}`);
}

</script>

<style scoped>
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.action-buttons {
    display: flex;
    gap: 0.5rem;
}

.details-card {
    background-color: #ffffff;
}

.details-grid {
    display: grid;
    grid-template-columns: 1fr 1fr; /* 2 colonnes */
    gap: 1rem 1.5rem; /* Espacement vertical et horizontal */
    width: 100%;
}

.details-grid p {
    margin: 0;
    padding: 0.5rem;
    border-bottom: 1px solid #f1f5f9; /* Ligne de séparation légère */
}

.details-grid p strong {
    color: #475569; /* Couleur plus douce pour les labels */
    margin-right: 0.5rem;
}

.full-width {
    grid-column: 1 / -1; /* Prend toute la largeur */
}
</style>