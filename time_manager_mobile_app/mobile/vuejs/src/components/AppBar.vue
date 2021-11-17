<template>
  <v-app>
    <v-navigation-drawer height="10vh" width="100vh" color="black" style="width: 100%" permanent>
    <v-container class="fill-height">
      <v-app-bar-nav-icon class="blue" @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    </v-container>
  </v-navigation-drawer>
  <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
  >
    <v-system-bar></v-system-bar>
    <v-list>
      <v-list-item>
        <v-list-item-avatar>
          <v-img src="https://cdn.vuetifyjs.com/images/john.png"></v-img>
        </v-list-item-avatar>
      </v-list-item>

      <v-list-item link>
        <v-list-item-content>
          <v-list-item-title class="text-h6">
            John Leider
          </v-list-item-title>
          <v-list-item-subtitle>john@vuetifyjs.com</v-list-item-subtitle>
        </v-list-item-content>

        <v-list-item-action>
          <v-icon>mdi-menu-down</v-icon>
        </v-list-item-action>
      </v-list-item>
    </v-list>
    <v-divider></v-divider>
    <v-list
        nav
        dense
    >
      <v-list-item-group
          v-model="selectedItem"
          color="primary"
      >
        <v-list-item
            v-for="(item, i) in items"
            :key="i"
            @click="drawerActions(item.action)"
        >
          <v-list-item-icon>
            <v-icon v-text="item.icon"></v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title v-text="item.text"></v-list-item-title>
          </v-list-item-content>
        </v-list-item>

      </v-list-item-group>
      <v-spacer></v-spacer>
      <v-divider></v-divider>
      <v-spacer></v-spacer>
      <v-list-item :key="items.length" @click="disconnect">
        <v-list-item-icon>
          <v-icon v-text="'mdi-cloud-upload'"></v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title v-text="'Logout'"></v-list-item-title>
        </v-list-item-content>
      </v-list-item>

    </v-list>
  </v-navigation-drawer>
  </v-app>
</template>

<script>
import {mapGetters} from "vuex";

export default {
  name: 'AppBar',
  data () {
    return {
      drawer: null,
      selectedItem: 0,
      items: [
        { text: 'My Files', icon: 'mdi-folder', action: this.disconnect },
        { text: 'Shared with me', icon: 'mdi-account-multiple' },
        { text: 'Starred', icon: 'mdi-star' },
        { text: 'Recent', icon: 'mdi-history' },
        { text: 'Offline', icon: 'mdi-check-circle' },
        { text: 'Uploads', icon: 'mdi-upload' },
      ],
    }
  },
  computed: {
    ...mapGetters('userModule', {
      user: 'user'
    }),
  },

  methods: {
    drawerActions(action) {
      if (action !== null && action !== undefined)
        action.call()
    },
    disconnect() {
      this.$store.dispatch('userModule/disconnect')
    }
  }
}
</script>