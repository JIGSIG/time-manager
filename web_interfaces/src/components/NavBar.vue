<template>
  <v-app-bar
      color="transparent"
      flat
      clipped-left
      style="max-height: 10vh"
  >

    <v-spacer></v-spacer>

    <v-menu
        left
        bottom
        transition="slide-y-transition"
    >
      <template v-slot:activator="{ on }">
        <v-btn
            icon
            x-large
            v-on="on"
        >
          <v-avatar
              color="transparent"
              size="45"
          >
            <v-icon color="black">mdi-account-circle</v-icon>
          </v-avatar>
        </v-btn>
      </template>

      <v-card>
        <v-list-item-content class="justify-center">
          <div class="mx-auto text-center">
            <v-avatar
                color="white"
            >
              <v-icon color="black">mdi-account</v-icon>
            </v-avatar>
            <h3>{{connectedUser.username}}</h3>
            <p class="text-caption mt-1">
              {{connectedUser.email}}
            </p>
            <v-divider class="my-3"></v-divider>
            <v-btn
                depressed
                rounded
                text
                to="/profile"
            >
              Profile
            </v-btn>
            <v-divider class="my-3"></v-divider>
            <v-btn
                depressed
                rounded
                text
                @click="disconnect"
            >
              Disconnect
            </v-btn>
          </div>
        </v-list-item-content>
      </v-card>
    </v-menu>
  </v-app-bar>

</template>

<script>
import {mapGetters} from "vuex";

export default {
  name: 'NavBar',

  computed: {
    ...mapGetters('userModule', {
      connectedUser: 'connectedUser',
      currentToken: 'currentToken',
    }),
  },

  methods: {
    disconnect: function () {
      localStorage.removeItem('user-token');
      this.$router.push({path: '/signin'})
    }
  },

  data: () => ({
  }),

}

</script>