<template>
  <div class="classroom">
    <canvas ref="canvas"></canvas>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Ref } from 'vue-property-decorator'
import * as THREE from 'three'
import { GLTFLoader, GLTF } from 'three/examples/jsm/loaders/GLTFLoader'
import { OrbitControls } from 'three-orbitcontrols-ts'
@Component
export default class ClassRoom extends Vue {
  @Ref('canvas') readonly canvas!: HTMLCanvasElement | null
  createdPromise: Promise<void> | null = null
  loader = new GLTFLoader()
  gltf: null | GLTF = null
  scene = new THREE.Scene();
  renderer: THREE.WebGLRenderer | null = null
  camera = new THREE.PerspectiveCamera()
  light = new THREE.DirectionalLight(0xFFFFFF)
  controls: OrbitControls | null = null
  get width (): number {
    if (this.canvas) {
      return this.canvas.getBoundingClientRect().width
    }
    return 0
  }
  get height (): number {
    if (this.canvas) {
      return this.canvas.getBoundingClientRect().height
    }
    return 0
  }
  async created () {
    console.log('created')
    console.log(this.canvas)
    this.createdPromise = new Promise((resolve: (value?:any)=>void, reject: (reason?:any)=>void) => {
      this.loader.load(
        '/gltf/Office_chair_scene_edit.glb',
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
      if (!this.canvas) {
        console.warn('canvas not found')
        return
      }
      this.renderer = new THREE.WebGLRenderer({
        canvas: this.canvas,
        antialias: true
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
