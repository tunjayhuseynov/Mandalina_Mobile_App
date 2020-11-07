<template>
  <div>
        <!-- Do NOT use an anchor tag for the mobile menu button -->
    <span id="moby-button">
      <i class="material-icons">menu</i>
    </span>
    <loading
      v-show="getMovies == null || getSeries == null || getSuggestedMovie == null || getSuggestedSerie == null"
    ></loading>
    <navbar></navbar>
    <transition :name="transitionName" mode="out-in">
      <router-view></router-view>
    </transition>



    <nav id="main-nav">
      <ul>
        <li>
          <router-link class="routeFont" to="/movie">Filmler</router-link>
        </li>
        <li>
          <router-link class="routeFont" to="/tvshows">Diziler</router-link>
        </li>
        <li><router-link class="routeFont" to="/tvshows">Iletişim</router-link></li>
      </ul>
    </nav>
  </div>
</template>

<script>
import api from "../Api";
const DEFAULT_TRANSITION = "fade";
export default {
  mounted() {
        let template = `
    <div class="moby-inner">
      <div class="moby-close"><span class="moby-close-icon"></span></div>
        <div class="moby-wrap">
          <div>
            <div class="moby-menu">
            </div>
          </div>
      </div>
    </div>
        `;
    var mobyMenu = new Moby({
      menu: $("#main-nav"),
      mobyTrigger: $("#moby-button"),
      menuClass: "left-side",
      template: template
    });
  },
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
    await this.getGenres();
    this.dynamicTransition();
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
    async getGenres() {
      api.getAllCategories().then((response) => {
        this.$store.commit("setAllGenres", response.data);
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

#moby-button {
  display: none;
}
#moby-button::after {
  content: "";
  position: absolute;
  left: -13px;
  top: -13px;
  z-index: -1;
  background-color: rgb(221, 221, 221);
  border-left: 50px solid rgb(221, 221, 221);
  border-bottom: 50px solid rgb(221, 221, 221);
  border-radius: 100%;
}

.moby,
.moby .moby-close {
  background: #111 !important;
}

#main-nav{
  display: none;
}



@media only screen and (max-width: 767px) {
  #moby-button {
    z-index: 11;
    display: block;
    position: fixed;
    bottom: 20px;
    right: 20px;
  }
  .routeFont{
  color: white!important;
  font-size: 1.5rem!important;
  padding: 10px 90px 30px 30px!important;
}
}
</style>