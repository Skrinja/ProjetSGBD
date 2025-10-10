import Vehicle from "src/shared/vehicle";
import { ref } from "vue";

const vehicles = ref<Vehicle[]>([]);

export default function useVehicleService() {
    const getAllVehicles = async () => {
        vehicles.value = await (window as any).electronService.vehicleRepo.getAllVehicles();
    }

    const addVehicle = async (vehicle: Vehicle) => {
        await (window as any).electronService.vehicleRepo.addVehicle(vehicle);
        await getAllVehicles();
    }

    return {
        vehicles,
        getAllVehicles,
        addVehicle
    }
}

