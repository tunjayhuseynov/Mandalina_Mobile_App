<template>
  <div>
    <loading
      v-show="getMovies == null || getSeries == null || getSuggestedMovie == null || getSuggestedSerie == null"
    ></loading>
    <navbar></navbar>
    <transition :name="transitionName" mode="out-in">
      <router-view></router-view>
    </transition>
    <!--<mainpart></mainpart>-->
  </div>
</template>

<script>
import api from "./Api";
const DEFAULT_TRANSITION = "fade";
export default {
  data() {
    return {
      transitionName: DEFAULT_TRANSITION,
    };
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
    },
  },
  async created() {
    await this.getHomeMovies();
    await this.getHomeSeries();
    await this.getMovieSuggested();
    await this.getSerieSuggested();
    this.dynamicTransition()
  },
  methods: {
    async getHomeMovies() {
      api.getHomeMovies().then((response) => {
        this.$store.commit("setHomeMovies", response.data);
      });
    },
    async getHomeSeries() {
      api.getHomeSeries().then((response) => {
        this.$store.commit("setHomeSeries", response.data);
      });
    },
    async getMovieSuggested() {
      api.getMovieSuggested().then((response) => {
        this.$store.commit("setMovieSuggested", response.data);
      });
    },
    async getSerieSuggested() {
      api.getSerieSuggested().then((response) => {
        this.$store.commit("setSerieSuggested", response.data);
      });
    },
    dynamicTransition() {
      this.$router.beforeEach((to, from, next) => {
        let transitionName = to.meta.transitionName || from.meta.transitionName;

        if (transitionName === "slide") {
          const toDepth = to.path.split("/").length;
          const fromDepth = from.path.split("/").length;
          transitionName = toDepth < fromDepth ? "slide-right" : "slide-left";
        }

        this.transitionName = transitionName || DEFAULT_TRANSITION;

        next();
      });
    },
  },
};
</script>

<style>
.fade-enter-active,
.fade-leave-active {
  transition-duration: 0.2s;
  transition-property: opacity;
  transition-timing-function: ease;
}

.fade-enter,
.fade-leave-active {
  opacity: 0;
}
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition-duration: 0.2s;
  transition-property: height, opacity, transform;
  transition-timing-function: cubic-bezier(0.55, 0, 0.1, 1);
  overflow: hidden;
}

.slide-left-enter,
.slide-right-leave-active {
  opacity: 0;
  transform: translate(1em, 0);
}

.slide-left-leave-active,
.slide-right-enter {
  opacity: 0;
  transform: translate(-1em, 0);
}
</style>