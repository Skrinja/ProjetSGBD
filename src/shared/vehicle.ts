import { FuelType } from "./enums/fuelType";

export default interface Vehicle {
    vin: string;
    numPlate: string;
    numVehicle: number;
    brand: string;
    model: string;
    year: Date;
    fuel: FuelType;
}