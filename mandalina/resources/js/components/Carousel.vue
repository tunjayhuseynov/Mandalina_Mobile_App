<template>
  <div class="navPadding">
    <div
      v-for="(array, name, index) in res"
      :key="index"
      class="container text-center my-3"
      style="max-width: 100%;"
    >
      <h5 class="genreTitle">{{array.title}}</h5>
      <div :id="['obj-'+name]" class="carousel slide w-100" data-ride="carousel" data-interval="false">
        <div class="carousel-inner w-100" role="listbox">
          <div
            v-for="(value, nameIndex, ind) in spliting(array.items.length)"
            :key="ind"
            style="height: 301px!important"
            :class="{'carousel-item row no-gutters':true, 'active':(nameIndex==0) }"
          >
            <div class="container-fluid">
              <div class="row">
                <div
                  v-for="(value,name,index) in slicing(array.items, nameIndex*6)"
                  :key="index"
                  class="col-lg-2"
                >
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
    </div>
  </div>
</template>

<script>
import MovieBox from "./MovieBox.vue";


export default {
  props: ["load", "type", "res"],
  components: {
    MovieBox,

  },
  data: function() {
    return {
      movies: null,
    };
  },
  methods: {
    spliting: function(len) {
      var num = len % 6 == 0 ? Math.floor(len / 6) : Math.ceil(len / 6);
      return num;
    },
    slicing: function(array, index) {
      return array.slice(index, index + 6);
    },
  },

};
</script>