<template>
  <v-layout row >
    <v-flex md4>
      <v-card class="ma-5">
        <line-chart :key="lineId" :chartdata="LineChartData" :options="LineChartOptions"></line-chart>
      </v-card>
    </v-flex>
    <v-flex md4>
      <v-card class="ma-5">
        <bar-chart :key="barId" :chartdata="BarChartData" :options="BarChartOptions"></bar-chart>
      </v-card>
    </v-flex>
    <v-flex md4>
      <v-card class="ma-5">
        <doughnut-chart :key="doughnutId" :chartdata="DoughnutChartData" :options="DoughnutChartOptions"></doughnut-chart>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
import LineChart from './Charts/LineChart'
import BarChart from "./Charts/BarChart";
import DoughnutChart from "./Charts/DoughnutChart";
import {mapGetters} from "vuex";

export default {

  name: 'ChartManager',

  components: {
      LineChart, BarChart, DoughnutChart
  },

  data: () => ({
      LineChartData: {
        labels: [
          'Jan',
          'Feb',
          'March',
          'April',
          'May',
          'June',
          'July',
          'Aug',
          'Sept',
          'Oct',
          'Nov',
          'Dec',
        ],
        datasets: [{
          label: 'Worked Hours in Month',
          backgroundColor: 'rgb(255, 99, 132)',
          borderColor: 'rgb(255, 99, 132)',
          data: [],
          fill: false
        }]
      },
      LineChartOptions: {
        responsive: true
      },

      BarChartData: {
        labels: [
          'Jan',
          'Feb',
          'March',
          'April',
          'May',
          'June',
          'July',
          'Aug',
          'Sept',
          'Oct',
          'Nov',
          'Dec',
        ],
        datasets: [
          {
            label: 'Worked Hours',
            data: [],
            backgroundColor: [
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(54, 162, 235, 0.2)',
            ],
            borderColor: [
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
              'rgb(54, 162, 235)',
            ],
            borderWidth: 1
        },
          {
            label: 'Working Times',
            data: [],
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
              'rgb(255, 99, 132)',
            ],
            borderWidth: 1
        },
        ]
      },
      BarChartOptions: {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'Chart.js Floating Bar Chart'
          }
        }
      },

      DoughnutChartData: {
        labels: [
          'Worked Hours',
          'Working Times',
        ],
        datasets: [{
          label: 'My First Dataset',
          data: [],
          backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(54, 162, 235)',
          ],
          hoverOffset: 4
        }]
      },

      DoughnutChartOptions: {
        responsive: true
      },

    }),

  mounted() {
      this.$store.dispatch('chartModule/getAllClockForUser', this.connectedUser)
      this.$store.dispatch('chartModule/getAllWorkingTimesForSelectedUser', this.connectedUser)
      console.log("mounted")
    },

  created() {
    this.$store.dispatch('chartModule/getAllClockForUser', this.connectedUser)
    this.$store.dispatch('chartModule/getAllWorkingTimesForSelectedUser', this.connectedUser)
  },

  watch: {
      connectedUser: function () {
        this.$store.dispatch('chartModule/getAllClockForUser', this.connectedUser)
        this.$store.dispatch('chartModule/getAllWorkingTimesForSelectedUser', this.connectedUser)
        console.log('ok', this.connectedUser);
      },

      events: function () {
        this.$store.dispatch('chartModule/getAllClockForUser', this.connectedUser)
        this.$store.dispatch('chartModule/getAllWorkingTimesForSelectedUser', this.connectedUser)
      },

      clock: function () {
        this.$store.dispatch('chartModule/getAllClockForUser', this.connectedUser)
        this.$store.dispatch('chartModule/getAllWorkingTimesForSelectedUser', this.connectedUser)
      },

      line_chart_data: function () {
        this.LineChartData.datasets[0].data = this.line_chart_data
        console.log("changes")
      },
      
      bar_chart_data: function () {
        this.BarChartData.datasets[0].data = this.bar_chart_data[0]
        this.BarChartData.datasets[1].data = this.bar_chart_data[1]
      },
      
      doughnut_chart_data: function () {
        this.DoughnutChartData.datasets[0].data = this.doughnut_chart_data
      },
      
    },

  computed: {
      ...mapGetters('userModule', {
        selectedUser: 'selectedUser',
        connectedUser: 'connectedUser',
      }),
      ...mapGetters('workingtimesModule', {
        events: 'events'
      }),
      ...mapGetters('clockModule', {
        clock: 'lastClock'
      }),
      ...mapGetters('chartModule', {
        line_chart_data: 'lineChartGetter',
        bar_chart_data: 'barChartGetter',
        doughnut_chart_data: 'doughnut_chart_data',
      }),
      lineId () {
        return this.line_chart_data.reduce((partial_sum, a) => partial_sum + a, 1)
      },
      barId () {
        return this.bar_chart_data[0].reduce((partial_sum, a) => partial_sum + a, 2)
             + this.bar_chart_data[1].reduce((partial_sum, a) => partial_sum + a, 2)
      },
      doughnutId () {
        return this.doughnut_chart_data.reduce((partial_sum, a) => partial_sum + a, 53)
      },
    },

  methods: {
    }

  }
</script>

