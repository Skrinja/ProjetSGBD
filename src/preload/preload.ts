import { contextBridge } from "electron";
import { vehicleService } from "./vehicleService";
import { departmentService } from "./departmentService";
import IElectronService from "src/shared/interfaces/IElectronService";



contextBridge.exposeInMainWorld('electronService', {
    vehicle: vehicleService(),
    department: departmentService(),
} as IElectronService) 