import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)

app.config.globalProperties.url = 'http://' + document.location.hostname +':7000'

app.use(router)

app.mount('#app')
