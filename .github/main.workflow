workflow "Run Telegram Bot" {
  resolves = [
    "Bad news",
    "Good news",
  ]
  on = "pull_request"
}

action "PR closed" {
  uses = "actions/bin/filter@master"
  args = "merged false"
}

action "Bad news" {
  uses = "appleboy/telegram-action@master"
  needs = ["PR closed"]
  secrets = ["TELEGRAM_TOKEN", "TELEGRAM_TO"]
}

action "PR merged" {
  uses = "actions/bin/filter@master"
  args = "merged true"
}

action "Good news" {
  uses = "appleboy/telegram-action@master"
  needs = ["PR merged"]
  secrets = ["TELEGRAM_TOKEN", "TELEGRAM_TO"]
}
