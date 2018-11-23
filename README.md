## rails-vuejs-iine-sample
### 起動方法
```
# 初回
docker-compose build
docker-compose run web bin/setup
docker-compose up

# 初回以降
docker-compose up
```

### ログイン
http://localhost:3000/users/sign_in
- User & Password
  - [seeds.rb](db/seeds.rb)
