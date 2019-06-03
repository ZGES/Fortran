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
Bashowy skrypt służący do wykonania wykresów pomiarów w gnuplocie. Pomiary powinny znajdować się w katalogu /res.

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
*  **Zamien sygnał na sumę sygnałów:**

W tym zadaniu miałem sprawdzić jak działa w praktyce fft.
W tym celu wybrałem dwa sygnały sinusoidalne ```sin(2*pi*t*100)``` oraz ```sin(2*pi*t*350)```, o częstotiwościach odpowiednio 100Hz i 350Hz, a następnie je zsumowałem:
![plot_sumSignal](/uploads/2bd243acdecf44f45fe618953ce2dffa/plot_sumSignal.png)
Z samego wykresu ciężko wywnioskować jakie i ile sygnałów wchodzi w skład widocznej funkcji. Jednak teraz wkracza transformacja fouriera(a raczej jej szybsza odmiana),
za pomocą której możemy przekształcić wykres z dziedziny czasu w dziedzinę częstotliwości:
![plot_fftSignal](/uploads/0f12ce958df157a387fa62ca0273c96a/plot_fftSignal.png)
Trudny do rozczytania wykres sygnału zmienił się w dwa piki, które przypadają na częstotliwości 100Hz i 350Hz, czyli tyle ile miały poszczególne sinusoidalne sygnały.

**WNIOSKI:**
Za pomocą fft jesteśmy w stanie poznać składowe dowolnego sygnału. Wykres częstotliwości pokaże nam ile ich było za pomocą ilości pików, a także częstotliwości sygnałów
poprzez miejsce wystąpienia pików oraz amplitudę jako długośc piku.


* **Usuwanie szumów:**

W tym zadaniu miałem sprawdzić co się stanie kiedy na zaburzonym sygnale przeprowadzimy fft, "oczyścimy" transfomatę i przeprowadzimy transformację odwrotną.
W tym celu sygnał ```cos(t)```: 
![plot_cosSignal](/uploads/05ac369c79f72efbfd483a8821264e82/plot_cosSignal.png)
zaburzyłem porzez dodanie wartości pseudolosowych z zakresu (0,1), otrzymując następujący sygnał:
![plot_noisySignal](/uploads/072e31cfe90a18fb8d56036b230308cc/plot_noisySignal.png)
Następnie przeprowadziłem na nim fft:
![plot_noisyFftSignal](/uploads/32cff43213a29b90628a33463f2d4fff/plot_noisyFftSignal.png)
Widać tu wiele małych pików, za które odpowiedzialne są zaburzenia, które w prawdziwym życiu są szumami, czyli sinusoidami o niedużej amplitudzie. Jednak takie szumy
można wyciąć, poprzez wyzerowanie tej części transformaty, której wartość bezwzględna jest mniejsza niż w tym wypadku 50:
![plot_clearedFftSignal](/uploads/76c7d6e1fad4b658c09d7a59327c5c46/plot_clearedFftSignal.png)
W ten sposób pozostał nam jeden pik, odpowiada on głównemu sygnałowi. Po przeprowadzeniu odwrotnej fft, na oczyszczonym sygnale, otrzymujemy:
![plot_clearedSignal](/uploads/f33fbaa1ac5e42b7dae282985d35fb39/plot_clearedSignal.png)
Sygnał wygląda tak jak nasz cosinus, tylko jest przesunięty o 0,5 w górę. Aby uzyskać taki wynik wartości cosinusa pobierałem z częstotliwością 2048Hz, w czasie 7 sekund.
Gdyby jednak zmienić te parametry, np czas pomiaru na 8 sekund odwrotna transformacja da następujący wynik:
![plot_badFactor](/uploads/dd9752b1046841ec55eb0fd961e62da7/plot_badFactor.png)
Sygnał przypomina cosinusoidalny, ale jest dość zdeformowany.

**WNIOSKI:**
Dzięki fft i odwrotnej fft jesteśmy wstanie odszumić sygnał i pozbyć się wszystkich nieregularności. By uzyskać zadowalający wynik należy jednak pamiętać o odpowiednim
doborze częstości próbek do czasu, w przeciwnym wypadku naszym oczom może ukazać się obrazek taki, jak powyższy.

