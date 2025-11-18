<template>
    <nav class="sidebar">
        <div class="sidebar-header">
            <h3>LOG/V</h3>
        </div>
        <ul class="nav-list">
            <li><router-link to="/">Accueil</router-link></li>
            <li><router-link to="/vehicles">Véhicules</router-link></li>
            <li><router-link to="/departments">Services</router-link></li>
        </ul>
    </nav>
</template>

<style scoped>
.sidebar {
  width: 240px;
  flex-shrink: 0; /* Empêche le menu de rétrécir */
  background-color: #1e293b; /* Un bleu/gris foncé */
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.sidebar-header {
  padding: 1.5rem;
  text-align: center;
  border-bottom: 1px solid #334155;
}

.sidebar-header h3 {
  margin: 0;
  font-size: 1.25rem;
  color: #e2e8f0;
}

.nav-list {
  list-style-type: none;
  padding: 0;
  margin: 0;
  flex-grow: 1;
}

.nav-list li {
  margin: 0.5rem 0;
}

.nav-list a {
  display: block;
  padding: 0.75rem 1.5rem;
  text-decoration: none;
  color: #e2e8f0;
  font-weight: 500;
  border-left: 4px solid transparent;
  transition: all 0.2s ease;
}

.nav-list a:hover {
  background-color: #334155;
}

/* Style pour le lien de la page active */
.nav-list a.router-link-active {
  color: #ffffff;
  background-color: #2563eb; /* Un bleu vif */
  border-left-color: #60a5fa; /* Bordure bleue claire */
}
</style>