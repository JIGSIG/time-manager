<template>
  <v-app id="inspire">
    <v-main>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Login form</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field
                      v-model="email"
                      prepend-icon="person"
                      name="login"
                      label="Login"
                      type="text"
                  ></v-text-field>
                  <v-text-field
                      v-model="password"
                      id="password"
                      prepend-icon="lock"
                      name="password"
                      label="Password"
                      type="password"
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" @click="login">Login</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: 'Login',
  props: {
    source: String,
  },

  data: () => ({
    email: '',
    password: '',
  }),

  computed: {
  },

  methods: {
    login() {
      let payload = {"email": this.email, "password_hash": this.password};
      this.$store.dispatch('userModule/login', payload)
    }
  }
};
</script>

<style></style>
