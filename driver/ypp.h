/*
         Copyright (C) 2000-2016 the YAMBO team
               http://www.yambo-code.org
 
  Authors (see AUTHORS file for details): AM
  
  This file is distributed under the terms of the GNU 
  General Public License. You can redistribute it and/or 
  modify it under the terms of the GNU General Public 
  License as published by the Free Software Foundation; 
  either version 2, or (at your option) any later version.
 
  This program is distributed in the hope that it will 
  be useful, but WITHOUT ANY WARRANTY; without even the 
  implied warranty of MERCHANTABILITY or FITNESS FOR A 
  PARTICULAR PURPOSE.  See the GNU General Public License 
  for more details.
 
  You should have received a copy of the GNU General Public 
  License along with this program; if not, write to the Free 
  Software Foundation, Inc., 59 Temple Place - Suite 330,Boston, 
  MA 02111-1307, USA or visit http://www.gnu.org/copyleft/gpl.txt.
*/
/*
  declaration
*/
/*
 "e" and "s" commmand line structure
*/
#if defined _FORTRAN_US
 int ypp_i
#else
 int ypp_i_
#endif
(int *, int *,int *,int *,int *,int *,int *,int *,
  char *rnstr2, char *inf, char *id, char *od, char *com_dir, char *js,
  int lni,int iif,int iid,int iod,int icd,int ijs);
/*
 Command line structure
*/
 static Ldes opts[] = { /* Int Real Ch (dummy) Parallel_option*/
  {"help",  "h","Short Help",0,0,0,0,0}, 
  {"lhelp", "H","Long Help",0,0,0,0,0}, 
  {"jobstr","J","Job string identifier",0,0,1,0,1},   
  {"infver","V","Input file verbosity [opt=gen,qp,rt,all]",0,0,1,0,0},    
  {"ifile", "F","Input file",0,0,1,0,1},              
  {"idir",  "I","Core I/O directory",0,0,1,0,1},         
  {"odir",  "O","Additional I/O directory",0,0,1,0,1},        
  {"cdir",  "C","Communications I/O directory",0,0,1,0,1},
  {"nompi", "N","Skip MPI initialization",0,0,0,0,0}, 
  {"bzgrids","k","BZ Grid generator [(k)pt,(q)pt,(s)hifted,(h)igh symmetry,(r)andom]",0,0,1,0,0}, 
  {"QPDBs",  "q","(g)enerate-modify/(m)erge quasi-particle databases",0,0,1,0,0}, 
  {"wannier","w","Wannier 90 interface",0,0,0,0,0}, 
  {"bxsf",   "b","Read BXSF output generated by Wannier90",0,0,0,0,0},
#if defined _YPP_SC  && ! defined _YPP_RT
  {"MeanPot",  "v","Mean Potential",0,0,0,0,0}, 
#endif
#if defined _YPP_ELPH  
  {"electrons","s","Electrons [(w)ave,(d)ensity,(m)ag,do(s),(b)ands,(c)urrent,(e)lias]",0,0,1,0,0}, 
#elif defined _YPP_MAGNETIC 
  {"electrons","s","Electrons [(w)ave,(d)ensity,(m)ag,do(s),(b)ands,(c)urrent,angu(l)ar,(p)osition]",0,0,1,0,0}, 
#else
  {"electrons","s","Electrons [(w)ave,(d)ensity,(m)ag,do(s),(b)ands,(c)urrent]",0,0,1,0,0}, 
#endif
#if defined _YPP_ELPH  && ! defined _YPP_RT
  {"excitons", "e","Excitons  [(s)ort,(sp)in,(a)mplitude,(w)ave,(e)lias,(g)kkp]",0,0,1,0,0}, 
#else
  {"excitons", "e","Excitons  [(s)ort,(sp)in,(a)mplitude,(w)ave]",0,0,1,0,0}, 
#endif
  {"freehole","f","Free hole position [excitons plot]",0,0,0,0,0}, 
  {"kpts_map","m","BZ map fine grid to coarse",0,0,0,0,0}, 
  {"WFs_map", "p","WF perturbative SOC mapping",0,0,0,0,0},
  {"fixsyms", "y","Remove symmetries not consistent with an external perturbation",0,0,0,0,0}, 
#if defined _YPP_RT
  {"RTDBs",   "c","Carriers [(e)nergy,(k)-space,(m)anual]",0,0,1,0,0}, 
  {"RealTime","t","TD-polarization [(X)response,Tr(a)bs]",0,0,1,0,0}, 
  {"RealTime","n","NEQ plot opt#1 [(o)ccupations,(l)ifetimes,(d)ensity]",0,0,2,0,0}, 
  {"DESC",    " ","         opt#2 occ. [(b)ands,(t)ime,(e)nergy,(d)os]",0,0,0,0,0},
  {"DESC",    " ","         opt#2 life [(b)ands,(t)ime,(e)nergy]",0,0,0,0,0},
  {"DESC",    " ","         opt#2 den. [(t)ime]",0,0,0,0,0}, 
#endif
#if defined _YPP_ELPH && ! defined _YPP_RT
  {"phonons","p","Phonon [(d)os,(e)lias,(a)mplitude]",0,0,1,0,0}, 
  {"gkkp"  , "g","gkkp databases",0,0,0,0,0}, 
#endif
#if defined _YPP_SURF
  {"surf", "a","Surface spectroscopy postprocessor [opt=ras,reels,loc,trans]",0,0,1,0,0}, 
#endif
  {NULL,NULL,NULL,0,0,0,0,0}
 };
 char *tool="ypp";
 char *tdesc="Y(ambo) P(ost) P(rocessor)";
