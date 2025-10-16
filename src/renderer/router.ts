import { createRouter, createMemoryHistory } from "vue-router";

import Home from "./pages/Home.vue";
import Vehicles from "./pages/Vehicles.vue";
import VehicleDetails from "./pages/VehicleDetails.vue";

const routes = [
    {path: '/', component: Home},
    {path: '/vehicles', component: Vehicles},
    {path: '/vehicle/:vin', component: VehicleDetails}
]

export const router = createRouter({routes, history: createMemoryHistory()});