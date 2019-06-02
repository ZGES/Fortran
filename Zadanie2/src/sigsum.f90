program sigsum
    
    use, intrinsic :: iso_c_binding

    implicit none

    include "fftw3.f03"

    real(C_DOUBLE), dimension(:), allocatable :: sumSinArray !array for sum of signlas
    complex(C_DOUBLE_COMPLEX), dimension(:), allocatable :: resSinArray !array for result of fft

    type(C_PTR) plan !plan on which will operate fft algorithm

    real, parameter :: Pi = 4*atan(1.0)
    integer, parameter :: frec = 1024 !frecuency of sampling
    real :: stime = 0.0 !represents time when the sample was taken
    real :: interval = 1/real(frec-1) !difference between two time measures
    
    integer :: it !iterator
    character(:), allocatable :: format1
    character(:), allocatable :: format2

    format1 = "(F13.10,A1,F19.16)"
    format2 = "(I3,A1,F20.16)"

    !initialization
    allocate(sumSinArray(frec))
    allocate(resSinArray(frec/2 + 1))
    open(unit = 11, file = "../res/sumSignal.txt", status = 'REPLACE')
    open(unit = 12, file = "../res/fftSignal.txt", status = 'REPLACE')


    do it = 1, frec
        sumSinArray(it) = sin(2*Pi*stime*100) + 2*sin(2*PI*stime*350)
        write(unit = 11, fmt = format1) stime, " ", sumSinArray(it)
        stime = stime+interval
    end do

    !executing fft on signal in sumSinArray
    plan = fftw_plan_dft_r2c_1d(size(sumSinArray), sumSinArray, resSinArray, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(plan, sumSinArray, resSinArray)

    do it = 1, frec/2+1
        write(unit = 12, fmt = format2) it, " ", abs(resSinArray(it))
    end do

    !clean
    call fftw_destroy_plan(plan)
    if(allocated(sumSinArray)) deallocate(sumSinArray)
    if(allocated(resSinArray)) deallocate(resSinArray)
    close(unit = 11, status = 'KEEP')
    close(unit = 12, status = 'KEEP')

end program sigsum