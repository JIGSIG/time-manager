<template>
  <div id="app">
    <v-app>
      <AppBar></AppBar>
      <v-main class="height: 90vh, black">
        <div v-if="this.user.role === 'user'">
          <User_home></User_home>
        </div>
        <div v-else-if="this.user.role === 'manager'">
          <Manager_home></Manager_home>
        </div>
        <div v-else-if="this.user.role === 'admin'">
          <Admin_home></Admin_home>
        </div>
        <div v-else>
          Ni A, ni B et ni C
        </div>
      </v-main>
    </v-app>
  </div>
</template>

<script>
import {mapGetters} from "vuex";
import User_home from "./Home/user_home";
import Manager_home from "./Home/manager_home";
import Admin_home from "./Home/admin_home";
import AppBar from "./AppBar";

export default {
  name: 'Home',

  components: {Admin_home, Manager_home, User_home, AppBar},
  computed: {
    ...mapGetters('userModule', {
      user: 'user'
    }),
  },
}
</script>