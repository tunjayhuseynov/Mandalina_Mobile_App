<template>
  <div class="con">
    <div class="mainImage">
      <img :src="imageSrc" width="250" height="150" />
    </div>
    <div class="textBelow">{{title}}</div>
  </div>
</template>
<script>
export default {
  props: ["imageSrc", "title"],
};
</script>

<style scoped>
.con:hover {
  background-color: #ddd;
  cursor: pointer;
}
.con:hover > .textBelow {
  color: #1b1b1b;
}
.con:hover > .mainImage > img {
  transform: scale(1.1);
}
img {
  transition: all 0.5s;
}
.mainImage {
  width: 100%;
  top: 35%;
  transform: translateY(-50%);
  position: absolute;
  text-align: center;
}
.con {
  transition: all 0.5s;
  position: relative;
  height: 315px;
  background-color: #1b1b1b;
  border-radius: 20px;
}
.textBelow {
  transition: all 0.5s;
  width: 100%;
  bottom: 5%;
  transform: translateY(-50%);
  position: absolute;
  text-align: center;
  font-size: 2rem;
  font-weight: bold;
  color: #ddd;
}

@media only screen and (max-width: 767px) and (min-width: 425px) {
  .mainImage>img {
    width: 125px;
    height: 75px;
  }
  .con{
    height: 200px;
  }
  .textBelow{
    font-size: 1rem;
  }
}
@media only screen and (max-width: 424px) {
  .mainImage>img {
    width: 100px;
    height: 60px;
  }
  .con{
    height: 150px;
  }
  .textBelow{
    font-size: 0.9rem;
  }
}
</style>