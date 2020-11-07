<template>
  <div v-if="getMovie!=null" style="height:100vh; width: 100vw" :key="index">
    <div class="backgroundBlack"></div>
    <video id="my_video_1" class="video-js vjs-default-skin" controls preload="metadata">
      <source :src="getKind()" type="video/mp4" />
      <source :src="getKind()" type="video/webm" />
      <track
        v-if="this.$route.params.type == 'turkce-altyazi' && this.getMovie.subtitleLink"
        id="trackId"
        kind="subtitles"
        :src="getMovie.subtitleLink"
        srclang="tr"
        label="Türkce"
        default
      />
      <track
        v-if="this.$route.params.type == 'turkce-altyazi' && this.getMovie.enSubtitleLink"
        id="trackIden"
        kind="subtitles"
        :src="getMovie.enSubtitleLink"
        srclang="en"
        label="Ingilizce"
      />
    </video>
    <div id="backButton" v-show="playerProgrammingDesign()">
      <a
        @click="$router.push({ name: 'MovieInfo', params: {id: `${checkIfSerie()?getMovie.movieID:$route.params.id}`, moviename: `${getParName(checkIfSerie()?getMovie.showName:$route.params.movieName)}`}})"
      >
        <i class="fas fa-arrow-left"></i>
      </a>
    </div>
  </div>
</template>


<script>
import api from "../Api";
import fun from "../Functions";

export default {
  async created() {
    if (document.querySelector(".modal-backdrop") != null) {
      document.querySelector(".modal-backdrop").remove();
    }

    await this.fetchtMovie();
  },
  updated() {
    if(this.movie == null) return
    this.video = videojs("my_video_1", {
      aspectRatio: "16:9",
      playbackRates: [0.5, 1, 1.5, 2],
      responsive: true,
    });
    this.video.on("pause", () => {
      if (!$(".vjs-scrubbing")[0]) {
        $(".backgroundBlack, .vjs-big-play-button").fadeIn(500);
        $("#backButton").stop();
      }
    });
    this.video.on("play", () => {
      $(".vjs-big-play-button, .backgroundBlack").fadeOut(500);
    });
    this.video.on("volumechange", () => {
      if (this.leaveFun) clearTimeout(this.leaveFun);
      document.querySelector(".vjs-volume-panel").classList.add("vjs-hover");
      this.leaveFun = setTimeout(() => {
        document
          .querySelector(".vjs-volume-panel")
          .classList.remove("vjs-hover");
      }, 2000);
    });
    this.videoPlayerArrow();
    if (this.checkIfSerie() && this.movie.nextEpisode != null) this.createNextEpisodeBtn();
  },
  data() {
    return {
      video: null,
      movie: null,
      timeCut: 5,
      leaveFun: null,
      index: 0,
    };
  },
  methods: {
    async fetchtMovie() {
      if (this.checkIfSerie()) {
        api.getSerie(this.$route.params.id).then((response) => {
          this.movie = response.data;
        });
      } else {
        api.getMovie(this.$route.params.id).then((response) => {
          this.movie = response.data;
        });
      }
    },
    getParName(val) {
      return fun.convertTurkish2English(val);
    },
    getKind() {
      if (this.$route.params.type == "turkce-dublaj") {
        return "/getMovie/" + this.getMovie.movieLink.split("/").pop();
      } else if (this.$route.params.type == "turkce-altyazi") {
        return "/getMovie/" + this.getMovie.englishLink.split("/").pop();
      } else if (this.$route.params.type == "dizi") {
        return "/getMovie/" + this.getMovie.url.split("/").pop();
      }
    },
    checkEnglishSubtitle() {
      document.querySelector(".vjs-subs-caps-button").style.display =
        "block!important";
      return true;
    },
    videoPlayerArrow() {
      var t = this;
      var video = document.getElementsByTagName("video")[0];
      window.addEventListener("keydown", function (evt) {
        if (evt.keyCode === 37) {
          video.currentTime = Math.max(0, video.currentTime - t.timeCut);
        } else if (evt.keyCode === 39) {
          video.currentTime = Math.min(
            video.duration,
            video.currentTime + t.timeCut
          );
        } else if (evt.keyCode === 13 || evt.keyCode === 32) {
          video.paused ? video.play() : video.pause();
        } else if (evt.keyCode === 38) {
          video.volume = Math.min(1, (video.volume += 0.1));
        } else if (evt.keyCode === 40) {
          video.volume = Math.max(0, (video.volume -= 0.1));
        }
      });
    },
    playerProgrammingDesign() {
      var t = this;
      var $refreshButton = $("#refresh");
      var $results = $("#css_result");

      function refresh() {
        var css = $("style.cp-pen-styles").text();
        $results.html(css);
      }

      refresh();
      $refreshButton.click(refresh);

      // Select all the contents when clicked
      $results.click(function () {
        $(this).select();
      });

      return true;
    },
    createNextEpisodeBtn() {
      var t = this;
      var Button = videojs.getComponent("Button");

      var MyButton = videojs.extend(Button, {
        constructor: function () {
          Button.apply(this, arguments);
        },
        handleClick: function () {
          t.$router.replace({
            name: "Player",
            params: {
              type: "dizi",
              id: t.movie.nextEpisode.id,
              movieName: `${t.getParName(t.movie.showName)}-${t.getParName(
                t.movie.nextEpisode.name
              )}`,
            },
          });
        },
      });
      videojs.registerComponent("NextBtn", MyButton);

      let controlBar = this.video.getChild("controlBar");
      let addedBtn = controlBar.addChild(
        "NextBtn",
        {},
        controlBar.children().length - 3
      );
      let spanBtn = addedBtn.el_
        .querySelectorAll("span")[0]
        .classList.add("vjs-icon-next-item");
    },
    getParName(val) {
      return fun.convertTurkish2English(val);
    },
    checkIfSerie() {
      return this.$route.params.type == "dizi";
    },
  },
  computed: {
    getMovie() {
      return this.movie;
    },
  },
  beforeRouteLeave(to, from, next) {
    this.video.dispose();
    next();
  },
  destroyed() {
    this.video.dispose();
  },
  watch: {
    "$route.path": {
      handler: async function (val, oldVal) {
        this.video.dispose()
        this.movie = null
        await this.fetchtMovie();
        this.index++
      },
    },
  },
};
</script>

<style scoped>
@import url("https://vjs.zencdn.net/7.6.6/video-js.css");
@import "/assets/css/player.css";
.vjs-texttrack-settings {
  display: none !important;
}
video {
  height: 100vh !important;
}
.my_video_1-dimensions.vjs-fluid {
  padding-top: 0 !important;
}



@media only screen and (max-width: 768px) {
.video-js .vjs-control-bar:hover .vjs-progress-control{
  opacity: 1!important;
}
}
</style>