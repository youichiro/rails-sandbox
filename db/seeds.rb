user = User.create!(name: 'admin', email: ENV['ADMIN_USER_EMAIL'], password: ENV['ADMIN_USER_PASSWORD'], role: 'admin')

Task.create!([
  { name: 'タスク1', user: user, done: false, deadline: '2020-10-27 10:00:00', description: 'マグロ' },
  { name: 'タスク2', user: user, done: false, deadline: '2020-10-28 10:00:00', description: 'サーモン' },
  { name: 'タスク3', user: user, done: true, deadline: '2020-10-28 11:00:00', description: 'ホタテ' },
  { name: 'タスク4', user: user, done: true, deadline: '2020-10-28 12:00:00', description: '' },
])
