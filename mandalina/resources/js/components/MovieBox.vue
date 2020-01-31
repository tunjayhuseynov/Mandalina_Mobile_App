<template>
  <div class="custom-box-div">
    <v-lazy-image class="imageSize lazy" :src="moviePoster" src-placeholder="/assets/loader.gif"/>
    <div class="playButton">
      <router-link :to="{ name: 'VideoPlayer', params: { value } }"><i class="far fa-play-circle playFont"></i></router-link>
    </div>
    <div class="boxMovieName">
      
     <h6> <router-link :to="{ name: 'VideoPlayer', params: { value } }" class="titelFont">{{ movieName }}</router-link></h6>
    </div>
  </div>
</template>


<script>
import VLazyImage from "v-lazy-image";

export default {
  props: ["movieName", "moviePoster", "movieLink", "description", "rate", "length", "year"],
  mounted() {

  },
  components: {
    VLazyImage
  },
    data () {
    return {
      value: {
        link: this.movieLink,
        name: this.movieName,
        desc: this.description,
        rate: this.rate,
        length: this.length,
        year: this.year,
        poster: this.moviePoster
      }
    }
  }
};
</script>