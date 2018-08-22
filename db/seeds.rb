# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

userHs = User.create(nickname: 'nick', email: 'heesung6701@naver.com', password: '12341234', rank_point: 3.25)

userHr = User.create(nickname: '키키', email: 'adfilm2@naver.com', password: 'asdfasdf', rank_point: 7.20, item_freehint:10)

userJj = User.create(nickname: 'whale', email: 'jjlee0430@naver.com', password: 'jaejun', rank_point: 6.91, item_freehint:20)

room = Room.create(title: '자지마 코딩해야지', user_id: userHr.id, content: '뀨?')
stage1 = Stage.create(room_id: room.id, title: '답:1',content: 'ㅋㅋㅋㅋ', hint1: '', answer: '1')

room2 = Room.create(title: '오버액션탈출하기', user_id: userHs.id, content: '뀨?')
stage2_1 = Stage.create(room_id: room.id, title: '하늘에서 내려온 토끼가 하는말',content: '바니바니', hint1: '나는 열여섯', hint2: '이제곳 열입곡')
