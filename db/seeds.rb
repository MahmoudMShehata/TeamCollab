u = User.create!(email: "leader@teamcollab.com", password: "123123", teamleader: true)
User.create!(email: "member1@teamcollab.com", password: "123123", teamleader: false)
User.create!(email: "member2@teamcollab.com", password: "123123", teamleader: false)
User.create!(email: "member3@teamcollab.com", password: "123123", teamleader: false)

tp = TaskPool.create!(name: "August Sprint", team_leader_id: u.id)
Task.create!(title: "db crash", type: "BugReport", deadline: Time.now + 30.days, progress: "to_do", task_pool_id: tp.id, users: [User.second, User.third])
Task.create!(title: "users subscribtion", type: "FeatureRequest", deadline: Time.now + 30.days, progress: "in_progress", task_pool_id: tp.id, users: [User.third, User.fourth])
Task.create!(title: "summer season", type: "MarketingCampaign", deadline: Time.now + 30.days, progress: "done", task_pool_id: tp.id, users: [User.second])
