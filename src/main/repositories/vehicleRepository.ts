import { FuelType } from "../../shared/enums/fuelType"; 
import Vehicle from "../../shared/vehicle";
import { PrismaClient, vehicles } from "./prisma/generated/client";
import { PrismaMariaDb } from "@prisma/adapter-mariadb";

export default class VehicleRepository {
    private dbclient: PrismaClient;
  constructor() {
    let adapter = new PrismaMariaDb(process.env.DATABASE_URL);
    this.dbclient = new PrismaClient({ adapter });
  }

  vehicless: Vehicle[] = [
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

  async getAllVehicles(): Promise<Vehicle[]>{
    this.dbclient.vehicles.findFirst().then(x => console.log(x));
    let vehicles = await this.dbclient.vehicles.findMany();
    
    return vehicles.map((v) => {
      return {
          vin: v.vin, // MAPPAGE
          numPlate: v.license_plate,       
          numVehicle: v.vehicle_number,    
          brand: v.brand,                  
          model: v.model,                  
          year: v.manufacture_date,        
          fuel: v.fuel_type as FuelType,
      }; // si je rajoute as vehicles; il faut que ca corresponde a 100% ? 
    })
  }

  addVehicle(vehicle: Vehicle): void{
    this.vehicless.push(vehicle);
  }

async getVehicleByVin(vin:string): Promise<Vehicle>{
    let vehicleFromDb = await this.dbclient.vehicles.findUnique({
      where: {
        vin: vin,
      }
    });

    return {
        vin: vehicleFromDb.vin,
        numPlate: vehicleFromDb.license_plate,
        numVehicle: vehicleFromDb.vehicle_number,
        brand: vehicleFromDb.brand,
        model: vehicleFromDb.model,
        year: vehicleFromDb.manufacture_date,
        fuel: vehicleFromDb.fuel_type as FuelType,
        // ...
      };
  }
}