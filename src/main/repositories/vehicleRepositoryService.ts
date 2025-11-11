import Vehicle from "../../shared/vehicle"; 
import VehicleRepository from "./vehicleRepository";
import { ipcMain } from "electron/main";


export function registerVehicleHandlers() {
    const vehicleRepository = new VehicleRepository();
        
    ipcMain.handle('vehicleRepo:getAll', () =>{
        return vehicleRepository.getAllVehicles();
    });

    ipcMain.handle('vehicleRepo:addVehicle', (event, vehicle: Vehicle) => {
        vehicleRepository.addVehicle(vehicle);
    });

    ipcMain.handle('vehicleRepo:getByVin', (event, vin: string) => {
        return vehicleRepository.getVehicleByVin(vin);
    });

    ipcMain.handle('vehicleRepo:deleteVehicle', (event, vin: string) => {
        return vehicleRepository.deleteVehicle(vin);
    });

    ipcMain.handle('vehicleRepo:updateVehicle', (event, vehicle: Vehicle) => {
        return vehicleRepository.updateVehicle(vehicle);
    });
}