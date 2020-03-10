<template>
  <div>
    <navbar @changed="onChange" :genres="genres" @clicked="onClick"></navbar>
    <LoaderBar :load="loading"></LoaderBar>
    <carousel
      @clicked="onClick"
      v-if="!isSearching && !isGenre && !loading"
      :res="movies"
      :onlyMovieList="onlyMovieList"
      :filmType="type"
    ></carousel>
    <search v-if="isSearching" :res="searchedMovie" :searchTitle="searchTitle"></search>
    <search
      v-if="isGenre"
      @backed="backedClick"
      :res="genreMovie"
      :searchTitle="searchTitle"
      :genre="true"
      :filmType="type"
    ></search>
  </div>
</template>

<script>
//import LoaderBar from "./Loading.vue";
const LoaderBar = () => import("./Loading.vue");

export default {
  beforeRouteUpdate(to, from, next) {
    if(to.hash == "#series" || to.hash == "" || to.hash == "#"){
      location.hash = to.hash
    location.reload()
    }
    next();
  },
  props: ["types"],
  data: function() {
    return {
      isGenre: false,
      isSearching: false,
      movies: null,
      searchedMovie: null,
      genreMovie: null,
      genres: null,
      loading: true,
      type: window.location.hash == "#series" ? "series" : "movies",
      playertype: location.hash.includes("player")
        ? window.location.hash.split("&movie=")[0].split("link=")[1] == "series"
          ? "series"
          : "movies"
        : null,
      searchTitle: null,
      onlyMovieList: []
    };
  },
  created: function() {
    if (location.hash.includes("player")) {
      var hash = location.hash.split("movie=")[1];
      this.$router.push({
        name: "Player",
        params: {
          id: hash,
          link: this.playertype == null ? this.type : this.playertype
        }
      });
    }
    $("body").css("overflow-y", "scroll");
    this.fetchMovieMain();
    this.fetchGenres();
  },
  methods: {
    backedClick(b, t) {
      window.location.hash = t.includes("series") ? "#series" : "";
      location.reload();
    },
    onChange(v) {
      if (v) {
        this.isGenre = false
        this.loading = true
        this.isSearching = true;
        this.searchedMovie = null;
        fetch(this.domainlink + "/api/search/" + v).then(res => {
          return res.json().then(res => {
            this.loading = false
            this.searchedMovie = res;
            this.searchTitle = v;
          });
        });
      } else {
        this.isSearching = false;
      }
    },
    onClick(e, c) {
      this.genreMovie = null;
      this.loading = true;
      this.isGenre = true;
      this.searchTitle = c == "series" ? e + "+" + c : e;
      fetch(
        this.domainlink + "/api/" + c + "/" + e.toLowerCase() + "/0/10000"
      ).then(res => {
        window.scrollTo(0, 0);
        this.loading = false;
        return res.json().then(res => {
          this.genreMovie = res;
        });
      });
    },
    fetchMovieMain() {
      this.onlyMovieList = [];
      fetch(this.domainlink + "/api/" + this.type + "/main").then(res => {
        return res.json().then(res => {
          this.loading = false;
          this.movies = res;
          res.forEach(element => {
            element.items.forEach(e => {
              this.onlyMovieList.push(e);
            });
          });
        });
      });
    },
    fetchGenres() {
      fetch(this.domainlink + "/api/genres").then(res => {
        return res.json().then(res => {
          this.genres = res;
        });
      });
    }
  },
  mounted() {},
  components: {
    LoaderBar
  }
};
</script>
