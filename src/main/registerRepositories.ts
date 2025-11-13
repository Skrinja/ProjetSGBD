import { registerDepartmentHandlers } from "./repositories/departmentRepositoryService";
import { registerVehicleHandlers } from "./repositories/vehicleRepositoryService";

export default function registerRepositories(){
    registerVehicleHandlers();
    registerDepartmentHandlers();
}