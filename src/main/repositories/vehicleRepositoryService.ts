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

    ipcMain.handle('vehicleRepo:getById', (event, id: number) => {
        return vehicleRepository.getVehicleById(id);
    });

    ipcMain.handle('vehicleRepo:deleteVehicle', (event, id: number) => {
        return vehicleRepository.deleteVehicle(id);
    });

    ipcMain.handle('vehicleRepo:updateVehicle', (event, vehicle: Vehicle) => {
        return vehicleRepository.updateVehicle(vehicle);
    });

    ipcMain.handle('vehicleRepo:searchByNumVehicle', (event, numVehicle: number) =>{
        return vehicleRepository.searchByNumVehilce(numVehicle);
    });

    ipcMain.handle('vehicleRepo:searchByNumPlate', (event, numPlate:string) =>{
        return vehicleRepository.searchByNumPlate(numPlate);
    });

    ipcMain.handle('vehicleRepo:filterByDecommissioned', (event, decommissionedStatus: 'all' | 'decommissioned' | 'not-decommissioned') => {
        return vehicleRepository.filterByDecommissioned(decommissionedStatus);
    })
}