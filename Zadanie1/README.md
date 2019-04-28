# **W tym katalogu znajduje sie pierwsze zadanie z Fortrana**

**Organizacja**
-----------

W katalogu /src znajduja sie fragmety kodu wykonywalnego - 3 moduly, program glowny i plik CMake.
Katalog /res zawiera zapisane w formacie tekstowym wyniki pomiarow oraz wykresy tyche pomiarow stworzone przy pomocy gnuplota, zapisane w formacie pdf.

## Katalog /src

### Moduly
Poszczegolne moduly zawieraja funkcje mnozace macierze kwadratowe.
Plik naivemath.F90 dostarcza interfejs do naiwnego mnozenia maciezy :
```
 do i = 1, size(A(1,:)), 1
    do j = 1, size(B(:,1)), 1
        C(i,j) = 0
        do k = 1, size(A(:,1)), 1
            C(i,j) = C(i,j) + A(i,k)*B(k,j)
        end do
    end do
end do
```

Plik bettermath.F90 ulepsza powysze mnozenie zmieniajac kolejnosc przechodzenia tablic, tak by odpowiadala fortranowemu ulozeniu ich w pamieci:
```
 C = 0
 do j = 1, size(B(:,1)), 1
    do k = 1, size(A(:,1)), 1
        do i = 1, size(A(1,:)), 1
            C(i,j) = C(i,j) + A(i,k)*B(k,j) 
        end do
    end do
 end do
```
Ostatnia przeze mnie zaipmlementowana wersja mnozenia z pliku dotmath.F90 kozysta z wbudowanej funkcji dot_product(A,B), wykonujacej iloczyn skalarny na wektorach A i B:
```
C = 0
do j = 1, size(B(:,1)), 1
    do i = 1, size(A(1,:)), 1
        C(i,j) = C(i,j) + dot_product(A(i,:), B(:,j))
    end do
end do
```

### Plik wykonywalny
Plik main.F90 tworzy (lub nadpisuje) pliki, ktore przechowywuja wyniki mnozen przeprowadzonych za pomoca powyszych funkcji oraz wbudowanej w jezyk funkcji matmul. Pomiary przeprowadzono dla macierzy rozmiarow: 10x10, 20x20, .., 1280x1280, wypelnionych pseudolosowymi liczbami. Zbadano czasy dla 3 tyow liczbowych real: 
 * kind = 4;
* kind = 8;
* kind = 16.

Dla kazdego rozmiaru i typu przeprowadzono 40 powtorzen, tak aby roznice w czasach byly bardziej zauwazalne, dlatego czas w plikach wynikowych stanowi sume 40 pomiarow.

### Plik "CMakeList.txt"
Plik CMake umozliwiajacy prosta kompilacje, dostarczony przez prowadzacego zajecia.

## Katalog /res

### Pliki "wynik[kind]-<n,b,d,m>.txt"
Pliki przechowuja wyniki dokonanych pomiarow. Kind okresla dla jakiego typu real dokonano pomiaru,
a litery n, b, d, m pochodza od pierwszych liter metody mnozenia.
Plik posiada nastepujaca strukture [rozmiar wektora macierzy] " " [czas w dziesiatkach milisekund].
Taki format czasu zostal wybrany, by wyniki byly latwiejsze w analizie.

### Pliki "wykres[kind].pdf"
Pliki z wykresami, gdzie kind oznacza typ danych pomiarowych. Na wykresach znajduja sie zbiorczo wyniki mnozen czterema sposobami dla danego typu.

## Wnioski
