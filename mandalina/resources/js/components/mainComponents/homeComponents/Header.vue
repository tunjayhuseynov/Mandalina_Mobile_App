<template>
  <div v-if="getData!=null" class="headerBar" @mouseover="playVideo" @mouseleave="pauseVideo">
    <div class="movieTitle">
      <div class="titleBox">
        <h1 class="Title">{{getData.name}}</h1>
      </div>
      <div class="btns">
        <router-link :to="`/about/${getData.id}/${getParName(getData.name)}`">
          <button class="watchBtn">
            <svg
              class="header__container-btnMyList-play"
              width="1rem"
              height="1rem"
              fill="white"
              version="1.1"
              id="Capa_1"
              x="0px"
              y="0px"
              viewBox="0 0 41.999 41.999"
              xml:space="preserve"
            >
              <path
                d="M36.068,20.176l-29-20C6.761-0.035,6.363-0.057,6.035,0.114C5.706,0.287,5.5,0.627,5.5,0.999v40
	            c0,0.372,0.206,0.713,0.535,0.886c0.146,0.076,0.306,0.114,0.465,0.114c0.199,0,0.397-0.06,0.568-0.177l29-20
	             c0.271-0.187,0.432-0.494,0.432-0.823S36.338,20.363,36.068,20.176z"
              />
            </svg>

            <span class="btnText">Izle</span>
          </button>
        </router-link>
      </div>
      <div class="about">
        <span class="aboutText">{{getData.description}}</span>
      </div>
    </div>
    <div class="trailer">
      <video id="vd" preload="metadata" muted>
        <source :src="getTrailer" type="video/mp4" />
      </video>
      <img class="poster" :src="getData.poster" alt srcset />
      <div v-show="isPlaying" class="soundOnOf" @click="soundOnOf">
        <svg
          v-show="!isMuted"
          width="3em"
          height="3em"
          viewBox="0 0 16 16"
          class="bi bi-volume-up-fill"
          fill="white"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M11.536 14.01A8.473 8.473 0 0 0 14.026 8a8.473 8.473 0 0 0-2.49-6.01l-.708.707A7.476 7.476 0 0 1 13.025 8c0 2.071-.84 3.946-2.197 5.303l.708.707z"
          />
          <path
            d="M10.121 12.596A6.48 6.48 0 0 0 12.025 8a6.48 6.48 0 0 0-1.904-4.596l-.707.707A5.483 5.483 0 0 1 11.025 8a5.483 5.483 0 0 1-1.61 3.89l.706.706z"
          />
          <path
            d="M8.707 11.182A4.486 4.486 0 0 0 10.025 8a4.486 4.486 0 0 0-1.318-3.182L8 5.525A3.489 3.489 0 0 1 9.025 8 3.49 3.49 0 0 1 8 10.475l.707.707z"
          />
          <path
            fill-rule="evenodd"
            d="M6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06z"
          />
        </svg>
        <svg
          v-show="isMuted"
          width="3em"
          height="3em"
          viewBox="0 0 16 16"
          class="bi bi-volume-mute-fill"
          fill="white"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            fill-rule="evenodd"
            d="M6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06zm7.137 2.096a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708l4-4a.5.5 0 0 1 .708 0z"
          />
          <path
            fill-rule="evenodd"
            d="M9.146 5.646a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0z"
          />
        </svg>
      </div>
    </div>
    <div v-bind:class="[!isPlaying?'blackFade':'blackFade opocityZero']"></div>
  </div>
</template>

<script>
import fun from "../../Functions";
export default {
  created() {},
  data: function () {
    return {
      isMuted: true,
      isPlaying: false,
    };
  },
  methods: {
    playVideo() {
      document.querySelector("#vd").play();
      this.isPlaying = true;
    },
    pauseVideo() {
      document.querySelector("#vd").pause();
      this.isPlaying = false;
    },
    soundOnOf() {
      document.querySelector("#vd").muted = !document.querySelector("#vd")
        .muted;
      this.isMuted = !this.isMuted;
    },
    getParName(val) {
      return fun.convertTurkish2English(val);
    },
  },
  computed: {
    getTrailer(){
      return this.getData.trailerLink ? '/getMovie/'+ this.getData.trailerLink+"#t=5" : '/assets/sampleTrailer.mp4'
    },
    getData() {
      return this.$route.name == "Movies" || this.$route.name == undefined
        ? this.$store.state.movieSuggested
        : this.$store.state.serieSuggested;
    },
  },
};
</script>

<style scoped>
#vd {
  background: transparent url("/assets/loader.gif") no-repeat center center;
}
.blackFade {
  position: absolute;
  bottom: 0;
  z-index: 20;
  width: 100%;
  height: 25%;
  background-image: linear-gradient(
    180deg,
    transparent,
    rgba(37, 37, 37, 0.61),
    #111
  );
  opacity: 1;
  transition: all 0.5s;
}
.opocityZero {
  opacity: 0;
}
.headerBar {
  position: relative;
  height: 88vh;
  background-color: transparent;
}
.movieTitle {
  position: absolute;
  z-index: 5;
  top: 33%;
  left: 3.8%;
  width: 50%;
}
.Title {
  font-size: 4rem;
  font-weight: bold;
  color: white;
}
.watchBtn {
  padding: 0.5rem 3rem;
  border-radius: 0.2vw;
  border: none;
  outline: none;
  background-color: rgba(51, 51, 51, 0.5);
}
.watchBtn:hover {
  background-color: #e6e6e6;
  color: black;
}
.watchBtn:hover .btnText {
  color: black;
}
.watchBtn:hover svg {
  fill: black;
}

.btnText {
  color: white;
  font-weight: 700;
  font-size: 1rem;
  font-family: "Hind", sans-serif;
}

.about {
  margin-top: 20px;
}
.aboutText {
  display: inline-block;
  white-space: normal;
  color: white;
  overflow: hidden;
  height: 120px;
}
.trailer {
  position: relative;
  width: 100%;
  height: 100%;
}
.trailer video {
  width: 100%;
  height: 100%;
  object-fit: fill;
}

.poster {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: all 0.5s;
}

.headerBar:hover .poster {
  opacity: 0;
  visibility: hidden;
}
.soundOnOf {
  position: absolute;
  right: 2%;
  top: 15%;
  cursor: pointer;
  transition: all 0.5s;
}
</style>