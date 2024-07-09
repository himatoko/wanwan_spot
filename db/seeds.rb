# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Post.find_or_create_by!(title: "大人気のカフェです。") do |post|
  post.shop_name = "Cavello"
  post.recommend_point = "インスタ映えする飲み物とスイーツが楽しめます。犬向けのご飯もあります。"
  post.advice = "行列ができるので朝一に行くのがおすすめです。"
  post.prefecture = "東京都"
  post.address = "渋谷区神宮前ーーーーー"
  post.user = olivia
end

Post.find_or_create_by!(title: "素敵すぎるホテル。。！") do |post|
  post.shop_name = "ホテルペット"
  post.recommend_point = "犬と一緒に泊まれるホテルです。犬用のアメニティーも充実してます！"
  post.advice = "予約が埋まりやすいので早めに予約するのがおすすめです。"
  post.prefecture = "長野県"
  post.address = "軽井沢市ーーーーー"
  post.user = james
 end

Post.find_or_create_by!(title: "一日遊べるドッグラン！！") do |post|
  post.shop_name = "dogrunrun"
  post.recommend_point = "複数のブースがあるので色々な遊び方ができます。"
  post.advice = "場所によっては汚れる可能性もあるのでタオルなど持参した方が安心です。"
  post.prefecture = "神奈川県"
  post.address = "横浜市ーーーーー"
  post.user = lucas
end