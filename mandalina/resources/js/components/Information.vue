<template>
  <div id="info">
    <div class="container-fluid fill">
      <div class="row fill">
        <div class="col-2" style>
          <img :src="domain+json.image" height="300" width="200" style="margin-top:17px;" alt />
          <div class="playButton">
            <router-link :to="{ name: 'Player', params: {id: json.id, link: filmType} }">
              <i class="far fa-play-circle playFont"></i>
            </router-link>
          </div>
        </div>
        <div class="col-5">
          <ul style="padding-left: 0; margin-top: 25px; float: left" class="liStyle">
            <li>Film: {{json.name}}</li>
            <li>Yıl: {{json.year}}</li>
            <li>Yaş Sınırı: {{json.rate}}</li>
            <li v-if="filmType=='movies'">Süre: {{json.length}}dk</li>
            <li>
              Tür:
              <div v-for="(array, index, ind) in json.genres" :key="ind" style="display:inline;">
                {{json.genres[index].name}}
                <span
                  v-show="index != Object.keys(json.genres).length - 1"
                >,</span>
              </div>
            </li>
            <li
              style="font-size: 13px; margin-top: 10px; text-overflow: ellipsis; overflow: hidden; height: 150px;"
            >{{json.description}}</li>
          </ul>
        </div>
        <div class="col-5" style="padding-right: 7px">
          <div class="bef">
            <video
              v-if="videoActive == true"
              :class="videoId"
              @mouseover="play"
              @mouseleave="pause"
              style="width: 100%; height: 100%; margin-right: -15px; object-fit: cover;"
              preload="none"
            >
              <source src="/assets/sampleTrailer.mp4" type="video/mp4" />
            </video>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.bef {
  width: 100%;
  height: 336px;
}
.bef::before {
  content: "";
  position: absolute;
  width: 15px;
  height: 336px;
  background: linear-gradient(90deg, rgba(29,29,29,1) 0%, rgba(29,29,29,0.5) 50%, rgba(29,29,29,0) 100%);
}
</style>

<script>
export default {
  props: ["json", "domain", "filmType", "id", "videoActive"],
  data() {
    return {
      videoId: "video-" + this.id,
    };
  },
  methods:{
    play(e){
      $(e.target).get(0).play()
    },
    pause(e){
      $(e.target).get(0).pause()
    }
  },
  mounted() {

  }
};
</script>

<style>
#info {
  background-color: #1d1d1d;
  height: 336px;
  width: 100%;
  display: none;
}
</style>