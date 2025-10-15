import IVehicleService from "./IVehicleService";

export default interface IElectronService {
    vehicle: IVehicleService
}

declare global {
    interface Window {
        electronService: IElectronService
    }
}