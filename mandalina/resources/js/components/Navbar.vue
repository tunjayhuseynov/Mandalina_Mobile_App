<template>
  <nav class="navBar">
    <div class="container-fluid" style="padding-top: 8px;">
      <div class="row">
        <div class="col-lg-4">
          <div class="sample seven">
            <input type="text" v-on:input="onChange" name="search" placeholder="Arama..." />
            <button type="submit" class="btn btn-search" style="border-radius:0;">
              <i class="fa fa-search" style="color: white"></i>
            </button>
          </div>
        </div>
        <div class="col-lg-4">
          <h3 style="text-align: center;">
            <a
              href="/"
              
            ><img src="/assets/logoless.png" width="250" height="30" alt="" srcset=""></a>
          </h3>
        </div>
        <div class="col-lg-4">
          <div class="rightNavbar">
            <ul>
              <li class="movieBar" style="position: relative">
                <a href="/" style="color:white;">Filmler</a>
                <div class="posNav">
                  <ul class="subMoveGenre">
                    <li class="movies" v-for="(array, index, name) in genres" :key="name" v-on:click="onClick">{{genres[index].name}}</li>
                  </ul>
                </div>
              </li>
              <li class="movieBar" style="position: relative"><a onclick="window.location.hash = '#series'; window.location.reload()" class="hoverAdd" style="color:white;">Diziler</a>
                 <div class="posNav">
                  <ul class="subMoveGenre">
                    <li class="series" v-for="(array, index, name) in genres" :key="name" v-on:click="onClick">{{genres[index].name}}</li>
                  </ul>
                </div> 
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>


<script>
export default {
  props: ["genres"],
  methods: {
    onClick(e) {
      this.$emit("clicked", $(e.target).html(), $(e.target).attr('class'));
    },
    onChange(v) {
      this.$emit("changed", document.getElementsByName("search")[0].value);
    }
  }
};
</script>


<style scoped>
input {
  border: 0px solid #ccc;
  font-size: 12px;
  height: 30px;
  padding: 4px 8px;
  position: absolute;
  width: 50%;
}
input:focus {
  outline: none;
}

button {
  text-align: center;
}
button:focus {
  outline: none;
}
button.btn-search,
button.btn-reset {
  background: #ead044;
  border: none;
  height: 30px;
  font-size: 12px;
  padding: 4px;
  position: absolute;
  width: 30px;
}

.sample {
  float: left;
  height: 50px;
  margin: 5px 0 0 28px;
  position: relative;
  width: 34%;
}

.sample.seven input,
.sample.eight input {
  border-right: none;
  transition: all 0.3s ease-in;
  width: 120px;
}
.sample.seven input:focus,
.sample.eight input:focus {
  width: 220px;
}
.sample.seven input:focus ~ button.btn-search,
.sample.eight input:focus ~ button.btn-search {
  background: #ead044;
  border-radius: 0 50% 50% 0;
  color: #fff;
  left: 220px;
}
.sample.seven input:focus ~ button.btn-reset,
.sample.eight input:focus ~ button.btn-reset {
  animation: bounceRight 0.6s;
  animation-delay: 0.2s;
  animation-timing-function: cubic-bezier(0.3, 0.2, 1, 0.8);
  border-radius: 50%;
  color: #fff;
  left: 254px;
}
.sample.seven button.btn-search,
.sample.eight button.btn-search {
  background: #292626;
  left: 120px;
  transition: all 0.3s ease-in;
}
.sample.seven button.btn-reset,
.sample.eight button.btn-reset {
  background: #000;
  height: 20px;
  left: 120px;
  top: 5px;
  transition: all 0.3s ease-in;
  width: 20px;
  z-index: -1;
}

@keyframes bounceRight {
  0% {
    transform: translateX(0px);
  }
  50% {
    transform: translateX(10px);
  }
  100% {
    transform: translateX(0px);
  }
}
</style>