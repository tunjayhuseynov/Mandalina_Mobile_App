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
      <source :src="'//filmdizimob.com' + value.link" type="video/mp4" />
      <source :src="'//filmdizimob.com' + value.link" type="video/webm" />
    </video>
    <div id="backButton">
      <a @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </a>
    </div>
    <div class="aboutMovie">
      <ul>
        <li>
          <b>Film:</b>
          {{value.name}}
        </li>
        <li>
          <b>Çıkış Yılı:</b>
          {{value.year}}
        </li>
        <li>
          <b>Içerik Yaşı:</b>
          {{value.rate}}
        </li>
        <li>
          <b>Uzunluk:</b>
          {{value.length}} dakika
        </li>
      </ul>
    </div>
    <div class="desOnVideo">
      <p style="margin-bottom: 5px; text-align: center">
        <b>Açıklama:</b>
      </p>
      <p>{{value.desc}}</p>
    </div>
    <div class="posterinplayer">
      <img :src="value.poster" alt srcset height="500" />
    </div>
  </div>
</template>

<style scoped>
@import url("https://vjs.zencdn.net/7.6.6/video-js.css");
@import "/assets/css/player.css";
body {
  overflow: hidden;
}
</style>

<script>
export default {
  props: ["value"],
  data() {
    return {
      setup: '{ "aspectRatio":"16:8", "playbackRates": [1, 1.5, 2] }'
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
            $(".desOnVideo").fadeIn(1500);
            $(".aboutMovie").fadeIn(1500);
            $(".posterinplayer").fadeIn(1500);
            $(".backgroundBlack").fadeIn(1500);
            $(".vjs-big-play-button").fadeIn(1500);
            $("#backButton").stop()
          }
        })
        .on("play", function() {
          $(".vjs-big-play-button").fadeOut(500);
          $(".desOnVideo").fadeOut(500);
          $(".aboutMovie").fadeOut(500);
          $(".posterinplayer").fadeOut(500);
          $(".backgroundBlack").fadeOut(500);
          $(".vjs-big-play-button").fadeOut(500);
        });
    });
  }
};
</script>



