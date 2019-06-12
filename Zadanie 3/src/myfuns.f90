module myfuns

    implicit none

    contains
        function polymonial1(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = 2*x
        end function polymonial1

        function polymonial2(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = x**2+x-4
        end function polymonial2

        function polymonial3(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = -3*x**3+10*x
        end function polymonial3

        function polymonial4(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = 0.5*x**4-20*x**2+x
        end function polymonial4

        function polymonial5(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = x**5-x**4+3*x**3+x**2-10*x
        end function polymonial5

        function polymonial6(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = 2*x**6+x
        end function polymonial6

        function polymonial7(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = 0.32*x**7-2*x**6+5*x**3-0.001*x
        end function polymonial7

        function polymonial8(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = x**8-9*x**4+3*x
        end function polymonial8

        function polymonial9(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = 2*x**9-100*x**2+22
        end function polymonial9

        function polymonial10(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = 10*x**10-9*x**9+7*x**8-12.3*x**2
        end function polymonial10

        function my_exp(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = exp(x)
        end function my_exp

        function my_sin(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y

            y = sin(x)
        end function my_sin
end module myfuns