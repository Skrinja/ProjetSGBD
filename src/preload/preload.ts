import { contextBridge, ipcRenderer } from "electron";
import vehicle from "src/shared/vehicle";


contextBridge.exposeInMainWorld('electronService', {
    vehicleRepo: {
        getAllVehicles: () => ipcRenderer.invoke('vehicleRepo:getAll'),
        addVehicle: (vehicle: vehicle) => ipcRenderer.invoke('vehicleRepo:addVehicle', vehicle)
    }
})