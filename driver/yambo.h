/*
  Copyright (C) 2000-2008 A. Marini and the YAMBO team 
               http://www.yambo-code.org
  
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
 Driver declaration
*/
#if defined _FORTRAN_US
 int yambo_driver
#else
 int yambo_driver_
#endif
 (char *str1,int *,char *inf,int *,char* id,
  int *,char *od,int *,char *com_dir,int *,char *js,int *,int *,int *); 
/*
 Command line structure
*/
 static Ldes opts[] = { /* Int Real Ch (Dummy)*/
  {"help",   "h","Short Help",0,0,0,0},              
  {"lhelp",  "H","Long Help",0,0,0,0},               
  {"jobstr", "J","Job string identifier",0,0,1,0},   
  {"infver", "V","Input file verbosity",1,0,0,0},    
  {"ifile",  "F","Input file",0,0,1,0},              
  {"idir",   "I","Core I/O directory",0,0,1,0},         
  {"odir",   "O","Additional I/O directory",0,0,1,0},   
  {"cdir",   "C","Communications I/O directory",0,0,1,0},  
  {"nompi",  "N","Skip MPI initialization",0,0,0,0}, 
  {"dbpr",   "D","DataBases properties",0,0,0,0},    
  {"dbfrag", "S","DataBases fragmentation",0,0,0,0}, 
  {"setup",  "i","Initialization",0,0,0,0},          
  {"optics", "o","Optics [opt=(c)hi/(b)se/(t)dhf]",0,0,1,0},    
  {"tddft",  "t","The TDDFTs [opt=(a)LDA/(b)SE/(l)RC]",0,0,1,0},     
  {"rim_cut","c","Coulomb interaction",0,0,0,0},  
  {"xxvxc",  "x","Hartree-Fock Self-energy and Vxc",0,0,0,0},      
  {"em1d",   "d","Dynamical Inverse Dielectric Matrix",0,0,0,0},     
  {"em1s",   "b","Static Inverse Dielectric Matrix",0,0,0,0},        
  {"gwapprx","p","GW approximations [opt=(p)PA/c(HOSEX)]",0,0,1,0},              
  {"gw0",    "g","Dyson Equation solver [opt=n(ewton)/s(ecant)/g(reen)]",0,0,1,0}, 
  {"life",   "l","GoWo Quasiparticle lifetimes",0,0,0,0},                  
  {"bss",    "y","BSE solver [opt=h/d/i/t]",0,0,1,0},                      
  {"acfdt",  "a","ACFDT Total Energy",0,0,0,0},                            
#if defined _RAS 
  {"sursp",  "s","Surface Spectroscopy [opt=r(as)/e(el)/b(oth)]",0,0,1,0}, 
#endif
#if defined _REELS
  {"reels",  "r","Surface Spectroscopy (REELS)",0,0,0,0},                  
#endif
#if defined _ELPH || defined _SOLITONS
  {"corrtp", "s","Correlation [opt=e(lectrons)/p(honons)/b(oth)]",0,0,1,0},    
#endif
#if defined _SC | defined _MAGNETIC
  {"scpot",  "v","Self-Consistent Potential [opt=(n)none,(hf),(c)hosex,(exx),(exxc),(h)artree]",0,0,1,0}, 
#endif
#if defined _RT 
  {"scpot",  "v","Self-Consistent Potential [opt=(n)none,(hf),(c)hosex,(exx),(exxc),(h)artree]",0,0,1,0}, 
  {"negf",   "k","Real-time dynamics",0,0,0,0}, 
#endif
  {NULL,NULL,NULL,0,0,0,0}
 };
 char *tool="yambo";
 char *tdesc="A shiny pot of fun and happiness [C.D.Hogan]";
