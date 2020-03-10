<template>
  <div class="custom-box-div">
   <div v-on:click="onClick">  <v-lazy-image style="cursor: pointer" class="imageSize lazy" :src="moviePoster" src-placeholder="/assets/loader.gif" /></div>
    <div class="boxMovieName">
      <h6 class="titelFont" v-on:click="onClick" style="cursor: pointer">{{ movieName }}</h6>
    </div>
  </div>
</template>


<script>
import VLazyImage from "v-lazy-image";

export default {
  props: [
    "movieName",
    "moviePoster",
    "movieLink",
    "description",
    "rate",
    "length",
    "year",
    "id",
    "clickedInfo",
    "arrayIndex"
  ],
  mounted() {},
  components: {
    VLazyImage
  },
  data() {
    return {
      value: {
        link: this.movieLink,
        name: this.movieName,
        desc: this.description,
        rate: this.rate,
        length: this.length,
        year: this.year,
        poster: this.moviePoster,
        id: this.id,
        clickedInfo: this.clickedInfo,
      }
    };
  },
  methods: {
    onClick() {
      this.$emit("clicked", this.id, ".info-"+ this.clickedInfo, this.clickedInfo, ".info-"+ (Math.floor(this.clickedInfo/6)*6));
    }
  }
};
</script>