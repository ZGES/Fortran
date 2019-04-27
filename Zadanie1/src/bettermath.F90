module bettermath
    implicit none

    public :: bettmull
    private :: bettmull_kind4, bettmull_kind8, bettmull_kind16
    
    interface bettmull
        procedure bettmull_kind4, bettmull_kind8, bettmull_kind16
    end interface

    contains
        function bettmull_kind4 (A,B) result(C)
            implicit none
            real(kind = 4), intent(in), dimension(:,:) :: A, B
            real(kind = 4), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j, k
            
            C = 0
            do j = 1, size(B(:,1)), 1
                do k = 1, size(A(:,1)), 1
                    do i = 1, size(A(1,:)), 1
                        C(i,j) = C(i,j) + A(i,k)*B(k,j) 
                    end do
                end do
            end do

        end function bettmull_kind4

        function bettmull_kind8 (A,B) result(C)
            implicit none
            real(kind = 8), intent(in), dimension(:,:) :: A, B
            real(kind = 8), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j, k
            
            C = 0
            do j = 1, size(B(:,1)), 1
                do k = 1, size(A(:,1)), 1
                    do i = 1, size(A(1,:)), 1
                        C(i,j) = C(i,j) + A(i,k)*B(k,j) 
                    end do
                end do
            end do

        end function bettmull_kind8

        function bettmull_kind16 (A,B) result(C)
            implicit none
            real(kind = 16), intent(in), dimension(:,:) :: A, B
            real(kind = 16), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j, k
            
            C = 0
            do j = 1, size(B(:,1)), 1
                do k = 1, size(A(:,1)), 1
                    do i = 1, size(A(1,:)), 1
                        C(i,j) = C(i,j) + A(i,k)*B(k,j) 
                    end do
                end do
            end do

        end function bettmull_kind16

end module bettermath