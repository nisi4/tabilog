# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: "test@test.com",
    password: "testtest"
)



require "csv"

CSV.foreach("db/towndata.csv") do |info|
    Town.create!(
        id: info[0],
        town_name: info[1]
    )
end
    
require "csv"

CSV.foreach("db/category_data.csv") do |row|
    Category.create!(
        id: row[0],
        category_name: row[1]
    )
end

users = User.create!(
    [
        {email: "nemuro@test.com",password: "password",last_name: "根室",first_name: "花子",last_name_kana: "ネムロ",first_name_kana: "ハナコ",user_name: "ネムネム"},
        {email: "betsukai@test.com",password: "password",last_name: "別海",first_name: "太郎",last_name_kana: "ベツカイ",first_name_kana: "タロウ",user_name: "ベタロウ"},
        {email: "shibetsu@test.com",password: "password",last_name: "標津",first_name: "道子",last_name_kana: "シベツ",first_name_kana: "ミチコ",user_name: "シベコ"},
        {email: "rausu@test.com",password: "password",last_name: "羅臼",first_name: "領太",last_name_kana: "ラウス",first_name_kana: "リヨウタ",user_name: "ラウタ"}
    ]
)

Post.create!(
    [
        {user_id: users[0].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post1-1.jpeg"), filename:"sample_post1-1.jpeg"),town_id: "62",category_id: "1",title: "焼肉",star: "4",body: "おいしかった〜"},
        {user_id: users[0].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post1-2.jpeg"), filename:"sample_post1-2.jpeg"),town_id: "100",category_id: "3",title: "鶴",star: "2",body: "パワーをもらった！"},
        {user_id: users[0].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post1-3.jpeg"), filename:"sample_post1-3.jpeg"),town_id: "145",category_id: "2",title: "富良野で癒し",star: "3",body: "綺麗な花"},
        {user_id: users[0].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post1-4.jpeg"), filename:"sample_post1-4.jpeg"),town_id: "127",category_id: "8",title: "東の端っこ",star: "4",body: "北方領土が見えた！"},
        {user_id: users[0].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post1-5.jpeg"), filename:"sample_post1-5.jpeg"),town_id: "55",category_id: "5",title: "キャンプ",star: "3",body: "気持ち良い天気で最高"},
        {user_id: users[1].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post2-1.jpeg"), filename:"sample_post2-1.jpeg"),town_id: "62",category_id: "1",title: "手羽先が有名なお店",star: "4",body: "山盛りでうまい！"},
        {user_id: users[1].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post2-2.jpg"), filename:"sample_post2-2.jpg"),town_id: "39",category_id: "1",title: "帯広といえば",star: "5",body: "このカレー！安くてうまい"},
        {user_id: users[1].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post2-3.jpeg"), filename:"sample_post2-3.jpeg"),town_id: "97",category_id: "2",title: "キャンプ場にて",star: "4",body: "夕日が綺麗〜"},
        {user_id: users[1].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post2-4.jpeg"), filename:"sample_post2-4.jpeg"),town_id: "69",category_id: "3",title: "牛の大群",star: "2",body: "キャンプ場で朝目覚めるとこの光景・・・"},
        {user_id: users[1].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post2-5.jpeg"), filename:"sample_post2-5.jpeg"),town_id: "170",category_id: "2",title: "知床",star: "3",body: "ドライブに知床峠おすすめ"},
        {user_id: users[2].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post3-1.jpeg"), filename:"sample_post3-1.jpeg"),town_id: "35",category_id: "2",title: "天狗山",star: "4",body: "景色最高！リスにも会える"},
        {user_id: users[2].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post3-2.jpeg"), filename:"sample_post3-2.jpeg"),town_id: "35",category_id: "2",title: "オタモイ",star: "5",body: "一度この絶景を見に行ってほしい"},
        {user_id: users[2].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post3-3.jpeg"), filename:"sample_post3-3.jpeg"),town_id: "145",category_id: "9",title: "ウィンタースポーツ",star: "3",body: "富良野は冬もおすすめ"},
        {user_id: users[2].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post3-4.jpeg"), filename:"sample_post3-4.jpeg"),town_id: "102",category_id: "2",title: "霧の摩周湖",star: "2",body: "霧少なめだった"},
        {user_id: users[2].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post3-5.jpeg"), filename:"sample_post3-5.jpeg"),town_id: "115",category_id: "2",title: "開陽台",star: "4",body: "360度地平線が広がる"},
        {user_id: users[3].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post4-1.jpeg"), filename:"sample_post4-1.jpeg"),town_id: "35",category_id: "3",title: "小樽水族館",star: "3",body: "ペンギンの行進可愛い"},
        {user_id: users[3].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post4-2.jpeg"), filename:"sample_post4-2.jpeg"),town_id: "77",category_id: "2",title: "神威岬",star: "2",body: "歩いた先に絶景あり"},
        {user_id: users[3].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post4-3.jpeg"), filename:"sample_post4-3.jpeg"),town_id: "127",category_id: "1",title: "根室名物",star: "4",body: "地元のコンビニで買えるやきとり弁当"},
        {user_id: users[3].id,image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_post4-4.jpeg"), filename:"sample_post4-4.jpeg"),town_id: "81",category_id: "2",title: "道の駅",star: "3",body: "白い砂浜が美しかった"}
    ]
)

