import Vehicle from "src/shared/vehicle";
import VehicleRepository from "./vehicleRepository";
import { ipcMain } from "electron/main";

const vehicleRepository = new VehicleRepository();

export function registerVehicleHandlers() {
    
    ipcMain.handle('vehicleRepo:getAll', () =>{
        return vehicleRepository.getAllVehicles();
    })

    ipcMain.handle('vehicleRepo:addVehicle', (event, vehicle: Vehicle) => {
        vehicleRepository.addVehicle(vehicle);
    })
}