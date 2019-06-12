program main

    use integrates
    use myfuns
    implicit none

    interface
        function fun_int1(x) result(y)
            implicit none
            real(kind = 8), intent(in) :: x
            real(kind = 8) :: y
        end function fun_int1
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

    procedure(integrate), pointer :: int_ptr => null() !pointer on integrate function
    procedure(fun_int), pointer :: fun_ptr => null() !pointer on function which will be integrated
    real(kind = 8),  codimension[*] :: value
    real(kind  = 8) :: ibeg
    real(kind  = 8) :: iend
    integer(kind = 4) :: p

    
end program main