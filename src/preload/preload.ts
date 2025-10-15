import { contextBridge, ipcRenderer } from "electron";
import { vehicleService } from "./vehicleService";
import IElectronService from "src/shared/interfaces/IElectronService";


contextBridge.exposeInMainWorld('electronService', {
    vehicle: vehicleService()
} as IElectronService) 