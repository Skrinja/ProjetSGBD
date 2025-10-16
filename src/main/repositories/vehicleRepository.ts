import { FuelType } from "../../shared/enums/fuelType"; 
import Vehicle from "../../shared/vehicle";

export default class VehicleRepository {
  vehicles: Vehicle[] = [
{
      vin: "VF123ABCDEF456789",
      numPlate: "1AAA222",
      numVehicle: 1,
      brand: "Renault",
      model: "Clio",
      year: new Date("2020-03-12"),
      fuel: FuelType.Petrol,
    },
    {
      vin: "VF987ZYXWVU654321",
      numPlate: "1ZZZ333",
      numVehicle: 2,
      brand: "Peugeot",
      model: "208",
      year: new Date("2022-12-23"),
      fuel: FuelType.Diesel,
    },
  ];

  getAllVehicles(): Vehicle[]{
    return this.vehicles;
  }

  addVehicle(vehicle: Vehicle): void{
    this.vehicles.push(vehicle);
  }

  getVehicleByVin(vin:string): Vehicle{
    return this.vehicles.find(vehicle => vehicle.vin === vin)
  }
}
