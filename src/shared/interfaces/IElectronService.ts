import IDepartmentService from "./IDepartmentService";
import IVehicleService from "./IVehicleService";

export default interface IElectronService {
    vehicle: IVehicleService
    department: IDepartmentService
}

declare global {
    interface Window {
        electronService: IElectronService
    }
}