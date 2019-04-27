module naivemath
    implicit none

    public :: naivmull
    private :: naivmull_kind4, naivmull_kind8, naivmull_kind16
    
    interface naivmull
        procedure naivmull_kind4, naivmull_kind8, naivmull_kind16
    end interface

    contains
        function naivmull_kind4 (A,B) result(C)
            implicit none
            real(kind = 4), intent(in), dimension(:,:) :: A, B
            real(kind = 4), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j, k

            do i = 1, size(A(1,:)), 1
                do j = 1, size(B(:,1)), 1
                    C(i,j) = 0
                    do k = 1, size(A(:,1)), 1
                        C(i,j) = C(i,j) + A(i,k)*B(k,j) 
                    end do
                end do
            end do

        end function naivmull_kind4

        function naivmull_kind8 (A,B) result(C)
            implicit none
            real(kind = 8), intent(in), dimension(:,:) :: A, B
            real(kind = 8), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j, k

            do i = 1, size(A(1,:)), 1
                do j = 1, size(B(:,1)), 1
                    C(i,j) = 0
                    do k = 1, size(A(:,1)), 1
                        C(i,j) = C(i,j) + A(i,k)*B(k,j) 
                    end do
                end do
            end do
            
        end function naivmull_kind8

        function naivmull_kind16 (A,B) result(C)
            implicit none
            real(kind = 16), intent(in), dimension(:,:) :: A, B
            real(kind = 16), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j, k

            do i = 1, size(A(1,:)), 1
                do j = 1, size(B(:,1)), 1
                    C(i,j) = 0
                    do k = 1, size(A(:,1)), 1
                        C(i,j) = C(i,j) + A(i,k)*B(k,j) 
                    end do
                end do
            end do
            
        end function naivmull_kind16

end module naivemath