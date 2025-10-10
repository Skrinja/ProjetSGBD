import { contextBridge, ipcRenderer } from "electron";
import Vehicle from "src/shared/vehicle";


contextBridge.exposeInMainWorld('electronService', {
    vehicleRepo: {
        getAllVehicles: () => ipcRenderer.invoke('vehicleRepo:getAll'),
        addVehicle: (vehicle: Vehicle) => ipcRenderer.invoke('vehicleRepo:addVehicle', vehicle)
    }
})