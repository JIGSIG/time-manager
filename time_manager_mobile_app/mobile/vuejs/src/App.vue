<template>
  <div id="app"></div>
</template>
<template>
  <v-app id="app">
    <v-main>
      <router-view></router-view>
      <div class="text-center ma-2">
        <v-btn
            white
            @click="snackbar = true"
            elevation="1"
        >
          Open Snackbar
        </v-btn>
        <v-snackbar
            v-model="snackbar"
            :timeout="15000"
        >
          {{ text }}

          <template v-slot:action="{ attrs }">
            <v-btn
                color="pink"
                text
                v-bind="attrs"
                @click="snackbar = false"
            >
              Close
            </v-btn>
          </template>
        </v-snackbar>
      </div>
    </v-main>
  </v-app>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
  }),
  props: {
    source: String,
  },
};
</script>

<script>
import {mapGetters} from "vuex";

export default {
  name: 'App',

  computed: {
    ...mapGetters('userModule', {
      userError: 'error'
    })
  },

  watch: {
    userError: function () {
      this.snackbar = this.userError.status
      this.text = this.userError.message
    }
  },

  data() {
    return {
      drawer: false,
      snackbar: false,
      text: `Hello, I'm a snackbar`,
    };
  },

};
</script>

<style></style>
