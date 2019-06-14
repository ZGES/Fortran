module integrates
    
    implicit none
    interface
        function fun_int(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y
        end function fun_int
    end interface

    interface
        function integrate(ibeg, iend, myfun, p) result(value)
            import :: fun_int
            implicit none
            real(kind  = 8), intent(in) :: ibeg !begining of integration interval
            real(kind  = 8), intent(in) :: iend !end of the integration interval
            procedure(fun_int) :: myfun !function to be integrated
            integer(kind = 4), intent(in) :: p !polymonial order
            real(kind = 8) :: value !result of integration
        end function integrate
    end interface

    contains
        function rectangle_int(ibeg, iend, myfun, p) result(value)
            implicit none
            real(kind  = 8), intent(in) :: ibeg !begining of integration interval
            real(kind  = 8), intent(in) :: iend !end of the integration interval
            procedure(fun_int) :: myfun !function to be integrated
            integer(kind = 4), intent(in) :: p !polymonial order
            real(kind = 8) :: value !result of integration

            real(kind = 8) :: dx !length of the interval
            real(kind = 8) :: imid !middle of the interval given by ibeg and iend
            real(kind = 8) :: midval !function value at imid

            dx = abs(iend-ibeg)
            imid = (ibeg+iend)/2
            midval = myfun(imid)

            value = dx*midval

        end function rectangle_int

        function trapezoidal_int(ibeg, iend, myfun, p) result(value)
            implicit none
            real(kind  = 8), intent(in) :: ibeg !begining of integration interval
            real(kind  = 8), intent(in) :: iend !end of the integration interval
            procedure(fun_int) :: myfun !function to be integrated
            integer(kind = 4), intent(in) :: p !polymonial order
            real(kind = 8) :: value !result of integration

            real(kind = 8) :: dx !length of the interval
            real(kind = 8) :: firstval !function value at ibeg
            real(kind = 8) :: secval !function value at iend

            dx = abs(iend-ibeg)
            firstval = myfun(ibeg)
            secval = myfun(iend)

            value = dx*(firstval+secval)/2

        end function trapezoidal_int

        !function gauss_int(ibeg, iend, myfun, p) result(value)
        !    implicit none
        !    real(kind  = 8), intent(in) :: ibeg !begining of integration interval
        !    real(kind  = 8), intent(in) :: iend !end of the integration interval
        !    procedure(fun_int) :: myfun !function to be integrated
        !    integer(kind = 4), intent(in) :: p !polymonial order
        !   real(kind = 8) :: value !result of integration
        !
        !    real(kind = 8) :: dx !length of the interval
        !    real(kind = 8) :: firstval !function value at ibeg
        !    real(kind = 8) :: secval !function value at iend
        !
        !    dx = iend-ibeg
        !   firstval = myfun(ibeg)
        !    secval = myfun(iend)
        !
        !    value = abs(dx*(firstval+secval)/2)
        !
        !end function gauss_int

end module integrates