<template>
  <div v-if="getData != null">
    <genrebar></genrebar>
    <carousel v-for="(item, index) in getData" :key="index" v-bind:json="item"></carousel>
  </div>
</template>
<script>
export default {
  beforeCreate() {
    this.$store.state.metaTag(null, null, null)
  },
  computed: {
    getData() {
      return this.$route.name == "Movies" || this.$route.name == undefined
        ? this.$store.state.homeMovies
        : this.$store.state.homeSeries;
    },
  },
};
</script>

<style scoped>
</style> 