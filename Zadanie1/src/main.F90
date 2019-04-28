program main
    
    use naivemath
    use bettermath
    use dotmath

    implicit none

    real(kind = 4), dimension(:,:), allocatable :: A4, B4
    real(kind = 8), dimension(:,:), allocatable :: A8, B8
    real(kind = 16), dimension(:,:), allocatable :: A16, B16
    character(:), allocatable :: format1

    format1 = "(I4, A1, F18.16)"

    call init()

    call time_measure()

    call clean()

    contains
        subroutine init()
            implicit none

            open(unit = 20, file = "wyniki4-n.txt", status = 'REPLACE')
            open(unit = 21, file = "wyniki8-n.txt", status = 'REPLACE')
            open(unit = 22, file = "wyniki16-n.txt", status = 'REPLACE')
            open(unit = 23, file = "wyniki4-b.txt", status = 'REPLACE')
            open(unit = 24, file = "wyniki8-b.txt", status = 'REPLACE')
            open(unit = 25, file = "wyniki16-b.txt", status = 'REPLACE')
            open(unit = 26, file = "wyniki4-d.txt", status = 'REPLACE')
            open(unit = 27, file = "wyniki8-d.txt", status = 'REPLACE')
            open(unit = 28, file = "wyniki16-d.txt", status = 'REPLACE')
            open(unit = 29, file = "wyniki4-m.txt", status = 'REPLACE')
            open(unit = 30, file = "wyniki8-m.txt", status = 'REPLACE')
            open(unit = 31, file = "wyniki16-m.txt", status = 'REPLACE')

        end subroutine init

        subroutine randomize_matrix(N)
            implicit none

            integer, intent(in) :: N
            integer :: I

            do I = 1, N, 1
                call random_number(A4(I,:))
                call random_number(B4(I,:))
                call random_number(A8(I,:))
                call random_number(B8(I,:))
                call random_number(A16(I,:))
                call random_number(B16(I,:))
            end do

        end subroutine randomize_matrix

        subroutine time_measure()
            implicit none

            integer :: N, I
            real :: time_start, time_stop, ntime4, ntime8, ntime16, btime4, btime8, btime16, &
            dtime4, dtime8, dtime16, mtime4, mtime8, mtime16
            real(kind = 4), dimension(:,:), allocatable :: C4
            real(kind = 8), dimension(:,:), allocatable :: C8
            real(kind = 16), dimension(:,:), allocatable :: C16

            N = 10

            do
                if(N > 1280) then
                    exit
                end if

                ntime4 = 0
                ntime8 = 0
                ntime16 = 0
                btime4 = 0
                btime8 = 0
                btime16 = 0
                dtime4 = 0
                dtime8 = 0
                dtime16 = 0
                mtime4 = 0
                mtime8 = 0
                mtime16 = 0

                do I = 1, 40, 1
                    call randomize_matrix(N)

                    call cpu_time(time_start)
                        C4 = naivmull(A4,B4)
                    call cpu_time(time_stop)
                    ntime4 = ntime4 + time_stop - time_start
        
                    call cpu_time(time_start)
                        C8 = naivmull(A8,B8)
                    call cpu_time(time_stop)
                    ntime8 = ntime8 + time_stop - time_start
        
                    call cpu_time(time_start)
                        C16 = naivmull(A16,B16)
                    call cpu_time(time_stop)
                    ntime16 = ntime16 + time_stop - time_start
                    
                    call cpu_time(time_start)
                        C4 =  bettmull(A4,B4)
                    call cpu_time(time_stop)
                    btime4 = btime4 + time_stop - time_start
        
                    call cpu_time(time_start)
                        C8 = bettmull(A8,B8)
                    call cpu_time(time_stop)
                    btime8 = btime8 + time_stop - time_start
        
                    call cpu_time(time_start)
                        C16 = bettmull(A16,B16)
                    call cpu_time(time_stop)
                    btime16 = btime16 + time_stop - time_start
        
                    call cpu_time(time_start)
                        C4 = dotmull(A4,B4)
                    call cpu_time(time_stop)
                    dtime4 = dtime4 + time_stop - time_start
        
                    call cpu_time(time_start)
                        C8 = dotmull(A8,B8)
                    call cpu_time(time_stop)
                    dtime8 = dtime8 + time_stop - time_start
        
                    call cpu_time(time_start)
                        C16 = dotmull(A16,B16)
                    call cpu_time(time_stop)
                    dtime16 = dtime16 + time_stop - time_start

                    call cpu_time(time_start)
                        C4 = matmul(A4,B4)
                    call cpu_time(time_stop)
                    mtime4 = mtime4 + time_stop - time_start

                    call cpu_time(time_start)
                        C8 = matmul(A8,B8)
                    call cpu_time(time_stop)
                    mtime8 = mtime8 + time_stop - time_start

                    call cpu_time(time_start)
                        C16 = matmul(A16,B16)
                    call cpu_time(time_stop)
                    mtime16 = mtime16 + time_stop - time_start

                end do
                
                write(unit = 20, fmt = format1) N, " ", ntime4*10000
                write(unit = 21, fmt = format1) N, " ", ntime8*10000
                write(unit = 22, fmt = format1) N, " ", ntime16*10000
                write(unit = 23, fmt = format1) N, " ", btime4*10000
                write(unit = 24, fmt = format1) N, " ", btime8*10000
                write(unit = 25, fmt = format1) N, " ", btime16*10000
                write(unit = 26, fmt = format1) N, " ", dtime4*10000
                write(unit = 27, fmt = format1) N, " ", dtime8*10000
                write(unit = 28, fmt = format1) N, " ", dtime16*10000
                write(unit = 29, fmt = format1) N, " ", mtime4*10000
                write(unit = 30, fmt = format1) N, " ", mtime8*10000
                write(unit = 31, fmt = format1) N, " ", mtime16*10000

                N = N*2

            end do

        end subroutine time_measure

        subroutine clean()
            implicit none

            close(unit = 20, status = 'KEEP')
            close(unit = 21, status = 'KEEP')
            close(unit = 22, status = 'KEEP')
            close(unit = 23, status = 'KEEP')
            close(unit = 24, status = 'KEEP')
            close(unit = 25, status = 'KEEP')
            close(unit = 26, status = 'KEEP')
            close(unit = 27, status = 'KEEP')
            close(unit = 28, status = 'KEEP')
            close(unit = 29, status = 'KEEP')
            close(unit = 30, status = 'KEEP')
            close(unit = 31, status = 'KEEP')

        end subroutine clean

end program main