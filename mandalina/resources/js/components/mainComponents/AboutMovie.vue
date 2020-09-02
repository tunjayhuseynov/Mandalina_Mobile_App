<template>
  <div v-if="getMovie!=null">
    <div class="container-fluid" style="padding-bottom: 20px">
      <div class="row">
        <!-- <div class="col-md-12">
          <span style="cursor: pointer" id="searchBack">
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
        </div>-->
        <div class="col-md-12" style="margin-bottom: 15px">
          <div class="poster">
            <div class="watchModal dynTr" @click="showModal()">
              <svg
                class="playBtn"
                version="1.0"
                xmlns="http://www.w3.org/2000/svg"
                width="100px"
                height="100px"
                fill="#111"
                viewBox="0 0 626.000000 626.000000"
                preserveAspectRatio="xMidYMid meet"
              >
                <g
                  transform="translate(0.000000,626.000000) scale(0.100000,-0.100000)"
                  stroke="none"
                >
                  <path
                    d="M2870 6249 c-763 -75 -1437 -390 -1956 -912 -169 -171 -284 -312
-401 -492 -530 -815 -654 -1799 -343 -2724 109 -324 301 -677 506 -931 38 -47
75 -94 84 -105 40 -52 316 -319 400 -386 763 -615 1772 -840 2715 -607 420
103 842 308 1175 569 139 109 143 113 275 244 181 180 276 293 401 480 703
1052 711 2398 19 3460 -195 300 -468 588 -760 805 -378 281 -874 490 -1344
566 -257 41 -555 54 -771 33z m575 -638 c200 -26 482 -98 607 -155 18 -8 67
-29 108 -46 169 -72 418 -228 568 -355 414 -349 694 -792 827 -1305 93 -358
99 -798 18 -1155 -27 -121 -83 -305 -113 -375 -102 -240 -153 -336 -268 -505
-339 -498 -858 -862 -1442 -1010 -367 -93 -798 -100 -1155 -18 -113 26 -331
91 -388 117 -18 8 -70 31 -117 52 -293 129 -586 343 -820 600 -309 337 -526
784 -606 1249 -52 295 -42 675 23 960 26 114 92 332 117 388 8 18 29 66 47
107 17 41 60 127 96 190 368 662 1020 1123 1758 1245 184 30 197 31 415 33
124 1 219 -4 325 -17z"
                  />
                  <path
                    d="M2445 4236 c-47 -20 -83 -69 -91 -123 -4 -26 -4 -491 0 -1033 6 -794
10 -991 21 -1015 30 -66 74 -95 145 -95 45 0 101 28 380 190 107 62 236 137
285 165 50 29 176 101 280 162 496 286 607 350 699 402 173 97 226 170 190
261 -27 66 -49 82 -489 335 -86 50 -340 198 -530 310 -467 275 -751 436 -785
445 -46 13 -69 12 -105 -4z"
                  />
                </g>
              </svg>
            </div>
            <video id="vd" class="dynTr goUnvisible" preload="metadata">
              <source :src="getTrailer" type="video/mp4" />
            </video>
            <img class="image dynTr" :src="getMovie.poster||''" alt />
            <div class="title">
              <span class="TextTitle">{{getMovie.name}}</span>
              <div class="onoffswitch">
                <input
                  type="checkbox"
                  name="onoffswitch"
                  class="onoffswitch-checkbox"
                  id="myonoffswitch"
                  @change="switchClicked()"
                  tabindex="0"
                />
                <label class="onoffswitch-label" for="myonoffswitch">
                  <span class="onoffswitch-inner"></span>
                  <span class="onoffswitch-switch"></span>
                </label>
              </div>
            </div>
            <div v-bind:class="'blackFade dynTr'"></div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="txtInfo">
            <span class="infoTitle">IMDB:</span>
            {{getMovie.imdb}}
          </div>
        </div>
        <div v-if="getMovie.movieType == 1" class="col-md-6">
          <div class="txtInfo">
            <span class="infoTitle">Süre:</span>
            {{getMovie.length}} Dk
          </div>
        </div>
        <div v-else class="col-md-6">
          <div class="txtInfo">
            <span class="infoTitle">Sezon Sayısı:</span>
            {{getAllSeason}} Sezon
          </div>
        </div>
        <div class="col-md-6">
          <div class="txtInfo">
            <span class="infoTitle">Yaş Sınırı:</span>
            {{getMovie.rate}}
          </div>
        </div>
        <div class="col-md-6">
          <div class="txtInfo">
            <span class="infoTitle">Film Türü:</span>
            <span v-for="(item,index) in getMovie.genres" :key="index">
              {{item.name}}
              <span v-if="getMovie.genres.length-1!=index">,</span>
            </span>
          </div>
        </div>
        <div class="col-md-6">
          <div class="txtInfo">
            <span class="infoTitle">Yıl:</span>
            {{getMovie.year}}
          </div>
        </div>
        <div class="col-md-6" v-show="playButtonAnimation()">
          <div class="txtInfo">
            <span class="infoTitle">Oyuncular:</span>
            <span v-for="(item,index) in getMovie.casts" :key="index">
              {{item.name}}
              <span v-if="getMovie.casts.length-1!=index">,</span>
            </span>
          </div>
        </div>
        <div class="col-md-6" style="font-weight: 500; margin-top: 10px; text-align: justify;">
          <div class="txtInfo">
            <span class="infoTitle">Hakkında:</span>
            <br />
            {{getMovie.description}}
          </div>
        </div>
      </div>
    </div>

    <div
      class="modal fade"
      @mouseenter="activeCarousel()"
      id="playModal"
      tabindex="-1"
      role="dialog" 
      aria-labelledby="playModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog" role="document" style="max-width: 90%; margin: 0 auto">
        <div class="modal-content">
          <div class="modal-body" style="background-color: #111; border-radius: 20px">
            <div class="row" style="height: 40vh">
              <div class="col-md" v-if="getMovie.movieType != 2 && getMovie.movieLink">
                <router-link :to="`/izle/td/${getMovie.id}/${getParName(getMovie.name)}`">
                  <playerbtn
                    imageSrc="https://cdn.webshopapp.com/shops/94414/files/54949672/turkey-flag-icon-free-download.jpg"
                    title="Türkçe Dublaj"
                  ></playerbtn>
                </router-link>
              </div>
              <div class="col-md" v-if="getMovie.movieType != 2 && getMovie.englishLink">
                <router-link :to="`/izle/ta/${getMovie.id}/${getParName(getMovie.name)}`">
                  <playerbtn
                    imageSrc="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/1200px-Flag_of_the_United_States.svg.png"
                    title="Türkçe Altyazı"
                  ></playerbtn>
                </router-link>
              </div>
              <div class="col-md" v-if="getMovie.movieType == 2" style="align-self: center">
                <div class="seasonBox">
                  <div class="containerBox">
                    <div class="seasonText">
                      <span id="seasonNumber">{{getCurrentSeason}}</span>. Sezon
                      <svg
                        style="float: right"
                        width="1em"
                        height="1.5em"
                        viewBox="0 0 16 16"
                        class="bi bi-caret-down-fill"
                        fill="currentColor"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          d="M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"
                        />
                      </svg>
                    </div>
                    <ul id="seasonList" v-if="getMovie.movieType == 2">
                      <li
                        v-for="(item, index) in getAllSeason"
                        :key="index"
                        @click="changeSeason(index+1)"
                      >{{index+1}}.Sezon</li>
                    </ul>
                  </div>
                </div>
                <div class="carouselBox">
                  <div class="carouselContainer">
                    <div
                      class="item"
                      v-for="(item, index) in getSeasonEpisodes"
                      :key="index"
                      :data-content="index+1"
                    >
                      <router-link :to="`/dizi/${item.id}/${getParName(getMovie.name)}-${getParName(item.name)}`">
                        <v-lazy-image
                          class="episodePoster"
                          height="150"
                          width="250"
                          src-placeholder="/assets/loader.gif"
                          :src="item.image"
                        />
                        <div class="epDes">{{item.summary}}</div>
                      </router-link>
                    </div>
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
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import api from "../Api";
import fun from "../Functions";
import VLazyImage from "v-lazy-image";
export default {
  data() {
    return {
      movie: null,
      isPlaying: false,
      carousel: null,
      scrollWidth: 0,
      allSeason: 5,
      currentSeason: 1,
    };
  },
  async created() {
    await this.fetchtMovie();
  },
  methods: {
    async fetchtMovie() {
      api.getMovie(this.$route.params.id).then((response) => {
        this.movie = response.data;
      });
    },
    switchClicked() {
      this.isPlaying = !this.isPlaying;
      document.querySelectorAll(".dynTr").forEach((e) => {
        this.isPlaying
          ? e.classList.add("goUnvisible")
          : e.classList.remove("goUnvisible");
      });
      this.isPlaying
        ? document.querySelector("#vd").classList.remove("goUnvisible")
        : document.querySelector("#vd").classList.add("goUnvisible");
      this.isPlaying ? this.playVideo() : this.pauseVideo();
    },
    playVideo() {
      document.querySelector("#vd").play();
      this.isPlaying = true;
    },
    pauseVideo() {
      document.querySelector("#vd").pause();
      this.isPlaying = false;
    },
    next() {
      this.carousel.scrollLeft += this.scrollWidth;
    },
    prev() {
      this.carousel.scrollLeft -= this.scrollWidth;
    },
    changeSeason(val) {
      this.currentSeason = val;
    },
    playButtonAnimation() {
      setTimeout(() => {
        var btn = document.querySelector(".playBtn");
        btn.style.fill = "#ddd";
        setTimeout(() => {
          btn.style.fill = "#111";
        }, 1000);
      }, 1000);
      return true;
    },
    showModal() {
      $("#playModal").modal("show");
    },
    activeCarousel() {
      if (this.getMovie.movieType == 2) {
        this.carousel = document.querySelector(".carouselContainer");
        var item = document.querySelector(".item");

        var visibileItemNum = Math.floor(
          this.carousel.offsetWidth / item.offsetWidth
        );
        this.scrollWidth = item.offsetWidth * visibileItemNum;
      }
    },
    getParName(val) {
      return fun.convertTurkish2English(val);
    },
  },
  computed: {
    getMovie() {
      if (this.movie != null && this.movie.movieType == 2) {
        this.allSeason = [
          ...new Set(this.movie.episodes.map((item) => item.season)),
        ].length;
      }
      return this.movie;
    },
    getTrailer(){
      return this.movie.trailerLink ? '/getMovie/'+ this.getMovie.trailerLink+"#t=5" : '/assets/sampleTrailer.mp4'
    },
    getCurrentSeason() {
      return this.currentSeason;
    },
    getAllSeason() {
      return this.allSeason;
    },
    getSeasonEpisodes() {
      return this.movie.episodes.filter(
        (item) => item.season == this.currentSeason
      );
    },
  },
  beforeRouteLeave(to, from, next) {
    $("#playModal").modal("hide");
    next();
  },
  components: {
    VLazyImage,
  },
};
</script>

<style scoped>
.containerBox {
  position: relative;
  width: 9rem;
  margin: 1rem 3rem;
  border: 1px solid white;
  background-color: #111;
}

.seasonText {
  padding: 5px 10px;
  color: white;
  font-weight: 500;
}

#seasonList {
  visibility: hidden;
  opacity: 0;
  transition: all 0.5s;
  position: absolute;
  z-index: -10;
  padding: 0;
  width: 9rem;
  left: -1px;
  margin-top: 1px;
  background-color: #111111d9;
}
.containerBox:hover #seasonList {
  visibility: visible;
  z-index: 6;
  opacity: 1;
}

#seasonList > li {
  color: white;
  padding: 10px 10px;
  cursor: pointer;
}
#seasonList > li:hover {
  background-color: #111111a3;
  text-decoration: underline;
}

.epDes {
  margin-top: 10px;
  text-align: left;
  color: white;
  font-size: 0.8rem;
}
.item::after {
  content: attr(data-content);
  display: block;
  position: absolute;
  margin-left: 5px;
  font-size: 1.5rem;
  top: 115px;
  color: rgb(231, 231, 231);
}

.item {
  height: 100%;
  position: relative;
  padding: 0 20px 0 0;
  flex-basis: 0;
}
.carouselContainer {
  display: flex;
  overflow: hidden;
  /*gap: 20px;*/
  margin: 0 3rem;
  position: relative;
  scroll-behavior: smooth;
}

.next {
  cursor: pointer;
  position: absolute;
  right: 5px;
  top: calc(50%);
  transform: translateY(-50%);
}

.prev {
  cursor: pointer;
  position: absolute;
  left: 5px;
  top: calc(50%);
  transform: translateY(-50%);
}

.modal-dialog {
  height: 100vh !important;
  display: flex;
}

.modal-content {
  background-color: transparent;
  margin: auto !important;
  height: fit-content !important;
}
.playBtn {
  transition: all 0.5s;
}
.playBtn:hover {
  fill: #ddd !important;
}
.infoTitle {
  color: #828282;
}
.title {
  position: absolute;
  bottom: 2%;
  left: 2%;
  z-index: 2;
}
.txtInfo {
  color: #ddd;
  font-size: 1.2rem;
  font-weight: 400;
  margin-bottom: 10px;
}
.TextTitle {
  font-size: 2.5rem;
  font-weight: bold;
  color: #ddd;
}
.poster {
  position: relative;
  height: 85vh;
  margin: 0 -15px;
}
.watchModal {
  cursor: pointer;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translateX(-50%) translateY(-50%);
}
#vd {
  width: 100%;
  height: 100%;
  object-fit: fill;
}
.image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: top;
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
}
.dynTr {
  transition: all 0.5s;
}
.goUnvisible {
  opacity: 0;
  visibility: hidden;
}

.blackFade {
  position: absolute;
  bottom: 0;
  z-index: 1;
  width: 100%;
  height: 20%;
  background-image: linear-gradient(
    180deg,
    transparent,
    rgba(37, 37, 37, 0.61),
    #111
  );
}

.wrapper {
  display: inline-block;
  width: 100%;
  position: relative;
}
.playpause {
  cursor: pointer;
  background-image: url(http://www.pngmart.com/files/3/Play-Button-Transparent-Background.png);
  background-repeat: no-repeat;
  width: 50%;
  height: 50%;
  position: absolute;
  left: 0%;
  right: 0%;
  top: 0%;
  bottom: 0%;
  margin: auto;
  background-size: contain;
  background-position: center;
}

/*Toggle Button*/

.onoffswitch {
  margin-left: 15px;
  display: inline-block;
  vertical-align: middle;
  position: relative;
  width: 113px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
}
.onoffswitch-checkbox {
  position: absolute;
  opacity: 0;
  pointer-events: none;
}
.onoffswitch-label {
  display: block;
  overflow: hidden;
  cursor: pointer;
  /*border: 2px solid #999999;*/
  border-radius: 20px;
}
.onoffswitch-inner {
  display: block;
  width: 200%;
  margin-left: -100%;
  transition: margin 0.3s ease-in 0s;
}
.onoffswitch-inner:before,
.onoffswitch-inner:after {
  display: block;
  float: left;
  width: 50%;
  height: 30px;
  padding: 0;
  line-height: 30px;
  font-size: 14px;
  color: white;
  font-family: Trebuchet, Arial, sans-serif;
  font-weight: bold;
  box-sizing: border-box;
}
.onoffswitch-inner:before {
  content: "Poster";
  padding-left: 10px;
  background-color: #111;
  color: #ffffff;
}
.onoffswitch-inner:after {
  content: "Fragman";
  padding-right: 10px;
  background-color: #eeeeee;
  color: #999999;
  text-align: right;
}
.onoffswitch-switch {
  display: block;
  width: 18px;
  margin: 6px;
  height: 18px;
  background: #ffffff;
  position: absolute;
  top: 0;
  bottom: 0;
  right: 79px;
  border: 2px solid #999999;
  border-radius: 20px;
  transition: all 0.3s ease-in 0s;
}
.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-inner {
  margin-left: 0;
}
.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-switch {
  right: 0px;
}
label {
  margin-bottom: 1rem;
}
</style>