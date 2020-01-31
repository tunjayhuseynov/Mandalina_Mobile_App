<template>
  <div>
    <navbar @changed="onChange"></navbar>
    <LoaderBar :load="loading"></LoaderBar>
    <carousel v-if="!isSearching" :res="movies"></carousel>
    <search v-if="isSearching" :res="searchedMovie" :searchTitle="searchTitle"></search>
  </div>
</template>

<script>
import LoaderBar from "./Loading.vue";
export default {
  created: function() {
    fetch(this.domainlink + "/api/" + this.type + "/main").then(res => {
      return res.json().then(res => {
        this.loading = false;
        this.movies = res;
      });
    });
  },
  data: function() {
    return {
      isSearching: false,
      movies: null,
      searchedMovie: null,
      loading: true,
      type: "movies",
      searchTitle: null
    };
  },
  methods: {
    onChange(v) {
      if (v) {
        this.isSearching = true;
        fetch(this.domainlink + "/api/search/" + v).then(res => {
          return res.json().then(res => {
            this.searchedMovie = res;
            this.searchTitle = v
          });
        });
      } else {
        this.isSearching = false;
      }
    }
  },
  mounted() {
    console.log("Done Mount.");
  },
  watch: {
    loading(val) {
      console.log("Deyisdi: " + val);
    }
  },
  components: {
    LoaderBar
  }
};
</script>