<template>
  <div>
    <loading v-show="getMovies == null || getSeries == null || getSuggestedMovie == null || getSuggestedSerie == null"></loading>
    <navbar></navbar>
    <mainpart></mainpart>
  </div>
</template>

<script>
import api from "./Api";
export default {
  data() {
    return {};
  },
  computed: {
    getMovies() {
      return this.$store.state.homeMovies;
    },
    getSuggestedMovie() {
      return this.$store.state.movieSuggested;
    },
    getSuggestedSerie() {
      return this.$store.state.serieSuggested;
    },
    getSeries() {
      return this.$store.state.homeSeries;
    }
  },
  async created() {
    await this.getHomeMovies();
    await this.getHomeSeries();
    await this.getMovieSuggested();
    await this.getSerieSuggested();
  },
  methods: {
    async getHomeMovies() {
      api.getHomeMovies().then(response => {
        this.$store.commit("setHomeMovies", response.data);
      });
    },
    async getHomeSeries() {
      api.getHomeSeries().then(response => {
        this.$store.commit("setHomeSeries", response.data);
      });
    },
    async getMovieSuggested() {
      api.getMovieSuggested().then(response => {
        this.$store.commit("setMovieSuggested", response.data);
      });
    },
    async getSerieSuggested() {
      api.getSerieSuggested().then(response => {
        this.$store.commit("setSerieSuggested", response.data);
      });
    }
  }
};
</script>

