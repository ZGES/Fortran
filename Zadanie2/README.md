# **W tym katalogu znajduje sie drugie zadanie z Fortrana**

**Organizacja**
-----------
```
|--res
|   |--clearedFftSignal.txt
|   |--clearedSignal.txt
|   |--cosSignal.txt 
|   |--fftSignal.txt
|   |--noisyFftSignal.txt
|   |--noisySignal.txt
|   |--plot_badFactor.png
|   |--plot_clearedFftSignal.png
|   |--plot_clearedSignal.png
|   |--plot_cosSignal.png 
|   |--plot_fftSignal.png 
|   |--plot_noisyFftSignal.png 
|   |--plot_noisySignal.png 
|   |--plot_sumSignal.png
|   |--sumSignal.txt
|--src
|   |--Makefile
|   |--fftw3.f03
|   |--gnuplot.sh
|   |--noisermv.f90
|   |--sigsum.f90
|--README.md
```
## Katalog /src
#### sigsum.f90
Jest to program który zapisuje w pliku 'sumSignal.txt' wartości równe sumie dwóch sinusoidalnych sygnałów: ```sin(2*pi*t*100)``` oraz ```sin(2*pi*t*350)``` (prawa kolumna) 
wraz z czasem "pomiaru" wartości (lewa kolumna). Następnie program wykonuje na wyliczonej sumie szybką transformację fouriera i jej wyniki zapisuje w pliku 'fftSignal.txt'.

#### noisermv.f90
Program zapisuje w pliku 'cosSignal.txt' punkty pomiaru funkcji ```cos(t)```, a następnie zaburza je liczbą losową z przedziału (0,1) i tak zanieczyszczone pomiary zapisuje
w pliku 'noisySignal.txt'. Następnie na tak zaburzonych danych przeprowadza fft i jej wyniki zamieszcza w pliku 'noisyFftSignal.txt'. Program oczyszcza transformatę
zamieniając wyniki o module mniejszym od 50 na 0 i zapisuje rezultaty w 'clearedFftSignal.txt'. Na koniec program przeprowadza odwrotną fft na oczyszcznoych danych i wynik
zapisuje w pliku 'clearedSignal.txt'.

#### fftw3.f03
Jest to plik biblioteczny zawierający wszystkie funkcje niezbędne do skorzystania z biblioteki FFTWv3.3.8 w wersjach od Fortrana2003 wzwyż.

#### gnuplot.sh
Bashowy skrypt służący do wykonania wykresów pomiarów w gnuplocie.

#### Makefile
1. make all - kompiluje oba programy, wykonuje je oraz uruchamia skrypt do rysowania wykresów
2. make sigsum - kompiluje program sigsum.f90 i wykonuje go
3. make noisermv - kompiluje program noisermv.f90 i wykonuje go
4. make comp - kompiluje oba programy
5. make tets - wykonuje oba programy
6. make plot - rysuje wykresy na podstawie wyników działania programów

## Katalog /res
### Pliki "*.txt"
Zawierają wyniki działania programów.
1. 'sumSignal.txt' i 'fftSignal.txt' zawierają wyniki programu sigsum.f90
2. pozostałe pliki tekstowe zawierają wyniki programu noisermv.f90

Zawartość plików opisana jest w podpuktach 'sigsum.f90' i 'noisermv.f90' w opisie katalogu /src.

### Pliki "plot_*.png"
Pliki z wykresami, gdzie nazwa w miejscu '*' wskazuje na plik txt z którego pochodzą pomiary. Jedynym wyjątkiem jest plik 'plot_badFactor.png', który jest odpowiednikiem
pliku 'plot_clearedSignal.png', jednak do jego sporządzenia zminiłem jedną wrtość w kodzie programu 'noisermv.f90'.

## Sprawozdanie
