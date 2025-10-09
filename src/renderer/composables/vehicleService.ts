import { ref } from "vue";

const vehicles = ref([]);

export default function useVehicleService() {
    const getAllVehicles = async () => {
        vehicles.value = await (window as any).electronService.vehicleRepo.getAllVehicles();
    }

    const addVehicle = async (numPlate: string, numVehicle: number) => {
        await (window as any).electronService.vehicleRepo.addVehicle(numPlate, numVehicle);
        await getAllVehicles();
    }

    return {
        vehicles,
        getAllVehicles,
        addVehicle
    }
}

