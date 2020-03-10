<template>
  <div class="navPadding">
    <div class="suggested">
      <div class="pan">
        <div class="text">
          Example Case
        </div>
        <ul class="genres">
          <li>Aksiyon</li>
          <li>Dram</li>
        </ul>
      </div>
      <video
        style="width: 100%; height: 100%; margin-right: -15px; object-fit: cover;"
        preload="metadata"
        @mouseover="play"
        @mouseleave="pause"
        autoplay
      >
        <source src="/assets/sampleTrailer.mp4" type="video/mp4" />
      </video>
    </div>
    <div
      v-for="(array, name, index) in res"
      :key="index"
      class="container text-center my-3"
      style="max-width: 100%;"
    >
      <h5 class="genreTitle">
        <div
          v-on:click="onClick"
          :class="filmType"
          style=" display: inline-table; cursor: pointer"
        >{{array.title}}</div>
      </h5>
      <div
        :id="['obj-'+name]"
        class="carousel slide w-100"
        data-ride="carousel"
        data-interval="false"
      >
        <div class="carousel-inner w-100" role="listbox">
          <div
            v-for="(value, nameIndex, ind) in spliting(array.items.length)"
            :key="ind"
            style="height: 305px!important"
            :class="{'carousel-item row no-gutters':true, 'active':(nameIndex==0) }"
          >
            <div class="container-fluid">
              <div class="row">
                <div
                  v-for="(value,int,index) in slicing(array.items, nameIndex*6)"
                  :key="index"
                  class="col-lg-2"
                >
                  <MovieBox
                    :clickedInfo="name"
                    @clicked="infoSection"
                    :movieName="value.name"
                    :moviePoster="assetdomain+value.image"
                    :movieLink="value.movieLink"
                    :description="value.description"
                    :length="value.length"
                    :rate="value.rate"
                    :year="value.year"
                    :id="value.id"
                  ></MovieBox>
                </div>
              </div>
            </div>
          </div>
        </div>
        <a
          class="carousel-control-prev"
          :href="['#obj-'+name]"
          style="left: -15px!important; width: 3.7%!important"
          role="button"
          data-slide="prev"
        >
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a
          class="carousel-control-next"
          :href="['#obj-'+name]"
          style="right: -15px!important;  width: 3.7%!important"
          role="button"
          data-slide="next"
        >
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
      <Information
        style="margin-top: 5px"
        :class="['info-'+name] + ' infoBase'"
        :json="onlyMovieList[movieIndex]"
        :domain="assetdomain"
        :filmType="filmType"
        :id="name"
        :videoActive="videoActive"
      ></Information>
    </div>
  </div>
</template>

<script>
//import MovieBox from "./MovieBox.vue";
//import Information from "./Information.vue";
const MovieBox = () => import("./MovieBox.vue");
const Information = () => import("./Information.vue");

export default {
  props: ["load", "type", "res", "onlyMovieList", "filmType"],
  components: {
    MovieBox,
    Information
  },
  data: function() {
    return {
      prevValue: null,
      movieIndex: 0,
      passIndex: 0,
      prevInfo: null,
      videoActive: false
    };
  },
  methods: {
    play(e) {
      $(e.target)
        .get(0)
        .play();
    },
    pause(e) {
      $(e.target)
        .get(0)
        .pause();
    },
    videoActivate() {
      this.videoActive = !this.videoActive;
    },
    onClick(e) {
      this.$emit("clicked", $(e.target).html(), $(e.target).attr("class"));
    },
    toggle(info, value, id) {
      return $(info).slideToggle({
        start: e => {
          this.movieIndex = id;
        }
      });
    },
    spliting: function(len) {
      var num = len % 6 == 0 ? Math.floor(len / 6) : Math.ceil(len / 6);
      return num;
    },
    slicing: function(array, index) {
      return array.slice(index, index + 6);
    },
    infoSection(value, info) {
      this.passIndex = this.onlyMovieList.findIndex(x => x.id === value);

      if (this.prevValue != value && this.prevValue != null) {
        $(".infoBase").slideUp(400);
        this.videoActivate();
        setTimeout(() => {
          this.videoActivate();
          this.toggle(info, value, this.passIndex);
        }, 400);
      } else {
        this.videoActivate();
        this.toggle(info, value, this.passIndex);
      }

      this.prevValue = value;
    }
  }
};
</script>