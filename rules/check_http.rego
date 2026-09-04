package sbercode

default allow = []
default deny = []
default error = []

allow[msg] {
	input.http_ok == 1
	msg := "GET /health returns 200 ok"
}

deny[msg] {
	input.http_ok != 1
	msg := "curl http://127.0.0.1:8080/health must return body ok with HTTP 200"
}
