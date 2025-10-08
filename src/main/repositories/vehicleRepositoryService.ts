import VehicleRepository from "./vehicleRepository";
import { ipcMain } from "electron/main";

const vehicleRepository = new VehicleRepository();

export function registerVehicleHandlers() {
    
    ipcMain.handle('vehicleRepo:getAll', () =>{
        return vehicleRepository.getAllVehicles();
    })
}