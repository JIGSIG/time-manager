<template>
  <v-row class="fill-height mt-3">
    <v-col>
      <WorkingTime :dialog.sync="dialog" :dialog-delete.sync="dialogDelete" :action="action"></WorkingTime>
      <v-sheet height="64">
        <v-toolbar
            flat
        >

          <v-btn
              outlined
              class="mr-4"
              color="grey darken-2"
              @click="setToday"
          >
            Today
          </v-btn>
          <v-btn
              fab
              text
              small
              color="grey darken-2"
              @click="prev"
          >
            <v-icon small>
              mdi-chevron-left
            </v-icon>
          </v-btn>
          <v-btn
              fab
              text
              small
              color="grey darken-2"
              @click="next"
          >
            <v-icon small>
              mdi-chevron-right
            </v-icon>
          </v-btn>
          <v-toolbar-title v-if="$refs.calendar">
            {{ $refs.calendar.title }}
          </v-toolbar-title>
          <v-spacer></v-spacer>
          <v-menu
              bottom
              right
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                  outlined
                  color="grey darken-2"
                  v-bind="attrs"
                  v-on="on"
              >
                <span>{{ typeToLabel[type] }}</span>
                <v-icon right>
                  mdi-menu-down
                </v-icon>
              </v-btn>
            </template>
            <v-list>
              <v-list-item @click="type = 'day'">
                <v-list-item-title>Day</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'week'">
                <v-list-item-title>Week</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'month'">
                <v-list-item-title>Month</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = '4day'">
                <v-list-item-title>4 days</v-list-item-title>
              </v-list-item>
            </v-list>

          </v-menu>

          <v-btn
              class="ml-4"
              color="primary darken-2"
              @click="dialog = true; action = 'create'"
              :disabled="!connectedUser.id"
          >
            New Working Time
          </v-btn>

          <v-btn
              class="ml-4"
              v-bind:color="lastClock.status ? 'primary' : 'success'"
              @click="updateClock"
              :disabled="!connectedUser.id"
          >
            {{ clockTitle }}
          </v-btn>
        </v-toolbar>
      </v-sheet>
      <v-sheet height="350">
        <v-calendar
            ref="calendar"
            v-model="focus"
            color="primary"
            :events="events"
            :event-color="getEventColor"
            :type="type"
            @click:event="showEvent"
            @click:more="viewDay"
            @click:date="viewDay"
            @change="updateRange"
            :key="connectedUser.id"
        ></v-calendar>
        <v-menu
            v-model="selectedOpen"
            :close-on-content-click="false"
            :activator="selectedElement"
            offset-x
        >
          <v-card
              color="grey lighten-4"
              min-width="350px"
              flat
          >
            <v-toolbar
                :color="selectedEvent.color"
                dark
            >
              <v-toolbar-title v-html="selectedEvent.name"></v-toolbar-title>
              <v-spacer></v-spacer>
              <v-btn icon>
                <v-icon @click="action = 'update'; dialog = true">mdi-pencil</v-icon>
              </v-btn>
              <v-btn icon @click="action = 'delete'; dialogDelete = true">
                <v-icon>mdi-delete</v-icon>
              </v-btn>
            </v-toolbar>
            <v-card-text>
              <span v-html="selectedEvent.details"></span>
            </v-card-text>
            <v-card-actions>
              <v-btn
                  text
                  color="secondary"
                  @click="selectedOpen = false"
              >
                Cancel
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-menu>
      </v-sheet>
    </v-col>
  </v-row>
</template>

<script>
import {mapGetters} from "vuex";
import WorkingTime from "./WorkingTime";

export default {
  components: {WorkingTime},
  data: () => ({
    action: "",
    dialog: false,
    dialogDelete: false,
    focus: '',
    type: 'month',
    typeToLabel: {
      month: 'Month',
      week: 'Week',
      day: 'Day',
      '4day': '4 Days',
    },
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
    elapsedTime: 0,
    timer: undefined
  }),

  computed: {
    ...mapGetters('userModule', {
      selectedUser: 'selectedUser',
      connectedUser: 'connectedUser',
      currentToken: 'currentToken',
    }),
    ...mapGetters('workingtimesModule', {
      events: 'events',
      selectedWorkingTime: 'selectedWorkingTime'
    }),
    ...mapGetters('clockModule', {
      lastClock: 'lastClock'
    }),
    clockTitle() {
      let time = undefined
      const date = new Date(null);
      date.setSeconds(this.elapsedTime / 1000);
      const utc = date.toUTCString();
      time = utc.substr(utc.indexOf(":") - 2, 8);
      return !this.lastClock.status ? "Clock'In!" : time
    }
  },

  mounted () {
    this.$refs.calendar.checkChange()
    console.log('connectedUser', this.connectedUser)
    console.log('token', this.currentToken)
  },

  watch: {
    connectedUser: function () {
      this.$store.dispatch('clockModule/getClockForSelectedUser', this.connectedUser.id)
    },
  },

  methods: {
    viewDay ({ date }) {
      this.focus = date
      this.type = 'day'
    },
    getEventColor (event) {
      return event.color
    },
    setToday () {
      this.focus = ''
    },
    prev () {
      this.$refs.calendar.prev()
    },
    next () {
      this.$refs.calendar.next()
    },
    showEvent ({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event
        this.selectedElement = nativeEvent.target
        requestAnimationFrame(() => requestAnimationFrame(() => this.selectedOpen = true))
      }

      if (this.selectedOpen) {
        this.selectedOpen = false
        requestAnimationFrame(() => requestAnimationFrame(() => open()))
      } else {
        open()
      }

      nativeEvent.stopPropagation()
      this.$store.dispatch('workingtimesModule/getWorkingTimeForSelectedUser', event.id)
    },

    updateRange ({ start, end }) {
      const data = {
        user:  this.connectedUser,
        start: start.date + " 00:00:00",
        end: end.date + " 00:00:00"
      }
      this.$store.dispatch('workingtimesModule/getAllWorkingTimesForSelectedUser', data)

    },

    rnd (a, b) {
      return Math.floor((b - a + 1) * Math.random()) + a
    },

    updateClock() {
      if (!this.lastClock.status) {
        if (this.lastClock.status)
          this.elapsedTime = new Date(this.lastClock.time).getTime()
        this.timer = setInterval(() => {
          this.elapsedTime += 1000;
        }, 1000);
      }
      else {
        clearInterval(this.timer);
        this.elapsedTime = 0
      }

      this.$store.dispatch('clockModule/setClockForSelectedUser', this.connectedUser.id)
    }

  },
}
</script>