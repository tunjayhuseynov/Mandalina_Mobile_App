

Vue.component('moviebox', {
  props: ['moviename', 'movieposter'],
    template: `
    <div class="custom-box-div">
    <img :src="movieposter" height="250"
        alt="batman movie">
    <div class="playButton">
        <i class="far fa-play-circle playFont"></i>
    </div>
    <div class="boxMovieName">
        <h5>{{moviename}}</h5>
    </div>
</div>`
  })

