import Vehicle from "../../shared/vehicle";
import { PrismaClient, vehicles } from "./prisma/generated/client";
import { PrismaMariaDb } from "@prisma/adapter-mariadb";

export default class VehicleRepository {
  private dbclient: PrismaClient;
  constructor() {
    let adapter = new PrismaMariaDb(process.env.DATABASE_URL);
    this.dbclient = new PrismaClient({ adapter });
  }

  async getAllVehicles(): Promise<Vehicle[]> {
    this.dbclient.vehicles.findFirst().then((x) => console.log(x));
    let vehicles = await this.dbclient.vehicles.findMany({
      include: {
        departments: true,
      }
    });

    return vehicles.map((v) => {
      return {
        // MAPPAGE
        id: v.id,
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
        departmentId: v.department_id,
        departmentName: v.departments.department_name,
      }; // si je rajoute as vehicles il faut que ca corresponde a 100% ?
    });
  }

  async addVehicle(vehicle: Vehicle): Promise<void> {
    await this.dbclient.vehicles.create({
      data: {
        vin: vehicle.vin,
        license_plate: vehicle.numPlate,
        vehicle_number: vehicle.numVehicle,
        brand: vehicle.brand,
        model: vehicle.model,
        manufacture_date: vehicle.year,
        fuel_type: vehicle.fuel,
        license_type: vehicle.licenseType,
        vehicle_configuration:
          vehicle.configuration === "Banalisé"
            ? "Banalis_"
            : (vehicle.configuration as any), // A revoiur
        technical_inspection_expiry_date: vehicle.technicalInspectionDate,
        department_id: vehicle.departmentId,
        tire_size: vehicle.tireSize,
        insurance_number: vehicle.insuranceNumber,
        omnium: vehicle.omnium,
        maintenance_contract: vehicle.maintenanceContract,
        maintenance_contract_end_date: vehicle.maintenanceContractEndDate,
        maintenance_contract_end_km: vehicle.maintenanceContractEndKm,
        maintenance_contract_number: vehicle.maintenanceContractNumber,
        decommissioned_vehicle: vehicle.decommissioned,
        other_info: vehicle.otherInformation,
        documents: vehicle.documents as any,
      },
    });
  }

  async updateVehicle(vehicle: Vehicle): Promise<void> {
    await this.dbclient.vehicles.update({
      where: {
        id: vehicle.id,
      },
      data: {
        vin: vehicle.vin,
        license_plate: vehicle.numPlate,
        vehicle_number: vehicle.numVehicle,
        brand: vehicle.brand,
        model: vehicle.model,
        manufacture_date: vehicle.year,
        fuel_type: vehicle.fuel,
        license_type: vehicle.licenseType,
        vehicle_configuration:
          vehicle.configuration === "Banalisé"
            ? "Banalis_"
            : (vehicle.configuration as any), // A revoiur
        technical_inspection_expiry_date: vehicle.technicalInspectionDate,
        department_id: vehicle.departmentId,
        tire_size: vehicle.tireSize,
        insurance_number: vehicle.insuranceNumber,
        omnium: vehicle.omnium,
        maintenance_contract: vehicle.maintenanceContract,
        maintenance_contract_end_date: vehicle.maintenanceContractEndDate,
        maintenance_contract_end_km: vehicle.maintenanceContractEndKm,
        maintenance_contract_number: vehicle.maintenanceContractNumber,
        decommissioned_vehicle: vehicle.decommissioned,
        other_info: vehicle.otherInformation,
        documents: vehicle.documents as any,
      },
    });
  }

  async getVehicleById(id: number): Promise<Vehicle> {
    let vehicleFromDb = await this.dbclient.vehicles.findUnique({
      where: {
        id: id,
      },
      include: {
        departments: true,
      }
    });

    return {
      id: vehicleFromDb.id,
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
      insuranceNumber: vehicleFromDb.insurance_number,
      omnium: vehicleFromDb.omnium,
      maintenanceContract: vehicleFromDb.maintenance_contract,
      maintenanceContractEndDate: vehicleFromDb.maintenance_contract_end_date,
      maintenanceContractEndKm: vehicleFromDb.maintenance_contract_end_km,
      maintenanceContractNumber: vehicleFromDb.maintenance_contract_number,
      decommissioned: vehicleFromDb.decommissioned_vehicle,
      otherInformation: vehicleFromDb.other_info,
      departmentId: vehicleFromDb.department_id,
      departmentName: vehicleFromDb.departments.department_name
      // documents à ajouter plus tard quand je saurais le faire
    };
  }

  async deleteVehicle(id: number): Promise<void> {
    await this.dbclient.vehicles.delete({
      where: {
        id: id,
      },
    });
  }
}
