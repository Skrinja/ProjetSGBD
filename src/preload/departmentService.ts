import { ipcRenderer } from "electron";
import Department from "src/shared/department";
import IDepartmentService from "src/shared/interfaces/IDepartmentService";

export function departmentService(): IDepartmentService {
    return {
        getAllDepartments: () => ipcRenderer.invoke('departmentRepo:getAll'),
    }
}