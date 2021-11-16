<template>
  <v-container>
    <v-dialog
        v-model="dialog"
        persistent
        max-width="600px"
    >
      <v-card>
        <v-card-title>
          <span class="text-h5">User Profile</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                    label="Username *"
                    required
                ></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-text-field
                    label="Email *"
                    required
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
              color="blue darken-1"
              text
              @click="dialog = false"
          >
            Save
          </v-btn>
          <v-btn
              color="red darken-1"
              text
              @click="dialog = false"
          >
            Close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-card class="mt-4 text-center">

<!--      <v-img
          class="rounded-circle elevation-6 d-inline-block mt-5"
          src="https://demos.creative-tim.com/vue-material-dashboard/img/marc.aba54d65.jpg"
          width="120"
      />-->

      <v-avatar size="80" color="indigo" class="elevation-6 d-inline-block mt-5">
        <v-icon size="50" dark>
          mdi-account
        </v-icon>
      </v-avatar>

      <v-card-text class="text-center">
        <h6 class="text-h6 mb-2 text--secondary text-uppercase">
          {{connectedUser.role}}
        </h6>

        <h4 class="text-h4 mb-3 text--primary">
          {{connectedUser.username}}
        </h4>

        <p class="text-h6 text--secondary font-weight-medium">
          {{connectedUser.email}}
        </p>

        <v-btn
            class="mr-0"
            color="primary"
            min-width="100"
            rounded
            @click="display"
        >
          Update
        </v-btn>
        <v-btn
            class="ml-5"
            color="error"
            min-width="100"
            rounded
        >
          Delete <br/> account
        </v-btn>
      </v-card-text>
    </v-card>

  </v-container>
</template>



<script>
import {mapGetters} from "vuex";
export default {
  name: "Profile",

  components: {

  },

  data: () => ({
    dialog: false
  }),

  methods: {
    display() {
      this.dialog = true
      console.log(this.connectedUser)
    }
  },

  computed: {
    ...mapGetters('userModule', {
      connectedUser: 'connectedUser',
    }),
  }

};
</script>