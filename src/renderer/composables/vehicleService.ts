import { ref } from "vue";

const vehicles = ref([]);

export default function useVehicleService() {
    const getAllVehicles = async () => {
        vehicles.value = await (window as any).electronService.vehicleRepo.getAllVehicles();
    }

    return {
        vehicles,
        getAllVehicles
    }
}