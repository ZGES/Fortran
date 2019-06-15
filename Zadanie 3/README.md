# **W tym katalogu znajduje sie trzecie zadanie z Fortrana**

**Organizacja**
-----------
```
|--res
|   |--gauss_int_dis.txt
|   |--gauss_int_sg.txt
|   |--gauss_int_sh.txt 
|   |--table.png
|   |--rect_int_dis.txt 
|   |--rect_int_sg.txt 
|   |--rect_int_sh.txt 
|   |--trap_int_dis.txt 
|   |--trap_int_sg.txt
|   |--trap_int_sh.txt
|   |--valid_res.txt
|
|--src
|   |--Makefile
|   |--integrates.f90
|   |--main.f90
|   |--myfuns.f90
|
|--README.md
```
## Katalog /src
### myfuns.f90
W tym module znajdują się funkcje, które zostają poddane całkowaniu:
1.  y = 2x
2.  y = x^2 + x - 4
3.  y = -3x^3 + 10x 
4.  y = 0.5x^4 - 20x^2 + x
5.  y = x^5 - x^4 + 3x^3 + x^2 - 10x
6.  y = 2x^6 + x
7.  y = 0.32x^7 - 2x^6 + 5x^3 - 0.001x
8.  y = x^8 - 9x^4 + 3x
9.  y = 2x^9 - 100x^2 + 22
10. y = 10x^10 - 9x^9 + 7x^8 - 12.3x^2
11. y = e^x
12. y = sin(x)

### integrates.f90
Moduł zawiera funkcje całkujące:
1.  metodą prostokątów
2.  metodą trapezów
3.  metodą gaussa

### main.f90
Główny program wykonywalny. Wielowątkowo liczy całki na przedziale <0,3> dla kazdej z funkcji  w 'myfuns.f90', każdą z metod całkowania w 'integrates.f90'. Przedział
całkowania dzielony jest na 20 podprzedziałów. Wyniki zapisywane są w katalogu res w postaci <skrót nazwy metody całkowania>_int.txt.

### Makefile
1. make all - kompiluje moduły i program z opcją coarray=shared i uruchamia program main
2. make shared - kompiluje moduły i program z opcją coarray=shared
3. make distributed - kompiluje moduły i program z opcją coarray=distributed
4. make single - kompiluje moduły i program z opcją coarray=single
5. make tets - wykonuje program main

**UWAGI:** 
1. Podczas pierwszej kompilacji moduły mogą nie dołączyć się poprawnie do programu głównego. Jeśli to nastąpi należy powtórzyć kompilację i wszystko powinno
   działać.
2. Może się zdarzyć, że zmienne środowiskowe potrzebne ifortowi do kozystania z MPI, a tym samym z coarrays nie są ustawione. By to zrobić, w systemie linux,
   należy wpisać w konsoli: `source /<path to intel install dir>/intel/bin/compilervars.sh -arch <arch> -platform linux`, gdzie w miejsce arch należy podać
   architekturę procesora z której się kożysta - `ia32` lub `intel64`.


## Katalog /res
### Pliki "*_int.txt"
Zawierają wyniki działania programu w postaci: określenie funkcji(stopień wielomianu/sinus/exponenta): wartość obliczeń. Pierwszy wyraz w nazwie określa metodę całkowania,
a trzeci metodę kompilacji, sh - shared, dis - distributed, sg - single.

### Plik "valid_res.txt"
Plik ten zawiera analitycznie wyliczone wartości ([w wolframie](https://www.wolframalpha.com/)) całki na przedziale <0,3> dla każdej z funkcji z 'myfuns.f90'.

### Plik "table.png"
Plik zawierający tabelę z zestawieniem pomiarów i różnicami od wartości prawdziwej.

## Sprawozdanie
Celem zadania było napisanie i przetestowanie 3 metod całkowania, oraz sprawdzenie zachowania metody gaussa dla funkcji nie będącymi wielomianami.
Wyniki dla każdej z opcji kompilacji wyszły takie same i zostały zestawione w poniższej tabeli razem z różnicą od wartości wyliczonej analitycznie:
![table](/uploads/f333fc6af7d97e1491b570bd4427bb74/table.png)


Jak widać najlepsze rezultaty dała metoda gaussa, różnica od wrtości prawdziwej nie przekraczała 0.01. Z pozostałych metod metoda trapezów daje gorsze rezultaty
(błąd około 2 razy większy), jednak obie dają wyniki znacząco różniące się od prawdziwych już dla wielomianów stopnia >= 6.

W kwestii sinusa i exponenty, to ich rozwinięcia w szereg Maclaurina są wielomianam, dlatego metoda gaussa na nich działa. Potraktowałem je jako wielomiany stopnia 5
i to wystarczyło, by metoda gaussa dała poprawny wynik. Dla tych funkcji metody prostokątów i trapezów dały zadowalający rezultat.