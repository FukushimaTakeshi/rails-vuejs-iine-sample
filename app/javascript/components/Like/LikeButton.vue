<template>
  <span>
    <span v-if="isLiked" @click="deleteLike()" class="icon is-medium has-text-warning">
      <div class="fas fa-lg fa-star">あんいいね</div>{{ count }}
    </span>
    <span v-else @click="registerLike()" class="icon is-medium has-text-warning">
      <div class="far fa-lg fa-star">いいね</div>{{ count }}
    </span>
  </span>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: ['userId', 'postId'],
  data() {
    return {
      likeList: []
    }
  },
  computed: {
    count() {
      return this.likeList.length
    },
    isLiked() {
      if (this.likeList.length === 0) { return false }
      return Boolean(this.findLikeId)
    }
  },
  created: function() {
    this.fetchLikeByPostId().then(result => {
      this.likeList = result
    })
  },
  methods: {
    fetchLikeByPostId: async function() {
      const res = await axios.get(`/api/likes/?post_id=${this.postId}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },
    registerLike: async function() {
      const res = await axios.post(`/api/likes`, { post_id: this.postId })
      if (res.status !== 201) { process.exit() }
      this.fetchLikeByPostId().then(result => {
        this.likeList = result
      })
    },
    deleteLike: async function() {
      const likeId = this.findLikeId()
      const res = await axios.delete(`/api/likes/${likeId}`)
      if (res.status !== 200) { process.exit() }
      this.likeList = this.likeList.filter(n => n.id !== likeId)
    },
    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return (like.user_id === this.userId)
      })
      return like.id
    }
  }
}
</script>
