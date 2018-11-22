process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

// see https://qiita.com/taaatk/items/3137659e69b82d10cfca
const path = require('path')
module.exports = Object.assign({}, environment.toWebpackConfig(), {
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  }
})
