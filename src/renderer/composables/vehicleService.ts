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

    const getVehicleById = async (id: number) => {
        return await (window as any).electronService.vehicle.getVehicleById(id);
    }

    const deleteVehicle = async (id: number) => {
        await (window as any).electronService.vehicle.deleteVehicle(id);
        await getAllVehicles();
    }

    const updateVehicle = async (vehicle: Vehicle) => {
        await (window as any).electronService.vehicle.updateVehicle(vehicle);
        await getAllVehicles();
    }

    const searchByNumVehicle = async (NumVehicle: number) => {
        const result = await (window as any).electronService.vehicle.searchByNumVehicle(NumVehicle);
        vehicles.value = result ? [result] : []
    }

    const searchByNumPlate = async (numPlate: string) => {
        vehicles.value = await (window as any).electronService.vehicle.searchByNumPlate(numPlate);
    }

    const filterByDecommissioned = async (DecompressionedStatus: 'all' | 'decommissioned' | 'not-decommissioned') =>{
        vehicles.value = await (window as any).electronService.vehicle.filterByDecommissioned(DecompressionedStatus);
    }

    const searchByBrandAndModel = async (brandOrModel: string) => {
        vehicles.value = await (window as any).electronService.vehicle.searchByBrandAndModel(brandOrModel);
    }

    return {
        vehicles,
        getAllVehicles,
        getVehicleById,
        addVehicle,
        deleteVehicle,
        updateVehicle,
        searchByNumVehicle,
        searchByNumPlate,
        filterByDecommissioned,
        searchByBrandAndModel,
    }
}

