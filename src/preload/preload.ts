import { contextBridge, ipcRenderer } from "electron";


contextBridge.exposeInMainWorld('electronService', {
    vehicleRepo: {
        getAllVehicles: () => ipcRenderer.invoke('vehicleRepo:getAll'),
        addVehicle: (numPlate: string, numVehicle: number) => ipcRenderer.invoke('vehicleRepo:addVehicle', numPlate, numVehicle)
    }
})