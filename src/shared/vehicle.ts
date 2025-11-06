import * as vehicleEnum from "./enums/vehicleEnum";

export default interface Vehicle {
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
    innsuranceNumber?: string;
    omnium?: boolean;
    maintenanceContract?: boolean;
    maintenanceContractEndDate?: Date;
    maintenanceContractEndKm?: number;
    maintenanceContractNumber?: string;
    decommissioned?: boolean;
    otherInformation?: string;
    departmentId: number;
    documents?: string[];
}