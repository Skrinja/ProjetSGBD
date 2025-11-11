import Vehicle from "src/shared/vehicle";
import { ref } from "vue";

const vehicles = ref<Vehicle[]>([]);

export default function useVehicleService() {
    const getAllVehicles = async () => {
        vehicles.value = await (window as any).electronService.vehicle.getAllVehicles();
    }

    const addVehicle = async (vehicle: Vehicle) => {
        await (window as any).electronService.vehicle.addVehicle(vehicle);
        await getAllVehicles();
    }

    const getVehicleByVin = async (vin: string) => {
        return await (window as any).electronService.vehicle.getVehicleByVin(vin);
    }

    const deleteVehicle = async (vin: string) => {
        await (window as any).electronService.vehicle.deleteVehicle(vin);
        await getAllVehicles();
    }

    const updateVehicle = async (vehicle: Vehicle) => {
        await (window as any).electronService.vehicle.updateVehicle(vehicle);
        await getAllVehicles();
    }

    return {
        vehicles,
        getAllVehicles,
        getVehicleByVin,
        addVehicle,
        deleteVehicle,
        updateVehicle,
    }
}

