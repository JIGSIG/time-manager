<template>
  <v-app>
    <NavBar v-if="['Login', 'Register'].indexOf($route.name) === -1"/>
    <SideBar v-if="['Login', 'Register'].indexOf($route.name) === -1"/>
    <v-main>
      <v-container fluid>

<!--        <v-layout row wrap justify-space-around>
          <v-card>
            <router-view class="view one" name="a"></router-view>
          </v-card>
          <v-col>
            <v-card>
              <router-view class="view two" name="b"></router-view>
            </v-card>
            <v-row style="height: 5vh"></v-row>
            <v-card>
              <router-view class="view three" name="d"></router-view>
            </v-card>
          </v-col>
        </v-layout>-->

        <router-view></router-view>

      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import NavBar from './components/NavBar'
export default {
  watch: {
  },
  components: {
    NavBar,
    SideBar: () => import('./components/SideBar'),
  },
  data: () => ({
  }),
}
</script>