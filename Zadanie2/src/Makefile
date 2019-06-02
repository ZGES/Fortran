all: comp test

sigsum:
	ifort -o sigsum sigsum.f90 -Ldirectory -lfftw3
	./sigsum

noisermv:
	ifort -o noisermv noisermv.f90 -Ldirectory -lfftw3
	./noisermv

comp:
	ifort -o sigsum sigsum.f90 -Ldirectory -lfftw3
	ifort -o noisermv noisermv.f90 -Ldirectory -lfftw3

test:
	./sigsum
	./noisermv