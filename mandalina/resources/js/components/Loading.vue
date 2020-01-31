<template>
  <div v-if="load">
    <div class="bg_load">

    </div>
    <div class="wrapper">
      <div class="inner">
        <span>F</span>
        <span>I</span>
        <span>L</span>
        <span>M</span>
        <span>D</span>
        <span>I</span>
        <span>Z</span>
        <span>I</span>
        <span>M</span>
        <span>O</span>
        <span>B</span>
        <span>.</span>
        <span>C</span>
        <span>O</span>
        <span>M</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["load"],

}
</script>