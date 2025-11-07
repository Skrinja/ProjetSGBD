import Vehicle from "../vehicle";

export default interface IVehicleService {
    getAllVehicles:() => Promise<Vehicle[]>
    addVehicle:(vehicle: Vehicle) => Promise<void>
    getVehicleByVin:(vin: string) => Promise<Vehicle>
    deleteVehicle:(vin: string) => Promise<void>
}