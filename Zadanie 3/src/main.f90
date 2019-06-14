program main

    use integrates
    use myfuns
    implicit none

    procedure(integrate), pointer :: int_ptr => null() !pointer on integrate function
    procedure(fun_int), pointer :: fun_ptr => null() !pointer on function which will be integrated
    real(kind = 8) :: val
    real(kind  = 8) :: ibeg = 0
    real(kind  = 8) :: iend = 3
    integer :: i,j !iterators
    real :: dx !dx

    open(unit = 11, file = "../res/rect_int.txt", status = 'REPLACE')
    open(unit = 12, file = "../res/trap_int.txt", status = 'REPLACE')
    open(unit = 13, file = "../res/gauss_int.txt", status = 'REPLACE')

    do i = 1, 3, 1
        if(i == 1) then
            !recttangle rule integration
            int_ptr => rectangle_int
        else if(i == 2) then
            !trapezoidal rule integration
            int_ptr => trapezoidal_int
        else if(i == 3) then
            !gauss integration 
            int_ptr => gauss_int
        end if

        !polymonial1
        fun_ptr => polymonial1
        val = int_ptr(ibeg,iend,fun_ptr, 1)
        write(*,*)  val

        !polymonial2
        fun_ptr => polymonial2
        val = int_ptr(ibeg,iend,fun_ptr, 2)
        write(*,*)  val

        !polymonial3
        fun_ptr => polymonial3
        val = int_ptr(ibeg,iend,fun_ptr, 3)
        write(*,*)  val

        !polymonial4
        fun_ptr => polymonial4
        val = int_ptr(ibeg,iend,fun_ptr, 4)
        write(*,*)  val

        !polymonial5
        fun_ptr => polymonial5
        val = int_ptr(ibeg,iend,fun_ptr, 5)
        write(*,*)  val

        !polymonial6
        fun_ptr => polymonial6
        val = int_ptr(ibeg,iend,fun_ptr, 6)
        write(*,*)  val

        !polymonial7
        fun_ptr => polymonial7
        val = int_ptr(ibeg,iend,fun_ptr, 7)
        write(*,*)  val

        !polymonial8
        fun_ptr => polymonial8
        val = int_ptr(ibeg,iend,fun_ptr, 8)
        write(*,*)  val

        !polymonial9
        fun_ptr => polymonial9
        val = int_ptr(ibeg,iend,fun_ptr, 9)
        write(*,*)  val

        !polymonial10
        fun_ptr => polymonial10
        val = int_ptr(ibeg,iend,fun_ptr, 10)
        write(*,*)  val

        !my_sin
        fun_ptr => my_sin
        val = int_ptr(ibeg,iend,fun_ptr, 5)
        write(*,*)  val

        !my_exp
        fun_ptr => my_exp
        val = int_ptr(ibeg,iend,fun_ptr, 5)
        write(*,*)  val
    end do

    !cleaning
    close(unit = 11, status = 'KEEP')
    close(unit = 12, status = 'KEEP')
    close(unit = 13, status = 'KEEP')
end program main