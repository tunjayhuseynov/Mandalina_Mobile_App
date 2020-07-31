<template>
  <div>
    <div class="carouselSection">
      <div class="title">
        <router-link style="color: #ddd" :to="`category/${this.$route.name=='Movies'?'movies':'series'}/${json.title}`">
        {{json.title}}
        <svg
          version="1.1"
          id="nextIcon"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          x="0px"
          y="0px"
          width="1.4rem"
          height="1.4rem"
          fill="white"
          viewBox="0 0 46.02 46.02"
          style="enable-background:new 0 0 46.02 46.02;"
          xml:space="preserve"
        >
          <path
            d="M14.757,46.02c-1.412,0-2.825-0.521-3.929-1.569c-2.282-2.17-2.373-5.78-0.204-8.063l12.758-13.418L10.637,9.645
			C8.46,7.37,8.54,3.76,10.816,1.582c2.277-2.178,5.886-2.097,8.063,0.179l16.505,17.253c2.104,2.2,2.108,5.665,0.013,7.872
			L18.893,44.247C17.77,45.424,16.267,46.02,14.757,46.02z"
          />
        </svg>
        </router-link>
      </div>
      <div class="carouselContainer">
        <div class="item" v-for="(item, index) in json.items" :key="index">
          <router-link :to="`/about/${item.id}/${getParName(item.name)}`">
            <v-lazy-image
              height="350"
              width="235"
              src-placeholder="/assets/loader.gif"
              :src="item.image"
            />
          </router-link>
        </div>
        <div class="rightSpace"></div>
      </div>

      <div class="prev">
        <svg
          @click="prev"
          version="1.1"
          id="nextIcon"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          x="0px"
          y="0px"
          width="2.5rem"
          height="2.5rem"
          fill="white"
          viewBox="0 0 46.02 46.02"
          style="enable-background:new 0 0 46.02 46.02;transform: rotate(180deg)"
          xml:space="preserve"
        >
          <path
            d="M14.757,46.02c-1.412,0-2.825-0.521-3.929-1.569c-2.282-2.17-2.373-5.78-0.204-8.063l12.758-13.418L10.637,9.645
			C8.46,7.37,8.54,3.76,10.816,1.582c2.277-2.178,5.886-2.097,8.063,0.179l16.505,17.253c2.104,2.2,2.108,5.665,0.013,7.872
			L18.893,44.247C17.77,45.424,16.267,46.02,14.757,46.02z"
          />
        </svg>
      </div>
      <div class="next">
        <!-- <div class="backgroundBlack"></div> -->
        <svg
          @click="next"
          version="1.1"
          id="nextIcon"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          x="0px"
          y="0px"
          width="2.5rem"
          height="2.5rem"
          fill="white"
          viewBox="0 0 46.02 46.02"
          style="enable-background:new 0 0 46.02 46.02;"
          xml:space="preserve"
        >
          <path
            d="M14.757,46.02c-1.412,0-2.825-0.521-3.929-1.569c-2.282-2.17-2.373-5.78-0.204-8.063l12.758-13.418L10.637,9.645
			C8.46,7.37,8.54,3.76,10.816,1.582c2.277-2.178,5.886-2.097,8.063,0.179l16.505,17.253c2.104,2.2,2.108,5.665,0.013,7.872
			L18.893,44.247C17.77,45.424,16.267,46.02,14.757,46.02z"
          />
        </svg>
      </div>
    </div>
  </div>
</template>

<script>
import VLazyImage from "v-lazy-image";
import fun from "./Functions";
export default {
  props: ["json"],
  data() {
    return {
      scrollWidth: 0,
      carousel: null,
    };
  },
  mounted() {
    this.carousel = this.$el.querySelector(".carouselContainer");
    var item = this.$el.querySelector(".item");
    var visibileItemNum = Math.floor(window.innerWidth / item.offsetWidth);
    this.scrollWidth = item.offsetWidth * visibileItemNum;
  },
  methods: {
    prev: function () {
      this.carousel.scrollLeft -= this.scrollWidth;
    },
    next: function () {
      this.carousel.scrollLeft += this.scrollWidth;
    },
    getParName(val) {
      return fun.convertTurkish2English(val);
    },
  },
  components: {
    VLazyImage,
  },
};
</script>

<style scoped>
.rightSpace {
  padding: 35px;
}
.backgroundBlack {
  width: 100%;
  height: 15rem;
  top: -5rem;
  z-index: -1;

  background-color: rgba(17, 17, 17, 0.25);
}
#nextIcon {
  z-index: 10;
}
/* .next::before {
  content: "";
  position: absolute;
  top: -5rem;
  left: 0;
  width: 5rem;
  z-index: -1;
  height: 15rem;
  background-color: rgba(17, 17, 17, 1);
  opacity: 0.7;
} */
.prev {
  position: absolute;
  left: 2%;
  cursor: pointer;
  top: 50%;
  transform: translateY(-50%);
  color: white;
}
.next {
  position: absolute;
  right: 2%;
  top: 50%;
  z-index: 5;
  transform: translateY(-50%);
  cursor: pointer;
  color: white;
}
.title {
  color: white;
  padding: 0 0 0 30px;
  font-weight: 600;
  font-size: 1.4rem;
  cursor: pointer;
  display: inline;
}
.item {
  display: inline-block;
  padding: 10px;
  transition: all 0.5s;
  margin: 0;
  pointer-events: auto;
  cursor: pointer;
}
.item:hover {
  transform: scale(1.2);
  margin: 0 60px 0 20px;
}
.carouselContainer {
  pointer-events: none;
  transition: all 0.5s;
}
.carouselContainer:hover .item:not(:hover) {
  transform: translate3d(-20px, 0, 0);
}

.carouselContainer {
  position: relative;
  width: 100%;
  overflow-x: hidden;
  scroll-behavior: smooth;
  display: flex;
  padding: 30px 40px 40px 20px;
}
.carouselSection {
  position: relative;
  width: 100%;
  padding: 30px 0 0 0;
}
</style>