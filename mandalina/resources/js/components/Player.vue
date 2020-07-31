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
  overflow: hidden !important;
}
</style>

<script>
export default {
  created() {
    $("body").css("overflow-y", "hidden");

    if (
      window.location.hash.split("&movie=")[0].split("link=")[1] == "series"
    ) {
      fetch(this.domainlink + "/api/serie/" + this.id).then(res => {
        return res.json().then(e => {
          console.log(e.url);
          this.target = e.url;
          fetch(this.domainlink + "/api/movie/" + e.movieID).then(res => {
            return res.json().then(e => {
              this.addMovieToDb(e, "watchedSerie");
            });
          });

          this.obj = e;
        });
      });
    } else {
      fetch(this.domainlink + "/api/movie/" + this.id).then(res => {
        return res.json().then(e => {
          this.target = e.movieLink;
          this.addMovieToDb(e, "watchedMovie");
          this.obj = e;
        });
      });
    }
  },
  data() {
    return {
      id: window.location.hash.split("movie=")[1],
      interval: null,
      setup: '{ "aspectRatio":"16:8", "playbackRates": [1, 1.5, 2] }',
      target: null,
      obj: null,
      route:
        window.location.hash.split("&movie=")[0].split("link=")[1] == "series"
          ? "#series"
          : "#"
    };
  },
  methods: {
    getMoviefromDb(id, type) {
      var episodeId = this.id
      let openRequest = indexedDB.open("movies", 1);
      openRequest.onsuccess = () => {
        let db = openRequest.result;
        var objectStore = db
          .transaction([type], "readonly")
          .objectStore(type);
        var request = objectStore.get(id);
        request.onerror = function(event) {
          console.log(event);
        };
        request.onsuccess = function(event) {
          // Get the old value that we want to update
          var data = event.target.result;
          if(type == "watchedSerie"){
            data = data.episodes.find(x=> x.id == episodeId);
          }
          console.log("Data: " + data.stoppedTime);
          if (data.stoppedTime != null) {
            document.getElementById("my_video_1_html5_api").currentTime =
              data.stoppedTime;
          }
        };
      };
    },
    deteleMovieFromDB(id, type) {
      let openRequest = indexedDB.open("movies", 1);
      openRequest.onsuccess = () => {
        var request = db
          .transaction([type], "readwrite")
          .objectStore(type)
          .delete(id);
        request.onsuccess = function(event) {
          console.log("Deleted!");
        };
      };
    },
    updateMovieFromDb(id, time, type) {
      var episodeId = this.id
      let openRequest = indexedDB.open("movies", 1);
      openRequest.onsuccess = () => {
        let db = openRequest.result;
        var objectStore = db.transaction([type], "readwrite").objectStore(type);
        var request = objectStore.get(id);
        request.onerror = function(event) {
          // Handle errors!
        };
        request.onsuccess = function(event) {
          // Get the old value that we want to update
          var data = event.target.result;

          // update the value(s) in the object that you want to change
          if (type == "watchedMovie") {
            data.stoppedTime = time;
          } else {
            data.episodes.find(x => x.id == episodeId).stoppedTime = time
          }
          // Put this updated object back into the database.
          var requestUpdate = objectStore.put(data);
          requestUpdate.onerror = function(event) {
            // Do something with the error
          };
          requestUpdate.onsuccess = function(event) {
            // Success - the data is updated!
          };
        };
      };
    }
  },
  destroyed() {
    clearInterval(this.interval);
  },
  mounted() {
    var isPlayed = false;

    document.getElementById("my_video_1").addEventListener("play", () => {
      if (!isPlayed) {
        var obj = this.obj;
        var length = this.route.includes("series")
          ? parseInt(obj.airtime)
          : obj.length;
        var route = this.route;
        var deteleMovieFromDB = this.deteleMovieFromDB;
        var updateMovieFromDb = this.updateMovieFromDb;
        isPlayed = true;

        function Timer() {
          if (
            (Math.floor(
              document.getElementById("my_video_1_html5_api").currentTime
            ) /
              (length * 60)) *
              100 <
            97
          ) {
            updateMovieFromDb(
              route.includes("series")?obj.movieID:obj.id,
              Math.floor(
                document.getElementById("my_video_1_html5_api").currentTime
              ),
              route.includes("series") ? "watchedSerie" : "watchedMovie"
            );
          } else {
            deteleMovieFromDB(
              obj.id,
              route.includes("series") ? "watchedSerie" : "watchedMovie"
            );
          }
        }
        this.interval = setInterval(() => {
          Timer();
        }, 2000);
      }
    });

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





