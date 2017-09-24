SUBROUTINE WRITE_RESULTS_DIAGONAL(np,nx,ny,x,y,phi,phiW,phiE)
!
implicit none
!
! variables passed in
integer, intent(inout) :: np,nx,ny
real, dimension(np), intent(inout) :: phi
real, dimension(ny), intent(inout) :: y
real, dimension(nx), intent(inout) :: x
real :: phiW,phiE
!
! variables used only in this subroutine
integer :: diag_index,ii,jj
real phi_exact
!--------------------------------------------------------------------------!
!
!...Write the results (phi distribution) to a file
!
!--------------------------------------------------------------------------!
open(unit=7,file='phi_distr.dat',ACTION="write", STATUS="replace")
do ii = 1,nx
   do jj = 1,ny
      write(7,301)x(ii),y(jj),phi((ii-1)*ny+jj)
   end do
   write(7,*)
end do
close(7)
!--------------------------------------------------------------------------!
!
!...Write phi and the exact solution along the diagonal to a file
!
!--------------------------------------------------------------------------!
open(unit=8,file='phi_diagonal.dat',ACTION="write", STATUS="replace")
!
do ii = 1,nx
   !
   !   Write the exact solution (no diffusion...discontinuity halfway across
   !   the domain)
   !
   if (ii <= nx/2) then ! check if past halfway across diagonal
      phi_exact = phiW
   else 
      phi_exact = phiE
   end if
   ! 
   !   Compute index of the cell on the diagonal from (0, ymax) -> (xmax, 0)
   !   Write to a file
   diag_index = ii*ny - (ii-1)
   write(8,201)y(ii),phi(diag_index),phi_exact
end do
!
!   Close the output file
close(8)
!
201 format(3x,f7.2,3x,f7.2,3x,f7.2)
301 format(3x,f7.2,3x,f7.2,3x,f7.2,3x,f7.2,3x,f7.2,3x,f7.2)
!
END SUBROUTINE WRITE_RESULTS_DIAGONAL
