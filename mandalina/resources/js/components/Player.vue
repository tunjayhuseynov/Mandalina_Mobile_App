<template>
  <div>
    <div class="backgroundBlack"></div>
    <video
      id="my_video_1"
      class="video-js vjs-default-skin"
      :data-setup="setup"
      controls
      preload="none"
    >
      <source :src="assetdomain + target" type="video/mp4" />
      <source :src="assetdomain + target" type="video/webm" />
    </video>
    <div id="backButton">
      <a @click="$router.push({ name: 'Home', hash: route})">
        <i class="fas fa-arrow-left"></i>
      </a>
    </div>
  </div>
</template>

<style scoped>
@import url("https://vjs.zencdn.net/7.6.6/video-js.css");
@import "/assets/css/player.css";
body {
  overflow: hidden!important;
}
</style>

<script>
export default {
  created() {
    $("body").css("overflow-y","hidden")
    
    fetch(this.domainlink + "/api/movie/"+this.link).then(res => {
      console.log(this.link)
      return res.json().then(e => {
            console.log(e.movieLink);
            this.target = e.movieLink;
      });
    });
  },
  data() {
    return {
      link: window.location.hash.split("movie=")[1],
      setup: '{ "aspectRatio":"16:8", "playbackRates": [1, 1.5, 2] }',
      target: null,
      route: window.location.hash.split("&movie=")[0].split("link=")[1]=="series"?"#series":"#"
    };
  },
  mounted() {
    var $refreshButton = $("#refresh");
    var $results = $("#css_result");

    function refresh() {
      var css = $("style.cp-pen-styles").text();
      $results.html(css);
    }

    refresh();
    $refreshButton.click(refresh);

    // Select all the contents when clicked
    $results.click(function() {
      $(this).select();
    });

    const plugin = document.createElement("script");
    plugin.setAttribute("src", "https://vjs.zencdn.net/7.6.6/video.js");
    plugin.async = true;
    document.head.appendChild(plugin);

    $("#my_video_1").ready(function() {
      $("#my_video_1")
        .on("pause", function() {
          if ($(".vjs-scrubbing")[0]) {
          } else {
            $(".backgroundBlack").fadeIn(1500);
            $(".vjs-big-play-button").fadeIn(1500);
            $("#backButton").stop();
          }
        })
        .on("play", function() {
          $(".vjs-big-play-button").fadeOut(500);
          $(".backgroundBlack").fadeOut(500);
          $(".vjs-big-play-button").fadeOut(500);
        });
    });
  }
};
</script>





