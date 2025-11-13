import Department from "../department";

export default interface IDepartmentService {
    getAllDepartments: () => Promise<Department[]>;
}