!
!        Copyright (C) 2000-2021 the YAMBO team
!              http://www.yambo-code.org
!
! Authors (see AUTHORS file for details): DS
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
subroutine Dipole_orb_magn_forCD(Xen,Xk,Dip)
 !
 ! This routine returns <L>
 !
 use pars,                ONLY:SP,cI
 use LIVE_t,              ONLY:live_timing
 use electrons,           ONLY:levels,n_sp_pol
 use parallel_m,          ONLY:PAR_IND_DIPk_ibz,PAR_DIPk_ibz_index
 use vec_operate,         ONLY:cross_product
 use R_lattice,           ONLY:bz_samp
 use DIPOLES,             ONLY:DIP_iR,DIP_orbital,DIPOLE_t,DIP_v
 use parallel_m,          ONLY:PAR_IND_DIPk_ibz,PAR_DIPk_ibz_index,PAR_IND_DIPk_ibz_ID,&
&                              PAR_IND_VAL_BANDS_DIP,PAR_IND_VAL_BANDS_DIP_ID,&
&                              PAR_IND_CON_BANDS_DIP,PAR_IND_CON_BANDS_DIP_ID
 !
 implicit none
 !
 type(levels),  intent(in)    :: Xen
 type(bz_samp), intent(in)    :: Xk
 type(DIPOLE_t),intent(inout) :: Dip
 !
 ! Work Space
 !
 integer                      :: ik,ic,iv,ib,i_sp_pol,n_LT_steps,ik_mem
 complex(SP)                  :: DIP_x_loc(3),DIP_v_loc(3)
 !
 n_LT_steps=n_sp_pol*PAR_IND_DIPk_ibz%n_of_elements(PAR_IND_DIPk_ibz_ID+1)*&
&                    PAR_IND_VAL_BANDS_DIP%n_of_elements(PAR_IND_VAL_BANDS_DIP_ID+1)*&
&                    PAR_IND_CON_BANDS_DIP%n_of_elements(PAR_IND_CON_BANDS_DIP_ID+1)
 !
 if (n_LT_steps>0) call live_timing('Dipoles: orbital magnetization',n_LT_steps)
 !
 ! Main loop over k in IBZ
 !
 do i_sp_pol=1,n_sp_pol
   !
   if (n_LT_steps==0) cycle
   ! 
   do ik=1,Xk%nibz
     !
     if (.not.PAR_IND_DIPk_ibz%element_1D(ik)) cycle 
     !
     ik_mem=PAR_DIPk_ibz_index(ik)
     ! 
     do iv=Dip%ib(1),Dip%ib_lim(1) 
       !
       if(.not.PAR_IND_VAL_BANDS_DIP%element_1D(iv)) cycle
       !
       do ic=max(iv,Dip%ib_lim(2)),Dip%ib(2)
         !
         if(.not.PAR_IND_CON_BANDS_DIP%element_1D(ic)) cycle
         !
         do ib=Dip%ib(1),Dip%ib(2)
           !
           DIP_x_loc(:)=-cI*DIP_iR(:,ib,iv,ik_mem,i_sp_pol)
           
           DIP_v_loc(:)=DIP_v(:,ic,ib,ik_mem,i_sp_pol)
           !
           DIP_orbital(:,ic,iv,ik_mem,i_sp_pol,1)=DIP_orbital(:,ic,iv,ik_mem,i_sp_pol,1)+ &
           & cross_product(DIP_x_loc,DIP_v_loc)
           !
           ! DEBUG <
           !write(*,*) "[DIP] writing DIP_orbital(..,ic,iv,ik,,) values"
           ! DEBUG >
           !
         enddo
         !
         call live_timing(steps=1)
         !
       enddo    ! conduction band loop
     enddo      ! valence    band loop
     ! 
   enddo        ! sp_pol loop
   !
 enddo          ! k-points
 !
 call live_timing()
 !
end subroutine Dipole_orb_magn_forCD
