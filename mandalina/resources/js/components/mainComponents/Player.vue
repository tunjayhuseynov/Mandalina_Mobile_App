<template>
  <div v-if="getMovie!=null" style="height:100vh">
    <div class="backgroundBlack"></div>
    <video
      id="my_video_1"
      class="video-js vjs-default-skin"
      :data-setup="setup"
      controls
      preload="metadata"
    >
      <source :src="getKind()" type="video/mp4" />
      <source :src="getKind()" type="video/webm" />
      <track
        v-if="this.$route.params.type == 'ta'"
        id="trackId"
        kind="subtitles"
        :src="getMovie.subtitleLink"
        srclang="tr"
        label="Türkce"
        default
      />
        <track
        v-if="this.$route.params.type == 'ta' && this.getMovie.enSubtitleLink"
        id="trackIden"
        kind="subtitles"
        :src="getMovie.enSubtitleLink"
        srclang="en"
        label="Ingilizce"
      />
    </video>
    <div id="backButton" v-show="playerProgrammingDesign()">
      <a
        @click="$router.push({ name: 'MovieInfo', params: {id: `${$route.params.id}`, moviename: `${getParName($route.params.movieName)}`}})"
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
    $("body").css({ "overflow-y": "hidden", "padding-right": "0" });
    if (document.querySelector(".modal-backdrop") != null) {
      document.querySelector(".modal-backdrop").remove();
    }
    await this.fetchtMovie();
  },
  data() {
    return {
      id: window.location.hash.split("movie=")[1],
      interval: null,
      setup:
        '{ "aspectRatio":"16:9", "playbackRates": [0.5, 1, 1.5, 2],"responsive": true }',
      target: null,
      obj: null,
      movie: null,
      timeCut: 5,
    };
  },
  methods: {
    async fetchtMovie() {
      api.getMovie(this.$route.params.id).then((response) => {
        this.movie = response.data;
      });
    },
    getParName(val) {
      return fun.convertTurkish2English(val);
    },
    getKind() {
      if (this.$route.params.type == "td") {
        return "/getMovie/" + this.getMovie.movieLink.split("/").pop();
      } else if (this.$route.params.type == "ta") {
        return "/getMovie/" + this.getMovie.englishLink.split("/").pop();
      }
    },
    checkEnglishSubtitle(){
        document.querySelector(".vjs-subs-caps-button").style.display = "block!important"
        return true
    },
    videoPlayerArrow() {
      var t = this
      var video = document.getElementsByTagName("video")[0];
      window.addEventListener("keydown", function (evt) {
        console.log(evt)
        if (evt.keyCode === 37) {
          video.currentTime = Math.max(0, video.currentTime - t.timeCut);
        } else if (evt.keyCode === 39) {
          video.currentTime = Math.min(
            video.duration,
            video.currentTime + t.timeCut
          );
        } else if(evt.keyCode === 13 || evt.keyCode === 32){
          video.paused?video.play():video.pause()
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

      const plugin = document.createElement("script");
      plugin.setAttribute("src", "https://vjs.zencdn.net/7.6.6/video.js");
      plugin.async = true;
      document.head.appendChild(plugin);

      $("video").ready(function () {
        $("video")
          .on("pause", function () {
            if ($(".vjs-scrubbing")[0]) {
            } else {
              $(".backgroundBlack, .vjs-big-play-button").fadeIn(500);
              $("#backButton").stop();
            }
          })
          .on("play", function () {
            $(".vjs-big-play-button, .backgroundBlack").fadeOut(500);
          });
        t.videoPlayerArrow();
      });

      return true;
    },
  },
  computed: {
    getMovie() {
      return this.movie;
    },
  },
  beforeDestroy() {
    document.body.style = "overflow-y: none";
    document.body.classList.remove("modal-open");
  },
};
</script>

<style>
@import url("https://vjs.zencdn.net/7.6.6/video-js.css");
@import "/assets/css/player.css";
.vjs-texttrack-settings{
  display: none!important;
}
</style>