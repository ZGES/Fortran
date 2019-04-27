module dotmath
    implicit none

    public :: dotmull
    private :: dotmull_kind4, dotmull_kind8, dotmull_kind16
    
    interface dotmull
        procedure dotmull_kind4, dotmull_kind8, dotmull_kind16
    end interface

    contains
        function dotmull_kind4 (A,B) result(C)
            implicit none
            real(kind = 4), intent(in), dimension(:,:) :: A, B
            real(kind = 4), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j
            
            C = 0
            do j = 1, size(B(:,1)), 1
                do i = 1, size(A(1,:)), 1
                    C(i,j) = C(i,j) + dot_product(A(i,:), B(:,j))
                end do
            end do

        end function dotmull_kind4
        
        function dotmull_kind8 (A,B) result(C)
            implicit none
            real(kind = 8), intent(in), dimension(:,:) :: A, B
            real(kind = 8), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j
            
            C = 0
            do j = 1, size(B(:,1)), 1
                do i = 1, size(A(1,:)), 1
                    C(i,j) = C(i,j) + dot_product(A(i,:), B(:,j))
                end do
            end do

        end function dotmull_kind8

        function dotmull_kind16 (A,B) result(C)
            implicit none
            real(kind = 16), intent(in), dimension(:,:) :: A, B
            real(kind = 16), dimension(size(A(1,:)),size(B(:,1))) :: C

            integer :: i, j
            
            C = 0
            do j = 1, size(B(:,1)), 1
                do i = 1, size(A(1,:)), 1
                    C(i,j) = C(i,j) + dot_product(A(i,:), B(:,j))
                end do
            end do
            
        end function dotmull_kind16

end module dotmath