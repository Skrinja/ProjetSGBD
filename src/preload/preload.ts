import { contextBridge, ipcRenderer } from "electron";


contextBridge.exposeInMainWorld('electronService', {
    vehicleRepo: {
        getAllVehicles: () => ipcRenderer.invoke('vehicleRepo:getAll')
    }
})