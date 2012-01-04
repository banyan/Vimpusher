User.destroy_all
User.create(
  provider: "github",
  uid:      "19625",
  username: "banyan",
  email:    "ameutau@gmail.com"
)
