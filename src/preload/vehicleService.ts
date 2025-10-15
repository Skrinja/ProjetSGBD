import { ipcRenderer } from "electron";
import IVehicleService from "src/shared/interfaces/IVehicleService";
import Vehicle from "src/shared/vehicle";

export function vehicleService(): IVehicleService {
    return {
        getAllVehicles: () => ipcRenderer.invoke('vehicleRepo:getAll'),
        addVehicle: (vehicle: Vehicle) => ipcRenderer.invoke('vehicleRepo:addVehicle', vehicle)
    }
}