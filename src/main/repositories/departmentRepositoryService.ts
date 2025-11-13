import { ipcMain } from "electron";
import DepartmentRepository from "./departmentRepository";

export function registerDepartmentHandlers() {
    const departmentRepository = new DepartmentRepository();

    ipcMain.handle("departmentRepo:getAll", () => {
        return departmentRepository.getAllDepartments();
    })
}