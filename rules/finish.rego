package sbercode

default allow = []
default deny = []
default error = []

allow[msg] {
	input.image_ok == 1
	input.container_ok == 1
	input.http_ok == 1
	msg := "podman health service is healthy"
}

deny[msg] {
	input.image_ok != 1
	msg := "image workshop-health:local missing"
}

deny[msg] {
	input.container_ok != 1
	msg := "container workshop-health must be running with 8080:8080"
}

deny[msg] {
	input.http_ok != 1
	msg := "host curl /health must return ok"
}
