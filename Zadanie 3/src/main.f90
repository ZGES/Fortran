program main

    use integrates
    use myfuns
    implicit none

    procedure(integrate), pointer :: int_ptr => null() !pointer on integrate function
    procedure(fun_int), pointer :: fun_ptr => null() !pointer on function which will be integrated
    real(kind = 8), codimension[*] :: val
    real(kind  = 8) :: ibeg
    real(kind  = 8) :: iend 
    integer :: i,j !iterators
    real(kind = 8) :: dx !length of the integration interval per thread
    integer :: uni
    character(:), allocatable :: format1 !format of results

    format1 = "(A23, F11.4)"

    open(unit = 11, file = "../res/rect_int.txt", status = 'REPLACE')
    open(unit = 12, file = "../res/trap_int.txt", status = 'REPLACE')
    open(unit = 13, file = "../res/gauss_int.txt", status = 'REPLACE')

    !setting interval of integration
    ibeg = 0
    iend = 3
    dx = abs(iend-ibeg)/20

    !calculations
    do i = 1, 3, 1
        if(i == 1) then
            !recttangle rule integration
            int_ptr => rectangle_int
            uni = 11
        else if(i == 2) then
            !trapezoidal rule integration
            int_ptr => trapezoidal_int
            uni = 12
        else if(i == 3) then
            !gauss integration 
            int_ptr => gauss_int
            uni = 13
        end if

        !polymonial1
        fun_ptr => polymonial1
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 1)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "1st order polymonial: ", val
        end if

        !polymonial2
        fun_ptr => polymonial2
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 2)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "2nd order polymonial: ", val
        end if

        !polymonial3
        fun_ptr => polymonial3
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 3)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "3rd order polymonial: ", val
        end if
        
        !polymonial4
        fun_ptr => polymonial4
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 4)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "4th order polymonial: ", val
        end if

        !polymonial5
        fun_ptr => polymonial5
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 5)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "5th order polymonial: ", val
        end if

        !polymonial6
        fun_ptr => polymonial6
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 6)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "6th order polymonial: ", val
        end if

        !polymonial7
        fun_ptr => polymonial7
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 7)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "7th order polymonial: ", val
        end if
        
        !polymonial8
        fun_ptr => polymonial8
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 8)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "8th order polymonial: ", val
        end if
        

        !polymonial9
        fun_ptr => polymonial9
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 9)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "9th order polymonial: ", val
        end if
        

        !polymonial10
        fun_ptr => polymonial10
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 10)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "10th order polymonial: ", val
        end if
        

        !my_sin
        fun_ptr => my_sin
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 5)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "sinus: ", val
        end if
        

        !my_exp
        fun_ptr => my_exp
        val = 0.0
        do j = this_image(),20,num_images()
            val = val + int_ptr(ibeg+(j-1)*dx,ibeg+j*dx,fun_ptr, 5)
        end do
        syncall()
        if(this_image() == 1) then
            do j = 2,num_images(),1
                val = val + val[j]
            end do
            write(unit = uni, fmt = format1) "exponenta: ", val
        end if     
    end do

    !cleaning
    close(unit = 11, status = 'KEEP')
    close(unit = 12, status = 'KEEP')
    close(unit = 13, status = 'KEEP')

end program main