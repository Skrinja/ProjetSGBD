import * as vehicleEnum from "./enums/vehicleEnum";

export default interface Vehicle {
    id: number;
    vin: string;
    numPlate: string;
    numVehicle: number;
    brand: string;
    model: string;
    year: Date;
    fuel: vehicleEnum.FuelType;
    licenseType: vehicleEnum.LicenseType;
    configuration : vehicleEnum.VehicleConfiguration;
    technicalInspectionDate: Date;
    tireSize?: string;
    insuranceNumber?: string;
    omnium?: boolean;
    maintenanceContract?: boolean;
    maintenanceContractEndDate?: Date;
    maintenanceContractEndKm?: number;
    maintenanceContractNumber?: string;
    decommissioned?: boolean;
    otherInformation?: string;
    departmentId: number;
    departmentName: string,
    documents?: string[];
}