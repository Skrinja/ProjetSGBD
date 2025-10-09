import vehicle from "src/shared/vehicle";

export default class VehicleRepository {
  vehicles: vehicle[] = [
    {
      numPlate: "1AAA222",
      numVehicle: 1,
    },
    {
      numPlate: "1ZZZ333",
      numVehicle: 2,
    },
  ];

  getAllVehicles(){
    return this.vehicles;
  }

  addVehicle(numPlate:string,numVehicle:number){
    let newVehicle = {numPlate, numVehicle};
    this.vehicles.push(newVehicle);
  }
}
