<template>
    <v-layout column>
      <v-toolbar
          flat
          color="white"
      >
        <v-toolbar-title style="color: black"><strong>Employees</strong></v-toolbar-title>
        <v-spacer></v-spacer>
        <v-toolbar-title class="mr-7">
          <v-text-field
              v-model="search"
              prepend-icon="mdi-magnify"
              label="Search"
              single-line
              hide-details
              color="black"
          ></v-text-field>
        </v-toolbar-title>
        <v-dialog
            v-model="dialog"
            max-width="500px"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-btn
                color="primary"
                dark
                class="mb-2"
                v-bind="attrs"
                v-on="on"
            >
              Add User
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="text-h5">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col
                      cols="12"
                  >
                    <v-text-field
                        v-model="editedItem.username"
                        label="Username"
                    ></v-text-field>
                  </v-col>
                  <v-col
                      cols="12"
                  >
                    <v-text-field
                        v-model="editedItem.email"
                        label="Email"
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
                  @click="close"
              >
                Cancel
              </v-btn>
              <v-btn
                  color="blue darken-1"
                  text
                  @click="save"
              >
                Save
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <v-dialog v-model="dialogDelete" max-width="500px">
          <v-card>
            <v-card-title class="text-h5">Are you sure you want to delete this user ?</v-card-title>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="closeDelete">Cancel</v-btn>
              <v-btn color="blue darken-1" text @click="deleteItemConfirm">OK</v-btn>
              <v-spacer></v-spacer>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
      <v-flex md12 style="overflow: auto">
        <v-data-table
            :headers="headers"
            :items="users"
            sort-by="id"
            :search="search"
            :disable-pagination="true"
            :hide-default-footer="true"
            :calculate-widths="true"
            v-model="selectedRows"

        >
          <template v-slot:item.actions="{ item }">
            <v-icon
                small
                class="mr-2"
                @click="editItem(item)"
            >
              mdi-pencil
            </v-icon>
            <v-icon
                small
                @click="deleteItem(item)"
            >
              mdi-delete
            </v-icon>
          </template>


        </v-data-table>
      </v-flex>
    </v-layout>
</template>

<script>
  import { mapGetters } from 'vuex'
  export default {
    name: 'User',

    data: () => ({
      selectedRows: [],
      search: '',
      dialog: false,
      dialogDelete: false,
      headers: [
        { text: 'Username', value: 'username', width: "1%", sortable: false},
        { text: 'Email', value: 'email', sortable: false },
        { text: 'Actions', value: 'actions', width: "1%", sortable: false },
      ],
      editedIndex: -1,
      editedItem: {
        id: 0,
        username: '',
        email: '',
      },
      defaultItem: {
        id: 0,
        username: '',
        email: '',
      },
    }),

    computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'New Employees' : 'Edit Employee'
      },
      ...mapGetters('userModule', {
        users: 'userList',
        token: 'currentToken'
      })
    },

    watch: {
      dialog (val) {
        val || this.close()
      },
      dialogDelete (val) {
        val || this.closeDelete()
      },
    },

    created () {
      this.$store.dispatch('userModule/getAllUsers')
      console.log(this.users)
    },

    methods: {

      editItem (item) {
        this.editedIndex = this.users.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialog = true
      },

      deleteItem (item) {
        this.editedIndex = this.users.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialogDelete = true
      },

      close () {
        this.dialog = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        })
      },

      closeDelete () {
        this.dialogDelete = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        })
      },

      deleteItemConfirm () {
        this.$store.dispatch("userModule/deleteUserById", this.editedItem)
        this.closeDelete()
      },

      save () {
        if (this.editedIndex > -1) {
          this.$store.dispatch('userModule/updateUserById', this.editedItem)

        } else {
          this.$store.dispatch('userModule/createUser', this.editedItem)
        }
        this.close()
      },
    },

  }
</script>
