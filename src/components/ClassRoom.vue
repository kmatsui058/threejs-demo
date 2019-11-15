<template>
  <div class="classroom">
    <canvas></canvas>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import THREE from 'three'
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader'
@Component
export default class ClassRoom extends Vue {
  @Prop() private msg!: string;
  loader = new GLTFLoader()
  created () {

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">

</style>
