<template>
  <div class="navPadding">
    <div class="container-fluid">
      <h5 class="genreTitle" style="margin-top: 15px">{{searchTitle}}</h5>
      <div class="row" style="padding: 0 12px;">
        <div v-for="(value, name, index) in res" :key="index" class="col-lg-2">
          <MovieBox
            :movieName="value.name"
            :moviePoster="'https://filmdizimob.com/'+value.image"
            :movieLink="value.movieLink"
            :description="value.description"
            :length="value.length"
            :rate="value.rate"
            :year="value.year"
          ></MovieBox>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import MovieBox from "./MovieBox.vue";
export default {
  props: ["res", "searchTitle"],
  created: function() {},
  mounted() {
    console.log("Done Mount.");
  },
  components: {
    MovieBox
  }
};
</script>