<template>
  <div class="app-container">
    <SideBarNavigation />
    <main class="main-content">
      <RouterView />
    </main>
  </div>
</template>

<script setup lang="ts">
import SideBarNavigation from './renderer/components/SideBarNavigation.vue';
</script>

<style>
/* Styles globaux */
html, body {
  height: 100%;
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  overflow: hidden; /* Empêche le défilement sur le body */
  background-color: #f1f5f9; /* Fond général gris clair */
  color: #1e293b; /* Couleur de texte par défaut */
}

#app {
  height: 100%;
}

.app-container {
  display: flex;
  height: 100vh;
}

.main-content {
  flex-grow: 1;
  padding: 2rem; /* Augmentation du padding */
  overflow-y: auto;
  height: 100vh;
  box-sizing: border-box;
  background-color: #f1f5f9; /* Fond gris clair */
}

/* Styles de base pour les éléments communs */
h1, h2, h3 {
  color: #0f172a; /* Titres en bleu/gris très foncé */
  margin-top: 0;
}

h1 {
  font-size: 1.8rem;
  margin-bottom: 1.5rem;
}

h2 {
  font-size: 1.5rem;
  margin-bottom: 1.25rem;
  border-bottom: 1px solid #cbd5e1;
  padding-bottom: 0.5rem;
}

button {
  cursor: pointer;
  padding: 0.65rem 1.25rem;
  border: none;
  border-radius: 6px;
  background-color: #2563eb; /* Bleu vif */
  color: white;
  font-size: 0.95rem;
  font-weight: 500;
  transition: background-color 0.2s ease;
  margin: 0.25rem;
}

button:hover {
  background-color: #1d4ed8; /* Bleu plus foncé au survol */
}

/* Bouton "danger" (suppression) */
button.danger {
  background-color: #dc2626; /* Rouge */
}
button.danger:hover {
  background-color: #b91c1c; /* Rouge foncé */
}

/* Bouton "secondaire" (édition) */
button.secondary {
  background-color: #475569; /* Gris */
}
button.secondary:hover {
  background-color: #334155; /* Gris foncé */
}


a {
  color: #2563eb;
  text-decoration: none;
}
a:hover {
  text-decoration: underline;
}

/* Liens de type bouton */
a.button-link {
  display: inline-block;
  padding: 0.65rem 1.25rem;
  border-radius: 6px;
  background-color: #2563eb;
  color: white;
  font-size: 0.95rem;
  font-weight: 500;
  text-decoration: none;
  transition: background-color 0.2s ease;
  margin: 0.25rem;
}
a.button-link:hover {
  background-color: #1d4ed8;
  text-decoration: none;
}
</style>