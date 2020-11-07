<template>
  <div>
    <div class="container-fluid headDiv">
      <div class="row">
        <div class="col-md-12">
          <h2 style="color: white; height:100%; margin-left: 3%">
            <span style="cursor: pointer; z-index:111" id="searchBack" @click="backAction">
              <svg
                version="1.1"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                x="0px"
                y="0px"
                width="1.4rem"
                height="1.4rem"
                fill="white"
                viewBox="0 0 46.02 46.02"
                style="enable-background:new 0 0 46.02 46.02;transform: rotate(180deg);height:100%"
                xml:space="preserve"
              >
                <path
                  d="M14.757,46.02c-1.412,0-2.825-0.521-3.929-1.569c-2.282-2.17-2.373-5.78-0.204-8.063l12.758-13.418L10.637,9.645
			C8.46,7.37,8.54,3.76,10.816,1.582c2.277-2.178,5.886-2.097,8.063,0.179l16.505,17.253c2.104,2.2,2.108,5.665,0.013,7.872
			L18.893,44.247C17.77,45.424,16.267,46.02,14.757,46.02z"
                />
              </svg>
            </span>
            Arama: {{getQuery}}
          </h2>
        </div>

        <div
          class="col-md-3"
          style="text-align: center;"
          v-for="(item, index) in getResult"
          :key="index"
        >
          <router-link class="routeA" :to="`/about/${item.id}/${getParName(item.name)}`">
            <v-lazy-image
              class="image"
              height="350"
              width="235"
              src-placeholder="/assets/loader.gif"
              :src="item.image || 'placeHolder.jpg'"
              :alt="item.name"
            />
            <div class="imdb anim">
              <span style="font-family: fantasy; font-weight: 400">IMDb:</span>
              {{item.imdb}}
            </div>
            <div class="flags anim">
              <img
                v-if="item.movieLink"
                src="/assets/trIcon.png"
                height="32"
                alt="Türkçe"
                title="Türkçe"
              />
              <img
                v-if="item.englishLink"
                src="/assets/usIcon.png"
                height="32"
                alt="Türkçe Altyazı"
                title="Türkçe Altyazı"
              />
            </div>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import VLazyImage from "v-lazy-image";
import api from "../../Api";
import fun from "../../Functions";
export default {
  computed: {
    getQuery() {
      return this.$store.state.searchQuery != null
        ? this.$store.state.searchQuery
        : this.$route.query.q;
    },
    getResult() {
      return this.$store.state.searchResult != null
        ? this.$store.state.searchResult
        : api.getSearch(this.getQuery).then((response) => {
            this.$store.commit("setSearchResult", response.data);
          });
    },
  },
  methods: {
    backAction() {
      this.$router.push(this.$store.state.searchPath || "movie");
    },
    getParName(val) {
      return fun.convertTurkish2English(val);
    },
  },
  beforeDestroy() {
    this.$store.state.searchBox.value = "";
  },
  components: {
    VLazyImage,
  },
};
</script>

<style scoped>
.image {
  cursor: pointer;
  margin: 15px 0;
  transition: all ease 0.5s;
}
a{
  transition: all ease 0.5s;
}
a:hover {
  transform: scale(1.1);
}
.v-lazy-image {
  opacity: 0;
  transition: all ease 0.5s, opacity 1.5s;
}
.v-lazy-image-loaded {
  opacity: 1;
}
.imdb {
  position: absolute;
  left: -1px;
  bottom: 13px;
  padding: 0 8px;
  height: 25px;
  border-bottom-right-radius: 15px;
  background-color: #e2b616;
  color: #111;
  border-bottom: 2px solid #111;
  border-right: 2px solid #111;
  font-weight: bold;
  font-family: sans-serif;

}
.flags{
  position: absolute;
  bottom: 13px;
  right: 8px;

}
.routeA{
  position: relative; display: inline-block
}

.anim{
  animation-duration: 1.5s;
  animation-name: fadeIn;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  
  to {
    opacity: 1;
  }
}

.headDiv{
  padding-top: 75px;
}

@media only screen and (max-width: 1023px) and (min-width: 768px) {
  .image{
    width: 170px;
    height: 270px;
  }
}

@media only screen and (max-width: 768px) {
  .headDiv{
    padding-top: 110px;
  }
}
</style>