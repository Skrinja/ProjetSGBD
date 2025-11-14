import { createRouter, createMemoryHistory } from "vue-router";

import Home from "./pages/Home.vue";
import VehicleDetails from "./pages/VehicleDetails.vue";
import AllVehicles from "./pages/AllVehicles.vue";
import AddVehicleForm from "./pages/AddVehicleForm.vue";
import AllDepartments from "./pages/AllDepartments.vue";

const routes = [
    {path: '/', component: Home},
    {path: '/vehicles', component: AllVehicles},
    {path: '/vehicle/:id', component: VehicleDetails},
    {path: '/vehicle/add', component: AddVehicleForm},
    {path: '/vehicle/edit/:id', component: AddVehicleForm},
    {path: '/departments', component: AllDepartments},
]

export const router = createRouter({routes, history: createMemoryHistory()});