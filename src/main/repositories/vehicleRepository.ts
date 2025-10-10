import Vehicle from "src/shared/vehicle";

export default class VehicleRepository {
  vehicles: Vehicle[] = [
    {
      numPlate: "1AAA222",
      numVehicle: 1,
    },
    {
      numPlate: "1ZZZ333",
      numVehicle: 2,
    },
  ];

  getAllVehicles(): Vehicle[]{
    return this.vehicles;
  }

  addVehicle(vehicle: Vehicle){
    this.vehicles.push(vehicle);
  }
}
