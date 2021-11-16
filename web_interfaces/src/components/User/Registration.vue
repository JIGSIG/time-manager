<template>
  <v-row align="center" justify="center" class="ma-6">
    <v-snackbar
        v-model="snackbarError"
        right
        centered
        top
        :timeout="2000"
        color="error"
    >
      An error occured

    </v-snackbar>
    <v-col cols="12" md="8">
      <v-card class="elevation-12" height="90vh">
        <v-row class="fill-height ma-0">
          <v-col cols="12" md="4" class="fill-height black accent-3 pa-0">
            <v-img :src="require('../../assets/background-img.jpg')" class="fill-height"></v-img>
          </v-col>
          <v-col cols="12" md="8" class="fill-height pa-0 grey lighten-5">
            <v-card-text class="align-content-center fill-height">
              <validation-observer
                  ref="observer"
                  v-slot="{ invalid }"
              >
                <form @submit.prevent="submit" class="fill-height pt-16">

                  <validation-provider
                      v-slot="{ errors }"
                      name="username"
                      rules="required"
                  >
                    <v-text-field
                        v-model="data.username"
                        :error-messages="errors"
                        label="USERNAME"
                        name="Username"
                        prepend-icon="mdi-account"
                        type="text"
                        color="black"
                        style="max-width: 73%; margin-left: 12%"
                    />
                  </validation-provider>

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

                  <validation-provider
                      v-slot="{ errors }"
                      name="second-password"
                      :rules="{required: true, is: data.password}"
                  >
                    <v-text-field
                        v-model="data.secondPassword"
                        :error-messages="errors"
                        id="second-password"
                        label="REPEAT PASSWORD"
                        name="second-password"
                        prepend-icon="mdi-lock"
                        type="password"
                        color="black"
                        style="max-width: 73%; margin-left: 12%"
                        required
                    />

                  </validation-provider>

                  <div class="text-center mr-5 mt-10">
                    <v-btn  depressed :disabled=invalid @click="signup" color="black" class="white--text">SIGN UP</v-btn>
                  </div>

                  <div class="text-center mr-5 mt-10">
                    <h3>Already have an account ?</h3>
                    <v-btn plain dark color="black" class="mt-4" to="/signin">SIGN IN</v-btn>
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

import { required, email, min, is } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'

setInteractionMode('eager')

extend('is', {
  ...is,
  message: '{_field_} needs to match with password',
})

extend('required', {
  ...required,
  message: '{_field_} can not be empty',
})

extend('min', {
  ...min,
  message: '{_field_} may be greater than {length} characters',
})


extend('email', {
  ...email,
  message: 'Email must be valid',
})

export default {
  name: "Registration",

  components: {
    ValidationProvider,
    ValidationObserver
  },

  data: () => ({
    step: 1,
    snackbarError: false,
    data: {
      username: '',
      email: '',
      password: '',
      secondPassword: '',
    },
    valid: false,
  }),
  props: {
    source: String
  },
  methods: {
    signup() {
      this.$store.dispatch('userModule/registerUser', {username: this.data.username, email: this.data.email, password_hash: this.data.password})
          .then(
              this.data.email = '',
              this.data.username = '',
              this.data.password = '',
              this.data.secondPassword = '',
              this.$refs.observer.reset()
          )
          .catch(
              this.snackbarError = true
          )
    }
  }
};
</script>