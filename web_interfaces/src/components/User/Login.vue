<template>
        <v-row align="center" justify="center" class="ma-6">
          <v-snackbar
              v-model="errorStatus"
              right
              centered
              top
              :timeout="2000"
              color="error"
          >
            {{ errorMessage.message }}

            <template v-slot:action="{ attrs }">
              <v-btn
                  color="blue"
                  text
                  v-bind="attrs"
                  @click="snackbar = false"
              >
                Close
              </v-btn>
            </template>
          </v-snackbar>
          <v-col cols="12" md="8">
            <v-card class="elevation-12" height="90vh">

                  <v-row class="fill-height ma-0">
                    <v-col cols="12" md="4" class="fill-height black accent-3 pa-0">
                      <v-img :src="require('../../assets/background-img.jpg')" class="fill-height"></v-img>
                    </v-col>
                    <v-col cols="12" md="8" class="fill-height pa-0">
                      <v-card-text class="align-content-center fill-height">
                        <validation-observer
                            ref="observer"
                            v-slot="{ invalid }"
                        >
                          <form class="fill-height" style="padding-top: 20%" >
                            <validation-provider
                                v-slot="{ errors }"
                                name="email"
                                rules="required|email"
                            >
                              <v-text-field
                                  v-model="data.email"
                                  :error-messages="errors"
                                  label="E-MAIL"
                                  name="Email"
                                  prepend-icon="mdi-email"
                                  type="text"
                                  color="black"
                                  style="max-width: 73%; margin-left: 12%"
                              />
                            </validation-provider>

                            <validation-provider
                                v-slot="{ errors }"
                                name="password"
                                :rules="{required: true, min: 5}"
                            >
                              <v-text-field
                                  v-model="data.password"
                                  :error-messages="errors"
                                  id="password"
                                  label="PASSWORD"
                                  name="password"
                                  prepend-icon="mdi-lock"
                                  type="password"
                                  color="black"
                                  style="max-width: 73%; margin-left: 12%"
                                  required
                              />

                            </validation-provider>

                          <div class="text-center mr-5 mt-10">
                            <v-btn  :disabled=invalid @click="signin" color="black accent-3 white--text" >SIGN IN</v-btn>
                          </div>

                          <div class="text-center mr-5 mt-10">
                            <h3>Dont have an account ?</h3>
                            <v-btn plain dark color="black" class="mt-4" to="/signup">SIGN UP</v-btn>
                          </div>

                        </form>
                        </validation-observer>
                      </v-card-text>
                    </v-col>
                  </v-row>
            </v-card>
          </v-col>
        </v-row>
</template>



<script>
import { email } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
import { mapGetters } from 'vuex'

setInteractionMode('eager')

extend('email', {
  ...email,
  message: 'Email must be valid',
})

export default {
  name: "Login",

  components: {
    ValidationObserver,
    ValidationProvider
  },

  data: () => ({
    value: '',
    snackbar: true,
    data: {
      email: '',
      password: '',
    },
  }),
  methods: {
    signin() {
      this.$store.dispatch('userModule/loginUser', {email: this.data.email, password_hash: this.data.password})
    },
  },
  computed: {
    ...mapGetters('userModule', {
      errorStatus: 'errorStatus',
      errorMessage: 'errorMessage'
    }),
  },
};
</script>