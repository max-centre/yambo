yambo: ext-libs
	@+LIBS2DO="$(INT_LIBS)"; DIR2GO="lib" ; VPATH="$(topdir)/lib" ; $(mk_internal_lib)
	@+LIBS2DO="$(YLIBDRIVER)"; NAME="yambo_driver_"; DIR2GO="lib/yambo/driver/src"; VPATH="$(topdir)/lib/yambo/driver/src"; ADF="-D_yambo"; $(mk_external_yambo_lib)
	@+LIBS2DO="$(MAIN_LIBS)"; XPATH="src"; VPATH="$(topdir)/src"; $(mk_src)
	@+X2DO="yambo"; XPATH="driver"; VPATH="$(topdir)/driver"; XLIBS="$(MAIN_LIBS_LD)"; DRILIBS="$(YLIBDRIVER_LD)"; $(mk_yambo)
#
# Yambo PROJECTS #
# 
yambo_sc: ext-libs
	@+LIBS2DO="$(INT_LIBS)"; DIR2GO="lib" ; VPATH="$(topdir)/lib" ; $(mk_internal_lib)
	@+LIBS2DO="$(YLIBDRIVER)"; NAME="yambo_sc_driver_"; DIR2GO="lib/yambo/driver/src"; VPATH="$(topdir)/lib/yambo/driver/src"; ADF="-D_SC -D_yambo"; $(mk_external_yambo_lib)
	@+LIBS2DO="$(PJ_SCLIBS)"; XPATH="src"; VPATH="$(topdir)/src"; ADF="-D_SC"; $(mk_src)
	@+X2DO="yambo_sc"; XPATH="driver"; VPATH="$(topdir)/driver"; XLIBS="$(PJ_SCLIBS_LD)" ; DRILIBS="$(YLIBDRIVER_LD)"; ADF="-D_SC"; $(mk_yambo)
yambo_rt: ext-libs
	@+LIBS2DO="$(INT_LIBS)"; DIR2GO="lib" ; VPATH="$(topdir)/lib" ; $(mk_internal_lib)
	@+LIBS2DO="$(YLIBDRIVER)"; NAME="yambo_rt_driver_"; DIR2GO="lib/yambo/driver/src"; VPATH="$(topdir)/lib/yambo/driver/src"; ADF="-D_RT -D_yambo"; $(mk_external_yambo_lib)
	@+LIBS2DO="$(PJ_RTLIBS)"; XPATH="src"; VPATH="$(topdir)/src"; ADF="-D_RT"; $(mk_src)
	@+X2DO="yambo_rt"; XPATH="driver"; VPATH="$(topdir)/driver"; XLIBS="$(PJ_RTLIBS_LD)" ; DRILIBS="$(YLIBDRIVER_LD)"; ADF="-D_RT"; $(mk_yambo)
yambo_nl: ext-libs
	@+LIBS2DO="$(INT_LIBS)"; DIR2GO="lib" ; VPATH="$(topdir)/lib" ; ADF="-D_DOUBLE -D_SLEPC_OFF" ; $(mk_internal_lib)
	@+LIBS2DO="$(YLIBDRIVER)"; NAME="yambo_nl_driver_"; DIR2GO="lib/yambo/driver/src"; VPATH="$(topdir)/lib/yambo/driver/src"; ADF="-D_DOUBLE -D_SLEPC_OFF -D_NL -D_RT -D_yambo"; $(mk_external_yambo_lib)
	@+LIBS2DO="$(PJ_NLLIBS)"; XPATH="src"; VPATH="$(topdir)/src"; ADF="-D_DOUBLE -D_SLEPC_OFF -D_NL -D_RT"; $(mk_src)
	@+X2DO="yambo_nl"; XPATH="driver"; VPATH="$(topdir)/driver"; XLIBS="$(PJ_NLLIBS_LD)" ; DRILIBS="$(YLIBDRIVER_LD)"; ADF="-D_DOUBLE -D_SLEPC_OFF -D_NL -D_RT"; $(mk_yambo)
yambo_ph: ext-libs
	@+LIBS2DO="$(INT_LIBS)"; DIR2GO="lib" ; VPATH="$(topdir)/lib" ; $(mk_internal_lib)
	@+LIBS2DO="$(YLIBDRIVER)"; NAME="yambo_ph_driver_"; DIR2GO="lib/yambo/driver/src"; VPATH="$(topdir)/lib/yambo/driver/src"; ADF="-D_ELPH -D_yambo"; $(mk_external_yambo_lib)
	@+LIBS2DO="$(PJ_PHLIBS)"; XPATH="src"; VPATH="$(topdir)/src"; ADF="-D_ELPH"; $(mk_src)
	@+X2DO="yambo_ph"; XPATH="driver"; VPATH="$(topdir)/driver"; XLIBS="$(PJ_PHLIBS_LD)" ; DRILIBS="$(YLIBDRIVER_LD)"; ADF="-D_ELPH"; $(mk_yambo)
