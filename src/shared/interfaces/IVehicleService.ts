import Vehicle from "../vehicle";

export default interface IVehicleService {
    getAllVehicles:() => Promise<Vehicle[]>
    addVehicle:(vehicle: Vehicle) => Promise<void>
}