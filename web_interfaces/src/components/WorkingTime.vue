<template>
  <v-row justify="center">
    <v-dialog
        v-model="dialog"
        persistent
        max-width="600px"

    >
      <v-card>
        <v-card-title>
          <span class="text-h5">{{ formTitle }}</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col
                  cols="11"
                  sm="5"
              >
                <v-menu
                    ref="menu"
                    v-model="menu1"
                    :close-on-content-click="false"
                    :return-value.sync="date.start"
                    transition="scale-transition"
                    offset-y
                    min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                        v-model="date.start"
                        label="Start Date"
                        prepend-icon="mdi-calendar"
                        readonly
                        v-bind="attrs"
                        v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker
                      v-model="date.start"
                      no-title
                      scrollable
                  >
                    <v-spacer></v-spacer>
                    <v-btn
                        text
                        color="primary"
                        @click="menu1 = false"
                    >
                      Cancel
                    </v-btn>
                    <v-btn
                        text
                        color="primary"
                        @click="$refs.menu.save(date.start)"
                    >
                      OK
                    </v-btn>
                  </v-date-picker>
                </v-menu>
              </v-col>
              <v-spacer/>
              <v-col
                  cols="11"
                  sm="5"
              >
                <v-menu
                    ref="menu2"
                    v-model="menu2"
                    :close-on-content-click="false"
                    :return-value.sync="date.end"
                    transition="scale-transition"
                    offset-y
                    min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                        v-model="date.end"
                        label="End Date"
                        prepend-icon="mdi-calendar"
                        readonly
                        v-bind="attrs"
                        v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker
                      v-model="date.end"
                      no-title
                      scrollable
                  >
                    <v-spacer></v-spacer>
                    <v-btn
                        text
                        color="primary"
                        @click="menu2 = false"
                    >
                      Cancel
                    </v-btn>
                    <v-btn
                        text
                        color="primary"
                        @click="$refs.menu2.save(date.end)"
                    >
                      OK
                    </v-btn>
                  </v-date-picker>
                </v-menu>
              </v-col>
            </v-row>

            <v-row>
              <v-col
                  cols="11"
                  sm="5"
              >
                <v-menu
                    ref="menu3"
                    v-model="menu3"
                    :close-on-content-click="false"
                    :nudge-right="40"
                    :return-value.sync="time.start"
                    transition="scale-transition"
                    offset-y
                    max-width="290px"
                    min-width="290px"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                        v-model="time.start"
                        label="Start Time"
                        prepend-icon="mdi-clock-time-four-outline"
                        readonly
                        v-bind="attrs"
                        v-on="on"
                    ></v-text-field>
                  </template>
                  <v-time-picker
                      v-if="menu3"
                      v-model="time.start"
                      full-width
                      :use-seconds="true"
                      @click:second="$refs.menu3.save(time.start)"
                  ></v-time-picker>
                </v-menu>
              </v-col>
              <v-spacer/>
              <v-col
                  cols="11"
                  sm="5"
              >
                <v-menu
                    ref="menu4"
                    v-model="menu4"
                    :close-on-content-click="false"
                    :nudge-right="40"
                    :return-value.sync="time.end"
                    transition="scale-transition"
                    offset-y
                    max-width="290px"
                    min-width="290px"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                        v-model="time.end"
                        label="End Time"
                        prepend-icon="mdi-clock-time-four-outline"
                        readonly
                        v-bind="attrs"
                        v-on="on"
                    ></v-text-field>
                  </template>
                  <v-time-picker
                      v-if="menu4"
                      v-model="time.end"
                      full-width
                      :use-seconds=true
                      @click:second="$refs.menu4.save(time.end)"
                  ></v-time-picker>
                </v-menu>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-btn
              color="blue darken-1"
              text
              :disabled="!(date.start && date.end && time.start && time.end !== null)"
              @click.native="close"
              @click="action === 'create' ? createWorkingTime() : updateWorkingTime()"
          >
            Save
          </v-btn>
          <v-spacer></v-spacer>
          <v-btn
              color="blue darken-1"
              text
              @click.native="close"
          >
            Close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="dialogDelete" max-width="20%">
      <v-card>
        <v-card-title class="text-center text-h6">Are you sure you want to delete this Working Time ?</v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click.native="closeDialog" @click="deleteWorkingTime">OK</v-btn>
          <v-btn color="blue darken-1" text @click="closeDialog">Cancel</v-btn>
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>


import {mapGetters} from "vuex";

export default {
  name: 'WorkingTime',

  props: {
    dialog: {
      type: Boolean,
      default: false
    },
    dialogDelete: {
      type: Boolean,
      default: false
    },
    action: {
      type: String,
      default: "",
    },
  },

  data: () => ({
    date: {
      start: null,
      end: null
    },
    time: {
      start: null,
      end: null
    },
    menu1: false,
    menu2: false,
    menu3: false,
    menu4: false,
  }),

  computed: {
    formTitle () {
      return this.action === 'create' ? "Create Working Time" : "Update Working Time"
    },
    ...mapGetters('userModule', {
      connectedUser: 'connectedUser',
    }),
    ...mapGetters('workingtimesModule', {
      currentWorkingTime: 'selectedWorkingTime',
    }),
  },

  watch: {
    action: function (val) {
      this.date = val === 'create' ? {start: null, end: null} : {start: this.currentWorkingTime.start.split(" ")[0], end: this.currentWorkingTime.end.split(" ")[0] }
      this.time = val === 'create' ? {start: null, end: null} : {start: this.currentWorkingTime.start.split(" ")[1], end: this.currentWorkingTime.end.split(" ")[1] }
    }
  },

  methods: {

    close () {
      this.$emit('update:dialog', false)
    },
    closeDialog () {
      this.$emit('update:dialogDelete', false)
    },
    createWorkingTime () {
      const data = {
        user:  this.connectedUser,
        start: `${this.date.start} ${this.time.start}`,
        end: `${this.date.end} ${this.time.end}`
      }
      this.$store.dispatch('workingtimesModule/createWorkingTimeForSelectedUser', data)
    },
    updateWorkingTime () {
      const data = {
        event:  this.currentWorkingTime,
        start: `${this.date.start} ${this.time.start}`,
        end: `${this.date.end} ${this.time.end}`
      }
      this.$store.dispatch('workingtimesModule/updateWorkingTimeForSelectedUser', data)
    },
    deleteWorkingTime () {
      this.$store.dispatch('workingtimesModule/deleteWorkingTimeForSelectedUser', this.currentWorkingTime)
    },
  },

}
</script>