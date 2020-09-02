<template>
  <div v-if="getGenres!=null">
    <div class="customContainer" :key="index">
      <div class="customCarousel">
        <router-link :to="`category/${$route.name=='Movies'?'movies':'series'}/${item.name}`" v-for="(item, index) in getGenres" :key="index" class="customItem">
          
          {{item.name}}
          </router-link>
          
      </div>
    </div>
    <div class="dotContainer">
      <div class="dotRow"></div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      itemAmountInRow: null,
      index: 0,
      selected: 0,
    };
  },
  mounted() {
    this.index++;
  },
  updated() {
    this.createor();
  },
  methods: {
    createor() {
      const mrgSize = 10;
      var customCarousel = document.querySelector(".customCarousel");
      let customContainer = document.querySelector(".customContainer");
      var items = document.querySelectorAll(".customItem");

      var index = 0;
      var sum = 0;
      items.forEach((e) => {
        sum += e.offsetWidth + mrgSize;
        if (sum > customCarousel.offsetWidth) return false;
        index++;
      });

      for (let i = 0; i < Math.ceil(items.length / index); i++) {
        var ele = document.createElement("div");
        customContainer.appendChild(ele);

        ele.classList.add("customCarousel");

        var appending = [...items]
          .slice(index * i, index * (i + 1))
          .forEach((e) => {
            ele.appendChild(e);
          });

        this.sizing(ele.querySelectorAll(".customItem"), ele, mrgSize, index);
      }
      customCarousel.remove();

      customContainer.style.display = "flex";
      customContainer.style.overflow = "hidden";
      document.querySelectorAll(".customCarousel").forEach((e, i) => {
        e.style.flexShrink = "0";
        e.style.position = "absolute";
        e.style.left = i * customContainer.offsetWidth + "px";
      });
      this.dotCreator()
    },
    sizing(items, customCarousel, mrgSize, index) {
      var fullWidth = 0.0;
      for (let i = 0; i < index; i++) {
        if (items[i]) {
          fullWidth += items[i].offsetWidth + mrgSize;
        }
      }

      var marginSize = customCarousel.offsetWidth - fullWidth;

      customCarousel.style.marginRight =
        customCarousel.offsetLeft + marginSize / 2 + "px";
      customCarousel.style.marginLeft =
        customCarousel.offsetLeft + marginSize / 2 + 4 + "px";
    },
    dotCreator() {
      var row = document.querySelector(".dotRow");
      for (
        let q = 0;
        q < document.querySelectorAll(".customCarousel").length;
        q++
      ) {
        var dot = document.createElement("div");
        row.appendChild(dot);
        dot.classList.add("dots");
        dot.onclick = (e) => {
          document.querySelectorAll(".dots").forEach((e) => {
            e.classList.remove("selected");
          });
          e.target.classList.add("selected");
          var elIn = Array.from(e.target.parentNode.childNodes).indexOf(
            e.target
          );
          this.dynamicSlider(elIn)
        };
        if (this.selected == q) dot.classList.add("selected");
      }
    },
    dynamicSlider(index){
      let customCarousel = document.querySelectorAll(".customCarousel");
      let customContainer = document.querySelector(".customContainer");

      for (let q = 0; q < customCarousel.length; q++) {
        customCarousel[q].style.left = customContainer.offsetWidth*-1*index +(customContainer.offsetWidth*q) + "px"
      }
    }
  },
  computed: {
    getGenres() {
      return this.$store.state.allGenres;
    },
  },
};
</script>

<style>
.selected {
  background-color: white;
}
.dots {
  margin: 0 5px;
  border-radius: 50px;
  border: 1px solid white;
  width: 10px;
  height: 10px;
  display: inline-block;
  cursor: pointer;
}
.dotContainer {
  justify-content: center;
  text-align: center;
}
.customContainer {
  margin-top: 1.5rem;
  height: 75px;
}
.customCarousel {
  transition: left 0.5s; 
  display: flex;
  overflow: hidden;
  margin: 0 85px;
}
.customItem {
  margin-right: 10px;
  color: white;
  flex-shrink: 0;
  height: 50px;
  width: 150px;
  text-align: center;
  padding: 10px 20px;
  border-radius: 25px;
  border: 2px solid #333333;
  background-color: #111;
  transition: all 0.5s;
  cursor: pointer;
  font-weight: 500;
}
.customItem:hover {
    text-decoration: none;
  color: #111;
  background-color: white;
}
</style>