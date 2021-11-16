<template>
  <v-navigation-drawer
      permanent
      app
      clipped
      dark
      color="black"
  >

    <v-list-item>
      <v-list-item-content class="pl-2">
        <v-list-item-title class="text-h5">
          <span class="mr-1 white--text">TIME MANAGER</span>
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>

    <v-divider class="mx-3 mb-2" style="height: 0; border-color: rgba(255, 255, 255, 0.30)"/>

    <v-list
        v-for="(item, i) in items"
        :key="`item-${i}`"
        expand
        nav
    >
      <v-list-item
          :to="item.to"
          active-class="deep-purple"
          link
          class="py-1"
      >

        <v-list-item-icon
            v-if="item.icon"
            class="my-2 align-self-center"
        >
          <v-icon v-text="item.icon" />
        </v-list-item-icon>

        <v-list-item-content v-if="item.title">
          <v-list-item-title v-text="item.title" />
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import {mapGetters} from "vuex";
export default {
  name: 'SideBar',
  components: {},

  computed: {
    ...mapGetters('userModule', {
      connectedUser: 'connectedUser',
      currentToken: 'currentToken',
    }),
  },

  data: () => ({
    items: [
      {
        title: 'Dashboard',
        icon: 'mdi-view-dashboard',
        to: '/',
      },
      {
        title: 'Users Manager',
        icon: 'mdi-account-group',
        to: '/users',
      },
      {
        title: 'Working Times',
        icon: 'mdi-timetable',
        to: '/workingTimes/' + JSON.parse(localStorage.getItem('user')).id,
      },

/*      {
        title: 'User Profile',
        icon: 'mdi-account',
        to: '/components/profile/',
      },
      {
        title: 'Regular Tables',
        icon: 'mdi-clipboard-outline',
        to: '/tables/regular/',
      },
      {
        title: 'Typography',
        icon: 'mdi-format-font',
        to: '/components/typography/',
      },
      {
        title: 'Icons',
        icon: 'mdi-chart-bubble',
        to: '/components/icons/',
      },
      {
        title: 'Google Maps',
        icon: 'mdi-map-marker',
        to: '/maps/google/',
      },
      {
        title: 'Notifications',
        icon: 'mdi-bell',
        to: '/components/notifications/',
      },*/
    ],
  }),

  methods: {
    test () {

    },
  }
}

</script>