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

        function gauss_int(ibeg, iend, myfun, p) result(value)
            implicit none
            real(kind  = 8), intent(in) :: ibeg !begining of integration interval
            real(kind  = 8), intent(in) :: iend !end of the integration interval
            procedure(fun_int) :: myfun !function to be integrated
            integer(kind = 4), intent(in) :: p !polymonial order
            real(kind = 8) :: value !result of integration
        
            integer(kind = 4) :: i !iterator
            real(kind = 8), dimension(2,2) :: LegandreArr2
            real(kind = 8), dimension(3,2) :: LegandreArr3
            real(kind = 8), dimension(4,2) :: LegandreArr4
            real(kind = 8), dimension(5,2) :: LegandreArr5
            real(kind = 8), dimension(6,2) :: LegandreArr6

            !initialization legendre's points
            LegandreArr2  = reshape((/-0.57735,0.57735,1.0,1.0/),shape(LegandreArr2))
            LegandreArr3  = reshape((/-0.774597,0.0,0.774597,0.555556,0.888889,0.555556/),shape(LegandreArr3))
            LegandreArr4  = reshape((/-0.861136,-0.339981,0.3399810,0.861136,&
            0.347855,0.652145,0.652145,0.347855/),shape(LegandreArr4))
            LegandreArr5  = reshape((/-0.90618,-0.538469,0.0,0.538469,0.90618,&
            0.236927,0.478629,0.568889,0.478629,0.236927/),shape(LegandreArr5))
            LegandreArr6  = reshape((/-0.93247,-0.661209,-0.238619,0.238619,0.661209,0.93247,&
            0.171324,0.360762,0.467914,0.467914,0.360762,0.171324/),shape(LegandreArr6))

            value = 0.0
            if(p == 1 .OR. p == 2 .OR. p ==3) then
                do i = 1, 2, 1
                    value = value + LegandreArr2(i,2)*myfun((iend+ibeg)/2+(iend-ibeg)*LegandreArr2(i,1)/2)*(iend-ibeg)/2
                end do
            else if (p==4 .OR. p ==5) then
                do i = 1, 3, 1
                    value = value + LegandreArr3(i,2)*myfun((iend+ibeg)/2+(iend-ibeg)*LegandreArr3(i,1)/2)*(iend-ibeg)/2
                end do
            else if (p==6 .OR. p ==7) then
                do i = 1, 4, 1
                    value = value + LegandreArr4(i,2)*myfun((iend+ibeg)/2+(iend-ibeg)*LegandreArr4(i,1)/2)*(iend-ibeg)/2
                end do
            else if (p==8 .OR. p ==9) then
                do i = 1, 5, 1
                    value = value + LegandreArr5(i,2)*myfun((iend+ibeg)/2+(iend-ibeg)*LegandreArr5(i,1)/2)*(iend-ibeg)/2
                end do
            else if (p==10) then
                do i = 1, 6, 1
                    value = value + LegandreArr6(i,2)*myfun((iend+ibeg)/2+(iend-ibeg)*LegandreArr6(i,1)/2)*(iend-ibeg)/2
                end do
            end if

        end function gauss_int

end module integrates