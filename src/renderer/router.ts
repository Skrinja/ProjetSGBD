import { createRouter, createMemoryHistory } from "vue-router";

import Home from "./pages/Home.vue";
import Vehicles from "./pages/Vehicles.vue";

const routes = [
    {path: '/', component: Home},
    {path: '/vehicles', component: Vehicles}
]

export const router = createRouter({routes, history: createMemoryHistory()});