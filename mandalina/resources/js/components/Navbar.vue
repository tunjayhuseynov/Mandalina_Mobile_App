<template>
  <div class="navBar container-fluid">
    <div class="row align-items-center">
      <div class="col-12 col-md-2">
        <div class="customDiv1">
          <router-link to="/movie">
            <img
              src="http://netflix-react-clone.surge.sh/8562b6565f5ae1db5e4af40d85b4ed2d.png"
              height="75"
            />
          </router-link>
        </div>
      </div>
      <div class="col-8 col-md-7">
        <div class="customDiv">
          <ul>
            <li><router-link class="routeFont" to="/movie">Filmler</router-link></li>
            <li>
              <router-link class="routeFont" to="/tvshows">Diziler</router-link>
            </li>
            <li>Iletisim</li>
          </ul>
        </div>
      </div>
      <div class="col-4 col-md-3">
        <div class="customDiv">
          <div class="searchInput">
            <svg
              class="logo loopIcon"
              width="1rem"
              height="1rem"
              viewBox="0 0 251 251"
              version="1.1"
            >
              <title>Search Bar</title>
              <desc>FilmDiziMob</desc>
              <defs />
              <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                <g id="musica-searcher" fill="#FFFFFF" fill-rule="nonzero">
                  <path
                    d="M244.186,214.604 L189.807,160.226 C189.518,159.937 189.179,159.735 188.877,159.466 C199.577,143.235 205.822,123.806 205.822,102.912 C205.822,46.075 159.747,0 102.911,0 C46.075,0 0,46.075 0,102.911 C0,159.746 46.074,205.822 102.91,205.822 C123.805,205.822 143.233,199.577 159.464,188.877 C159.733,189.178 159.934,189.517 160.223,189.806 L214.603,244.186 C222.772,252.354 236.016,252.354 244.186,244.186 C252.354,236.017 252.354,222.773 244.186,214.604 Z M102.911,170.146 C65.777,170.146 35.675,140.044 35.675,102.911 C35.675,65.777 65.778,35.675 102.911,35.675 C140.043,35.675 170.146,65.778 170.146,102.911 C170.146,140.044 140.043,170.146 102.911,170.146 Z"
                    id="Shape"
                  />
                </g>
              </g>
            </svg>
            <input tabindex="1" type="text" class="searchBox" placeholder="Film ve Dizi Ara..." />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  mounted() {
    window.addEventListener("scroll", this.onScroll);
  },
  beforeDestroy() {
    window.removeEventListener("scroll", this.onScroll);
  },
  methods: {
    onScroll() {
      const currentScrollPosition =
        window.pageYOffset || document.documentElement.scrollTop;
      if (currentScrollPosition < 0) {
        return;
      } else if (currentScrollPosition > 0) {
        document.querySelector(".navBar").classList.add("hideTransparent");
      } else {
        document.querySelector(".navBar").classList.remove("hideTransparent");
      }
    },
  },
};
</script>

<style scoped>
.routeFont {
  font-size: 1rem;
  font-weight: 500;
  color: #ddd;
}
.routeFont:hover {
  color: #a7a7a7;
  text-decoration: none;
}
ul {
  margin: 0;
  padding: 0;
}
ul li {
  display: inline;
  font-size: 1rem;
  color: #ddd;
  margin-right: 2rem;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.2s;
}
ul li:hover {
  color: #a7a7a7;
}
img {
  width: 75%;
}
.customDiv1 {
  text-align: center;
}

.navBar {
  position: fixed;
  width: 100%;
  height: 75px;
  background-color: transparent;
  transition: all 0.5s;
  z-index: 100;
}

.searchBox {
  width: 0%;
  padding: 0;
  margin: 0;
  border: 0;
  background-color: #111;
  transition: all 0.5s;
  float: right;
  height: 35px;
  color: white;
}

.hideTransparent {
  background-color: #111;
}

.searchBox:focus {
  width: 18rem;
  padding: 0 0 0 5px;
  border: 2px solid white;
  background-color: black;
}

.searchBox:hover {
  width: 18rem;
  padding: 0 0 0 5px;
  border: 2px solid white;
  background-color: black;
}

.loopIcon:hover + .searchBox {
  width: 18rem;
  padding: 0 0 0 5px;
  border: 2px solid white;
  background-color: black;
}

.searchInput {
  float: right;
  position: relative;
}

.loopIcon {
  cursor: pointer;
  position: absolute;
  right: 8px;
  top: 8px;
}
</style>