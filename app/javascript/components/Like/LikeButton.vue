<template>
  <div>
    <div v-if="isLiked" @click="deleteLike()">
      いいねを取り消す {{ count }}
    </div>
    <div v-else @click="registerLike()">
      いいねする {{ count }}
    </div>
  </div>
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
      return Boolean(this.findLikeId())
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
      const res = await axios.post('/api/likes', { post_id: this.postId })
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
      if (like) { return like.id }
    }
  }
}
</script>
