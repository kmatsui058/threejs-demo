<template>
  <div class="classroom">
    <canvas ref="canvas"></canvas>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import * as THREE from 'three'
import { GLTFLoader, GLTF } from 'three/examples/jsm/loaders/GLTFLoader'
import { OrbitControls } from 'three-orbitcontrols-ts'
@Component
export default class ClassRoom extends Vue {
  createdPromise: Promise<void> | undefined
  loader = new GLTFLoader()
  gltf: undefined | GLTF
  canvas: HTMLCanvasElement | undefined
  scene = new THREE.Scene();
  renderer: THREE.WebGLRenderer | undefined
  camera = new THREE.PerspectiveCamera()
  light = new THREE.DirectionalLight(0xFFFFFF)
  controls: OrbitControls | undefined
  get width (): number {
    if (this.canvas) {
      return this.canvas.getBoundingClientRect().width
    }
    return 0
  }
  get height (): number {
    if (this.canvas) {
      return this.canvas.getBoundingClientRect().width
    }
    return 0
  }
  async created () {
    this.createdPromise = new Promise((resolve: (value?:any)=>void, reject: (reason?:any)=>void) => {
      this.loader.load(
        '/gltf/classroom.glb',
        gltf => {
          console.log('gltf load succeeded')
          console.log(gltf)
          this.gltf = gltf
          resolve()
        },
        event => {
          console.warn(event)
          console.log('gltf load on progress')
        },
        err => {
          console.warn(err)
          console.log('gltf load failed')
          reject(err)
        }
      )
    })
  }
  mounted () {
    const onfulfilled = () => {
      console.log('start mounted')
      if (!this.gltf) {
        console.warn('gltf file not found')
        return
      }
      const temp = this.$refs.canvas
      console.log(this.$refs)
      console.log(temp)
      if (temp instanceof HTMLCanvasElement) {
        this.canvas = temp
      } else {
        console.warn('canvas not found')
        return
      }
      this.renderer = new THREE.WebGLRenderer({
        canvas: this.canvas
      })
      this.renderer.setPixelRatio(1)
      this.renderer.setSize(this.width, this.height)
      this.renderer.gammaOutput = true
      this.renderer.gammaFactor = 2.2
      this.camera.aspect = this.width / this.height
      this.camera.position.set(0, 1, 1)
      this.controls = new OrbitControls(this.camera)
      this.scene.add(this.gltf.scene)
      this.light.intensity = 2
      this.light.position.set(1, 1, 1)
      this.scene.add(this.light)
      this.tick()
    }
    if (this.createdPromise) {
      this.createdPromise
        .then(onfulfilled)
        .catch(err => {
          console.warn(err)
          console.log('createdPromise was rejected')
        })
    }
  }
  tick () {
    if (!this.controls || !this.renderer) {
      console.warn('unexpected data state')
      return
    }
    this.controls.update()
    this.renderer.render(this.scene, this.camera)
    requestAnimationFrame(this.tick)
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
canvas {
  width: 100%;
  height: 100%;
}
</style>
