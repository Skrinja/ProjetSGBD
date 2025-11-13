import Department from "src/shared/department";
import { ref } from "vue";

const departments = ref<Department[]>([]);

export default function useDepartmentService() {
    const getAllDepartments = async () => {
        departments.value = await (window as any).electronService.department.getAllDepartments();
    };

    return {
        departments,
        getAllDepartments,
    }
}