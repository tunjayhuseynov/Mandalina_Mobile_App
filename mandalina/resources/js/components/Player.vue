<template>
  <div v-if="getMovie!=null">
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
      <track v-if="this.$route.params.type == 'ta'" id="trackId" kind="subtitles" :src="getMovie.subtitleLink" srclang="en" label="English" default /> 
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
import api from "./Api";
import fun from "./Functions";

export default {
  async created() {
    $("body").css({"overflow-y": "hidden", "padding-right": "0"});
    if(document.querySelector(".modal-backdrop")!= null){
    document.querySelector(".modal-backdrop").remove()
    }
    await this.fetchtMovie();
  },
  data() {
    return {
      id: window.location.hash.split("movie=")[1],
      interval: null,
      setup: '{ "aspectRatio":"16:9", "playbackRates": [1, 1.5, 2] }',
      target: null,
      obj: null,
      movie: null,
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
      if (this.$route.params.type == "td") 
      return '/getMovie/'+this.getMovie.movieLink.split('/').pop();
      else if (this.$route.params.type == "ta")
      return '/getMovie/'+this.getMovie.englishLink.split('/').pop();
    },
    playerProgrammingDesign() {
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


      $("#my_video_1").ready(function () {
        $("#my_video_1")
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
      });

      return true;
    },
  },
  computed: {
    getMovie() {
      return this.movie;
    },
  },
  mounted() {},
  beforeDestroy(){
    document.body.style = "overflow-y: none"
    document.body.classList.remove("modal-open")
  }
};
</script>

<style>
@import url("https://vjs.zencdn.net/7.6.6/video-js.css");
@import "/assets/css/player.css";
.vjs-subs-caps-button  {
  display: none!important;
}

</style>