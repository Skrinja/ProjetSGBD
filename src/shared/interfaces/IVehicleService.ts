import Vehicle from "../vehicle";

export default interface IVehicleService {
    getAllVehicles:() => Promise<Vehicle[]>
    addVehicle:(vehicle: Vehicle) => Promise<void>
    getVehicleById:(id: number) => Promise<Vehicle>
    deleteVehicle:(id: number) => Promise<void>
    updateVehicle:(vehicle: Vehicle) => Promise<void>
    searchByNumVehicle: (numVehicle: number) => Promise<Vehicle | null>
    searchByNumPlate: (numPlate: string) => Promise<Vehicle[]>
    filterByDecommissioned: (decommissionedStatus: 'all' | 'decommissioned' | 'not-decommissioned') => Promise<Vehicle[]>
    searchByBrandAndModel: (brandOrModel: string) => Promise<Vehicle[]>
}