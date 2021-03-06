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
subroutine INTERPOLATION_integral_respect(ID,OUT_k,OUT,NK)
 !
 use pars,         ONLY:SP
 use R_lattice,    ONLY:bz_samp
 use interpolate,  ONLY:INTERP_obj,INTERP_FineGd
 !
 implicit none
 !
 integer      , intent(in)    :: ID,NK
 type(bz_samp), intent(in)    :: OUT_k
 real(SP)     , intent(inout) :: OUT(INTERP_obj(ID)%nb(1):INTERP_obj(ID)%nb(2),NK,INTERP_obj(ID)%D)
 !
 ! Work Space
 !
 integer  :: i1,ik,i3
 real(SP) :: INTERP_int(10),ORI_int(10)
 !
 INTERP_int=0._SP
 ORI_int   =0._SP
 !
 do i1=INTERP_obj(ID)%nb(1),INTERP_obj(ID)%nb(2)
   do ik=1,INTERP_obj(ID)%nk
     do i3=1,INTERP_obj(ID)%D
       ORI_int(i3)=ORI_int(i3)+INTERP_obj(ID)%SEED(i1,ik,i3)*INTERP_obj(ID)%weights(ik)
     enddo
   enddo
 enddo
 !
 do i1=INTERP_obj(ID)%nb(1),INTERP_obj(ID)%nb(2)
   do ik=1,NK
     do i3=1,INTERP_obj(ID)%D
       if (trim(INTERP_FineGd)=="NONE") INTERP_int(i3)=INTERP_int(i3)+OUT(i1,ik,i3)*OUT_k%weights(ik)
       if (trim(INTERP_FineGd)=="IBZ")  INTERP_int(i3)=INTERP_int(i3)+OUT(i1,ik,i3)*OUT_k%FGibz%weights(ik)
       if (trim(INTERP_FineGd)=="BZ")   INTERP_int(i3)=INTERP_int(i3)+OUT(i1,ik,i3)*OUT_k%FGbz%weights(ik)
       if (trim(INTERP_FineGd)=="BARE") INTERP_int(i3)=INTERP_int(i3)+OUT(i1,ik,i3)*OUT_k%FGbare%weights(ik)
     enddo
   enddo
 enddo
 !
 do i1=INTERP_obj(ID)%nb(1),INTERP_obj(ID)%nb(2)
   do ik=1,NK
     do i3=1,INTERP_obj(ID)%D
       if (abs(INTERP_int(i3))>0._SP) OUT(i1,ik,i3)=OUT(i1,ik,i3)*ORI_int(i3)/INTERP_int(i3)
     enddo
   enddo
 enddo
 !
end subroutine INTERPOLATION_integral_respect
