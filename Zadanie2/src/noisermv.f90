program noisermv

    use, intrinsic :: iso_c_binding
    use ifport

    implicit none

    include "fftw3.f03"

    real(C_DOUBLE), dimension(:), allocatable :: tSigArray !arary for values depended on time(base, noisy and cleared signal)
    complex(C_DOUBLE_COMPLEX), dimension(:), allocatable :: fSigArray !arary for values depended on time(noisy and cleared fft)

    type(C_PTR) :: planr2c
    type(C_PTR) :: planc2r

    integer, parameter :: freq = 2048 !frecuency of sampling
    real :: stime = 0.0 !represents time when the sample was taken
    real :: interval = 7/real(freq-1) !difference between two time measures

    integer :: it !iterator
    real :: rand1 !noises in our signal
    character(:), allocatable :: format1
    character(:), allocatable :: format2

    format1 = "(F13.10,A1,F22.16)"
    format2 = "(I3,A1,F21.16)"

    !initialization
    allocate(tSigArray(freq))
    allocate(fSigArray(freq/2 + 1))
    open(unit = 11, file = "../res/cosSignal.txt", status = 'REPLACE')
    open(unit = 12, file = "../res/noisySignal.txt", status = 'REPLACE')
    open(unit = 13, file = "../res/noisyFftSignal.txt", status = 'REPLACE')
    open(unit = 14, file = "../res/clearedFftSignal.txt", status = 'REPLACE')
    open(unit = 15, file = "../res/clearedSignal.txt", status = 'REPLACE')
    call srand(86456)


    do it = 1, freq
        !base signal
        tSigArray(it) = cos(stime)
        write(unit = 11, fmt = format1) stime, " ", tSigArray(it)

        !noisy signal
        rand1 = rand(0)
        tSigArray(it) = tSigArray(it) + rand1
        write(unit = 12, fmt = format1) stime, " ", tSigArray(it)
        
        stime = stime+interval
    end do

    !executing fft on noisy signal 
    planr2c = fftw_plan_dft_r2c_1d(size(tSigArray), tSigArray, fSigArray, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(planr2c, tSigArray, fSigArray)

    do it = 1, freq/2+1
        !noisy fft
        write(unit = 13, fmt = format2) it, " ", abs(fSigArray(it))

        !cleaning fft
        if(abs(fSigArray(it))<50) then
            fSigArray(it) = 0.0
        end if
        write(unit = 14, fmt = format2) it, " ", abs(fSigArray(it))
    end do

    !executing inverse fft on cleared fft 
    planc2r = fftw_plan_dft_c2r_1d(size(tSigArray), fSigArray, tSigArray, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_c2r(planc2r, fSigArray, tSigArray)

    stime = 0.0
    do it = 1, freq
        !cleared signal
        write(unit = 15, fmt = format1) stime, " ", tSigArray(it)/freq
        stime = stime+interval
    end do

    !clean
    call fftw_destroy_plan(planr2c)
    call fftw_destroy_plan(planc2r)
    if(allocated(tSigArray)) deallocate(tSigArray)
    if(allocated(fSigArray)) deallocate(fSigArray)
    close(unit = 11, status = 'KEEP')
    close(unit = 12, status = 'KEEP')
    close(unit = 13, status = 'KEEP')
    close(unit = 14, status = 'KEEP')
    close(unit = 15, status = 'KEEP')

end program noisermv