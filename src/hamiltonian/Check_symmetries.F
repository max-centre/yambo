!
!        Copyright (C) 2000-2021 the YAMBO team
!              http://www.yambo-code.org
!
! Authors (see AUTHORS file for details): AM CA DS
!
! This file is distributed under the terms of the GNU
! General Public License. You can redistribute it and/or
! modify it under the terms of the GNU General Public
! License as published by the Free Software Foundation;
! either version 2, or (at your option) any later version.
!
! This program is distributed in the hope that it will
! be useful, but WITHOUT ANY WARRANTY; without even the
! implied warranty of MERCHANTABILITY or FITNESS FOR A
! PARTICULAR PURPOSE.  See the GNU General Public License
! for more details.
!
! You should have received a copy of the GNU General Public
! License along with this program; if not, write to the Free
! Software Foundation, Inc., 59 Temple Place - Suite 330,Boston,
! MA 02111-1307, USA or visit http://www.gnu.org/copyleft/gpl.txt.
!
subroutine Check_symmetries(field_dir,field_kind)
  !
  use pars,          ONLY:SP
  use vec_operate,   ONLY:v_norm
  use matrix_operate,ONLY:m3det
  use com,           ONLY:msg
  use R_lattice,     ONLY:rl_sop
  use D_lattice,     ONLY:nsym
  use stderr,        ONLY:intc
  implicit none
  !
  real(SP),     intent(in)  :: field_dir(3)
  character(*), intent(in)  :: field_kind
  !
  ! Work space
  !
  integer  :: is,nsym_wrong,i_wrong
  real(SP) :: v(3)
  !
  if(v_norm(field_dir)<1.E-5) return
  !
  nsym_wrong=0
  !
  select case(field_kind)
  case("magnetic")
    do is=1,nsym
      v(:) = matmul( rl_sop(:,:,is), field_dir )
      i_wrong=0
      if( all( abs(v(:)-field_dir(:))<1E-5 )) i_wrong=+1
      if( all( abs(v(:)+field_dir(:))<1E-5 )) i_wrong=-1
      if(i_wrong==0) then
        nsym_wrong=nsym_wrong+1
      else
        if( m3det(rl_sop(:,:,is))/i_wrong-1>1E-5 ) nsym_wrong=nsym_wrong+1
      endif
    enddo
  case("electric")
    do is=1,nsym
      v(:) = matmul( rl_sop(:,:,is), field_dir )
      i_wrong=0
      if( v_norm(v(:)-field_dir(:))>1.E-5) nsym_wrong=nsym_wrong+1
    enddo
  case default
    call error(" wrong field kind")  
  end select
  !
  if(nsym_wrong/=0) then
    call msg('s','Detected '//intc(nsym_wrong)//' wrong symmetries (out of '//intc(nsym)//' )')
    call error(' Use ypp -y to repair the symmetry group and restart Yambo ')
  endif
  !
end subroutine Check_symmetries
