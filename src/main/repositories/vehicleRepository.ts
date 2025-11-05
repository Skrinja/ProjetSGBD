import Vehicle from "../../shared/vehicle";
import { PrismaClient, vehicles } from "./prisma/generated/client";
import { PrismaMariaDb } from "@prisma/adapter-mariadb";

export default class VehicleRepository {
    private dbclient: PrismaClient;
  constructor() {
    let adapter = new PrismaMariaDb(process.env.DATABASE_URL);
    this.dbclient = new PrismaClient({ adapter });
  }

  async getAllVehicles(): Promise<Vehicle[]>{
    this.dbclient.vehicles.findFirst().then(x => console.log(x));
    let vehicles = await this.dbclient.vehicles.findMany();
    
    return vehicles.map((v) => {
      return { // MAPPAGE
          vin: v.vin, 
          numPlate: v.license_plate,       
          numVehicle: v.vehicle_number,    
          brand: v.brand,                  
          model: v.model,                  
          year: v.manufacture_date,        
          fuel: v.fuel_type as any,
          licenseType: v.license_type as any,
          configuration: v.vehicle_configuration as any,
          technicalInspectionDate: v.technical_inspection_expiry_date,
          tireSize: v.tire_size,
          innsuranceNumber: v.insurance_number,
          omnium: v.omnium,
          maintenanceContract: v.maintenance_contract,
          maintenanceContractEndDate: v.maintenance_contract_end_date,
          maintenanceContractEndKm: v.maintenance_contract_end_km,
          maintenanceContractNumber: v.maintenance_contract_number,
          decommissioned: v.decommissioned_vehicle,
          otherInformation: v.other_info,
          departmentId: v.department_id,
      }; // si je rajoute as vehicles; il faut que ca corresponde a 100% ? 
    })
  }

  addVehicle(vehicle: Vehicle): void{
    // this.vehicless.push(vehicle);
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
        fuel: vehicleFromDb.fuel_type as any,
        licenseType: vehicleFromDb.license_type as any,
        configuration: vehicleFromDb.vehicle_configuration as any,
        technicalInspectionDate: vehicleFromDb.technical_inspection_expiry_date,
        tireSize: vehicleFromDb.tire_size,
        innsuranceNumber: vehicleFromDb.insurance_number,
        omnium: vehicleFromDb.omnium,
        maintenanceContract: vehicleFromDb.maintenance_contract,
        maintenanceContractEndDate: vehicleFromDb.maintenance_contract_end_date,
        maintenanceContractEndKm: vehicleFromDb.maintenance_contract_end_km,
        maintenanceContractNumber: vehicleFromDb.maintenance_contract_number,
        decommissioned: vehicleFromDb.decommissioned_vehicle,
        otherInformation: vehicleFromDb.other_info,
        departmentId: vehicleFromDb.department_id,
        // ...
      };
  }
}