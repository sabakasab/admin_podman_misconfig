package sbercode

default allow = []
default deny = []
default error = []

allow[msg] {
	input.image_ok == 1
	msg := "image workshop-health:local exists"
}

deny[msg] {
	input.image_ok != 1
	msg := "build and tag image as workshop-health:local"
}
