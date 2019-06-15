all: shared test

shared:
	ifort -std08 main.f90 integrates.f90 myfuns.f90 -o main -coarray=shared

distributed:
	ifort -std08 main.f90 integrates.f90 myfuns.f90 -o main -coarray=distributed

single:
	ifort -std08 main.f90 integrates.f90 myfuns.f90 -o main -coarray=single

test:
	./main

