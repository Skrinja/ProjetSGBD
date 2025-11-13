import { createRouter, createMemoryHistory } from "vue-router";

import Home from "./pages/Home.vue";
import VehicleDetails from "./pages/VehicleDetails.vue";
import AllVehicles from "./pages/AllVehicles.vue";
import AddVehicleForm from "./pages/AddVehicleForm.vue";

const routes = [
    {path: '/', component: Home},
    {path: '/vehicles', component: AllVehicles},
    {path: '/vehicle/:id', component: VehicleDetails},
    {path: '/vehicle/add', component: AddVehicleForm},
    {path: '/vehicle/edit/:id', component: AddVehicleForm},
]

export const router = createRouter({routes, history: createMemoryHistory()});