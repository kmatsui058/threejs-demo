<template>
  <div class="home">
    <ClassRoom/>
  </div>
</template>

<script>
// @ is an alias to /src
import ClassRoom from '@/components/ClassRoom.vue'

export default {
  name: 'home',
  components: {
    ClassRoom
  }
}
</script>
