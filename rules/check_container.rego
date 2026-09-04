package rules

default allow = []
default deny = []
default error = []

allow[msg] {
	input.exists == 1
	input.running == 1
	input.name_ok == 1
	input.publish_ok == 1
	msg := "container workshop-health is running with 8080:8080"
}

deny[msg] {
	input.exists != 1
	msg := "container named workshop-health is missing"
}

deny[msg] {
	input.exists == 1
	input.running != 1
	msg := "container workshop-health is not running"
}

deny[msg] {
	input.exists == 1
	input.running == 1
	input.publish_ok != 1
	msg := "publish must map host 8080 to container 8080"
}
