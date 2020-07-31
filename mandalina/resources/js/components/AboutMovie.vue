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
            <div class="watchModal">
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
            <img class="image" :src="getMovie.poster||''" alt />
            <div class="title">
              <span class="TextTitle">{{getMovie.name}}</span>
            </div>
            <div v-bind:class="'blackFade'"></div>
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
            <span class="infoTitle">Bölüm Sayı:</span>
            {{getMovie.episodes.length}} Bölüm
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
        <div class="col-md-6">
          <div class="txtInfo">
            <span class="infoTitle">Oyuncular:</span>
            <span v-for="(item,index) in getMovie.casts" :key="index">
              {{item.name}}
              <span v-if="getMovie.genres.length-1!=index">,</span>
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
        <!-- <div class="col-md-6">
          <div class="wrapper" @click="clickTrailer">
            <video class="video">
              <source src="/assets/sampleTrailer.mp4" type="video/mp4" />
            </video>
            <div class="playpause"></div>
          </div>
        </div>-->
      </div>
    </div>
  </div>
</template>

<script>
import api from "./Api";

export default {
  data() {
    return {
      movie: null,
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
    clickTrailer() {
      if ($(".video").get(0).paused) {
        $(".video").get(0).play();
        $(".playpause").fadeOut();
      } else {
        $(".video").get(0).pause();
        $(".playpause").fadeIn();
      }
    },
    playButtonAnimation() {
      setTimeout(() => {
        var btn = document.querySelector(".playBtn");
        btn.style.fill = "#ddd";
        setTimeout(() => {
          btn.style.fill = "#111";
        }, 1000);
      }, 1000);
      return true
    },
  },
  computed: {
    getMovie() {
      this.playButtonAnimation()
      return this.movie;
    },
  },
};
</script>

<style scoped>
.playBtn {
  transition: all 0.5s;
}
.playBtn:hover {
  fill: #ddd!important;
  
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
  font-weight: 600;
  margin-bottom: 10px;
}
.TextTitle {
  font-size: 2.5rem;
  font-weight: bold;
  color: #ddd;
}
.poster {
  position: relative;
  height: 80vh;
  margin: 0 -15px;
}
.watchModal {
  cursor: pointer;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translateX(-50%) translateY(-50%);
}
.image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
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
  opacity: 1;
  transition: all 0.5s;
}

.video {
  width: 100%;
  border: 1px solid black;
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
</style>