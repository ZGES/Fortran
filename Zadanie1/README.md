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
![wykres4](/uploads/e73e93e7b4e1e4daa1827a518af00f90/wykres4.png)
Na tym wykresie widac, że srednio funkcja matmul daje najlepsze wyniki mnozenia. Mnozenie naiwne i za pomoca dot_product daja najgorsze rezultaty, natomiast mnozenie better
daje coraz lepsze wyniki wraz z wzrostem rozmiaru macierzy, gdzie w pozostalych przypadkach czas rosnie wraz z rozmiarem.

![wykres8](/uploads/347b5116b9e2deb7996d336ba2afe337/wykres8.png)
Wykres zawiera blad, jednak nie udalo mi sie dociec dlaczego, pomimo podozania za instrukcjami do narysowania go w gnuplocie.
Analizujac gorna(poprawna) czesc mozemy zauwazyc zmiane w stosunku do poprzednich pomiarow. Funkcje dotmul, naivemul oraz bettmul dla duzych rozmiarow zaczynaja dzialac
z podobnym czasem i tylko dla nieduzych macierzy funkcja dotmul uzyskuje gorsze rezultaty. Najgorzej jak poprzednio dziala funkcja naivmul, ktorej czasy rosna wraz
z rozmiarami macierzy.

![wykres16](/uploads/234922505950bd1a813634409cb96e64/wykres16.png)
Dla kind = 16 wszystkie funkcje zaczynaja uzyskiwac podbne czasy, wraz ze wzrostem rozmiaru macierzy. Co ciekawe, najgorsze rezultaty osiaga funkcja bettmul, natomiast
naivmul zachowuje sie podobnie do funkcji matmul.

#### Wnioski ogolne
Można dostrzec, że ogólnie najlepiej prezentuja sie funkcje matmul oraz bettmul, a najgorzej funkcja naivmul, ale dla uzyskania lepszych pomiarow i porownan powinno sie
przeprowadzic testy dla wiekszych rozmiarow macierzy, nawet do 10000. Wtedy roznice powinny byc bardziej widoczne.