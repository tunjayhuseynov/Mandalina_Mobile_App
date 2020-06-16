<template>
  <div class="navPadding">
    <div class="container-fluid">
      <h5 class="genreTitle" style="margin-top: 15px">
        <div v-if="genre" style="display: inline; cursor: pointer; margin-left: -10px!important">
          <a @click="backClick">
            <i :class="searchTitle.split('+')[1] + ' fas fa-arrow-left'"></i>
          </a>
        </div>
        {{searchTitle.split("+")[0]}}
      </h5>
      <div class="row" style="padding: 0 12px;">
        <div
          v-for="(value, name) in res"
          :key="name"
          class="col-lg-2"
          style="margin-bottom: 35px; position: static"
        >
          <MovieBox
            :clickedInfo="name"
            @clicked="infoSection"
            :id="value.id"
            :arrayIndex="name"
            :movieName="value.name"
            :moviePoster="assetdomain+value.image"
            :movieLink="value.movieLink"
            :description="value.description"
            :length="value.length"
            :rate="value.rate"
            :year="value.year"
          ></MovieBox>
          <Information
            style="margin-top: 25px"
            v-if="name%6==0"
            :class="['info-'+name] + ' infoBase inSearch'"
            :json="res[movieIndex]"
            :domain="assetdomain"
            :filmType="res[movieIndex].movieType == 1?'movies':'series'"
            :videoActive="videoActive"
          ></Information>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
//import MovieBox from "./MovieBox.vue";
//import Information from "./Information.vue";
const MovieBox = () => import("./MovieBox.vue");
const Information = () => import("./Information.vue");
export default {
  beforeUpdate() {
    
    window.location.hash = "#" + this.searchTitle;
  },
  props: ["res", "searchTitle", "genre", "filmingType"],
  data() {
    return {
      onlyMovieList: [],
      movieIndex: 0,
      prevValue: null,
      prevInfo: null,
      isGenre: this.genre,
      isSearchTitle: this.searchTitle,
      videoActive: false,

    };
  },
  mounted() {
    if (this.isGenre) {
      window.location.href = "/#" + this.searchTitle;
      // $(window).on("popstate", function(e) {
      //   if($(".fas").hasClass("series")){location.hash= "#series"}else{location.hash = ""}
      //   location.reload();
      // });
    }
  },
  components: {
    MovieBox,
    Information
  },
  methods: {
    videoActivate() {
      this.videoActive = !this.videoActive;
    },
    backClick(e) {
      this.$emit("backed", true, $(e.target).attr("class"));
    },
    toggle(info, value) {
      return $(info).slideToggle({
        start: e => {
          this.movieIndex = value;
        }
      });
    },
    infoSection(value, info, index, indexInfo) {
      if (this.prevValue != value && this.prevValue != null) {
        $(".infoBase").slideUp(400);
        this.videoActivate();
        setTimeout(() => {
          if (!this.videoActive) this.videoActivate();
          this.toggle(indexInfo, index);
        }, 400);
      } else {
        this.videoActivate();
        this.toggle(indexInfo, index);
      }

      this.prevValue = value;
    }
  }
};
</script>