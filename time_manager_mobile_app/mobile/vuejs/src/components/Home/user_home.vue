<template>
  <v-card height="100vh">
    <v-btn
        class="ml-4"
        v-bind:color="lastClock.status ? 'primary' : 'success'"
        @click="updateClock"
        :disabled="!this.selectedUser.id"
    >
      {{ clockTitle }}
    </v-btn>
  </v-card>
</template>

<script>
import {mapGetters} from "vuex";

export default {
  name: "user_home",

  data: () => ({
    action: "",
    elapsedTime: 0,
    timer: undefined
  }),

  computed: {
    ...mapGetters('userModule', {
      selectedUser: 'user'
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

  watch: {
    selectedUser: function () {
      this.$store.dispatch('clockModule/getClockForSelectedUser', this.selectedUser.id)
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
        user:  this.selectedUser,
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

      this.$store.dispatch('clockModule/setClockForSelectedUser', this.selectedUser.id)
    }

  },

}

</script>

<style scoped>

</style>