!
!        Copyright (C) 2000-2021 the YAMBO team
!              http://www.yambo-code.org
!
! Authors (see AUTHORS file for details): AM
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
subroutine REPORT_Occupations(what,E)
 !
 use pars,          ONLY:SP,schlen,msg_len
 use units,         ONLY:HA2EV,BO2ANG,HA2EV,HA2KEL
 use D_lattice,     ONLY:Tel,Bose_Temp,DL_vol
 use drivers,       ONLY:Finite_Tel
 use com,           ONLY:msg
 use electrons,     ONLY:levels,n_sp_pol,nel,spin_string,spin_occ
 use interfaces,    ONLY:OCCUPATIONS_Gaps
 !
 implicit none
 !
 character(*)::what
 type(levels)::E
 ! 
 ! Work Space
 ! 
 integer           ::i_sp_pol,Nbf(n_sp_pol),Nbm(n_sp_pol),title_len
 character(schlen) ::title
 real(SP)          ::N_met,f_met,val(10,2,1+(n_sp_pol-1)*2)
 real(SP)          ::E_g_dir(1+(n_sp_pol-1)*2,2) ! min gap - max gap
 real(SP)          ::E_g_ind(1+(n_sp_pol-1)*2,3) ! min - val. band width - cond. band width
 integer           ::E_k_dir(1+(n_sp_pol-1)*2), E_k_ind(n_sp_pol,2),I_dir(2)
 !
 ! Title
 !
 title=""
 title_len=0
 if (len_trim(what)>0) then 
   title_len=3+len_trim(what)
   title="["//trim(what)//"] "
 endif
 !
 ! Gaps, VBM/CBM
 !
 call OCCUPATIONS_Gaps(E,E_g_dir,E_g_ind,Nbf,Nbm,I_dir,E_k_dir,E_k_ind)
 !
 ! Initial Report
 !
 if (n_sp_pol==1) call msg('r',title(1:title_len)//"=== General ===")
 if (n_sp_pol==2) call msg('r',title(1:title_len)//"=== Spin Independent ===")
 call msg('r',COMPOSE_msg('Electronic Temperature',0),(/Tel*HA2EV,Tel*HA2KEL/),'[eV K]')
 call msg('r',COMPOSE_msg('Bosonic    Temperature',0),(/Bose_Temp*HA2EV,Bose_Temp*HA2KEL/),'[eV K]')
 call msg('r',COMPOSE_msg('Finite Temperature mode',0),Finite_Tel)
 call msg('r',COMPOSE_msg('El. density',0),(/nel/(DL_vol*BO2ANG**3*1.E-24)/),'[cm-3]')
 call msg('rn',COMPOSE_msg('Fermi Level',0),E%E_Fermi*HA2EV,'[eV]')
 !
 do i_sp_pol=1,n_sp_pol
   !
   if (n_sp_pol==2) then
     call msg('r',title(1:title_len)//"=== Spin "//spin_string(i_sp_pol)//" channel ===")
   else
     call msg('r',title(1:title_len)//"=== Gaps and Widths ===")
   endif
   !
   call msg('r',COMPOSE_msg('Conduction Band Min',i_sp_pol),E%E_CBm(i_sp_pol)*HA2EV,'[eV]')
   call msg('r',COMPOSE_msg('Valence Band Max',i_sp_pol),E%E_VBM(i_sp_pol)*HA2EV,'[eV]')
   !
   if (Nbf(i_sp_pol)> 0) then
     call msg('r',COMPOSE_msg('Filled Bands',i_sp_pol),Nbf(i_sp_pol))
   endif
   !
   if (Nbm(i_sp_pol)>Nbf(i_sp_pol)) then
     call msg('r',COMPOSE_msg('Metallic Bands',i_sp_pol), (/Nbf(i_sp_pol)+1,Nbm(i_sp_pol)/))
   endif
   !
   if (E%nb>Nbm(i_sp_pol)) then
     call msg('r',COMPOSE_msg('Empty Bands',i_sp_pol),(/Nbm(i_sp_pol)+1,E%nb/)) 
   endif
   !
   if (Nbf(i_sp_pol)==Nbm(i_sp_pol).and.Nbf(i_sp_pol)>0) then
     call msg('r',COMPOSE_msg('Direct Gap',i_sp_pol),E_g_dir(i_sp_pol+(n_sp_pol-1),1)*HA2EV,'[eV]')
     call msg('r',COMPOSE_msg('Direct Gap localized at k-point ',i_sp_pol),E_k_dir(i_sp_pol+(n_sp_pol-1)))
     if (E%nk>1) then
       call msg('r',COMPOSE_msg('Indirect Gap',i_sp_pol),E_g_ind(i_sp_pol+(n_sp_pol-1),1)*HA2EV,'[eV]')
       call msg('r',COMPOSE_msg('Indirect Gap between k-points ',i_sp_pol),E_k_ind(i_sp_pol,:))
       call msg('r',COMPOSE_msg('Last valence band width',i_sp_pol),E_g_ind(i_sp_pol+(n_sp_pol-1),2)*HA2EV,'[eV]')
       call msg('r',COMPOSE_msg('1st conduction band width',i_sp_pol),E_g_ind(i_sp_pol+(n_sp_pol-1),3)*HA2EV,'[eV]')
     endif
   endif
   !
   call msg('r',' ')
   !
 enddo
 !
 if (n_sp_pol==2) then
   if (all(Nbf==Nbm).and.all(Nbf>0)) then
     call msg('r',title(1:title_len)//"=== Overall gap ===")
     call msg('r',COMPOSE_msg('Direct Gap',3),E_g_dir(1,1)*HA2EV,'[eV]')
     call msg('r',COMPOSE_msg('Direct Gap localized at k-point',3),E_k_dir(1))
     if (E%nk>1) then
       call msg('r',COMPOSE_msg('Indirect Gap',3),E_g_ind(1,1)*HA2EV,'[eV]')
       call msg('r',COMPOSE_msg('Indirect Gap between k-points',3),(/E_k_ind(1,1),E_k_ind(2,2)/))
     endif
   endif
 endif
 !
 ! Report if the system is treated as a metal
 !
 if (.not.all(Nbf==Nbm)) then
   !
   call msg('r',title(1:title_len)//"=== Metallic Characters ===")
   !
   N_met=0
   f_met=0
   do i_sp_pol=1,n_sp_pol
     f_met=f_met+sum(E%f(Nbf(i_sp_pol)+1:Nbm(i_sp_pol),:,i_sp_pol))/sum(spin_occ*real(E%nk*(Nbm(:)-Nbf(:))))
     N_met=N_met+sum(E%f(Nbf(i_sp_pol)+1:Nbm(i_sp_pol),:,i_sp_pol))/real(E%nk)
   enddo
   !
   call msg('r',COMPOSE_msg('N of el / N of met el',0),(/nel,N_met/))
   call msg('r',COMPOSE_msg('Average metallic occ.',0),(/f_met/))
   !
   if (n_sp_pol==1) call warning(COMPOSE_msg('Metallic system',0))
   if (n_sp_pol==2) then
     if(all(Nbf/=Nbm)) call warning(COMPOSE_msg('Metallic system',0))
     if(any(Nbf==Nbm)) call warning(COMPOSE_msg('System is an half-metal',0))
   endif
   !
 endif
 !
 call msg('r','')
 !
 contains
   !
   character(msg_len) function COMPOSE_msg(msg_,i_spin)
     use com,  ONLY:com_compose_msg
     character(*) :: msg_
     integer      :: i_spin
     !ws
     character(schlen) :: spin_ch
     spin_ch=" "
     if (n_sp_pol==2.and.i_spin==1) spin_ch="  [spin UP]"
     if (n_sp_pol==2.and.i_spin==2) spin_ch=" [spin DN]"
     COMPOSE_msg=com_compose_msg(title(1:title_len),msg_,spin_ch)
   end function
   !
end subroutine
