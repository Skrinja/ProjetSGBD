import Department from "src/shared/department";
import { PrismaClient } from "./prisma/generated/client";
import { PrismaMariaDb } from "@prisma/adapter-mariadb";

export default class DepartmentRepository {
    private dbclient: PrismaClient;
    constructor(){
        let adapter = new PrismaMariaDb(process.env.DATABASE_URL);
        this.dbclient = new PrismaClient({adapter});
    }

    async getAllDepartments() : Promise<Department[]> {
        const departmentsFromDb = await this.dbclient.departments.findMany();

        return departmentsFromDb.map((d) => {
            return {
                id: d.department_id,
                name: d.department_name,
                serviceAddressId: d.service_address_id,
            };
        });
    }
}