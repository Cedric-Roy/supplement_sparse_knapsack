#@file    Makefile
#@brief   Makefile for SCIP-GNN
#@author  Christopher Hojny

#-----------------------------------------------------------------------------
# path
#-----------------------------------------------------------------------------

SCIPDIR         =       $(SCIP_PATH)

#----------------------------------------------------------------------------
# include default project Makefile from SCIP (need to do this twice, once to
# find the correct binary, then, after getting the correct flags from the
# binary (which is necessary since the ZIMPL flags differ from the default
# if compiled with the SCIP Optsuite instead of SCIP), we need to set the
# compile flags, e.g., for the ZIMPL library, which is again done in make.project
#----------------------------------------------------------------------------
include $(SCIPDIR)/make/make.project
-include $(SCIPDIR)/make/local/make.$(HOSTNAME)
-include $(SCIPDIR)/make/local/make.$(HOSTNAME).$(COMP)
-include $(SCIPDIR)/make/local/make.$(HOSTNAME).$(COMP).$(OPT)
SCIPVERSION			:=$(shell $(SCIPDIR)/bin/scip.$(BASE).$(LPS).$(TPI)$(EXEEXTENSION) -v | sed -e 's/$$/@/')
override ARCH		:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* ARCH=\([^@]*\).*/\1/')
override EXPRINT	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* EXPRINT=\([^@]*\).*/\1/')
override GAMS		:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* GAMS=\([^@]*\).*/\1/')
override GMP		:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* GMP=\([^@]*\).*/\1/')
override SYM		:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* SYM=\([^@]*\).*/\1/')
override IPOPT		:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* IPOPT=\([^@]*\).*/\1/')
override IPOPTOPT	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* IPOPTOPT=\([^@]*\).*/\1/')
override LPSCHECK	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* LPSCHECK=\([^@]*\).*/\1/')
override LPSOPT 	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* LPSOPT=\([^@]*\).*/\1/')
override NOBLKBUFMEM	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* NOBLKBUFMEM=\([^@]*\).*/\1/')
override NOBLKMEM	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* NOBLKMEM=\([^@]*\).*/\1/')
override NOBUFMEM	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* NOBUFMEM=\([^@]*\).*/\1/')
override PARASCIP	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* PARASCIP=\([^@]*\).*/\1/')
override READLINE	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* READLINE=\([^@]*\).*/\1/')
override SANITIZE	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* SANITIZE=\([^@]*\).*/\1/')
override ZIMPL		:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* ZIMPL=\([^@]*\).*/\1/')
override ZIMPLOPT	:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* ZIMPLOPT=\([^@]*\).*/\1/')
override ZLIB		:=$(shell echo "$(SCIPVERSION)" | sed -e 's/.* ZLIB=\([^@]*\).*/\1/')
include $(SCIPDIR)/make/make.project
-include $(SCIPDIR)/make/local/make.$(HOSTNAME)
-include $(SCIPDIR)/make/local/make.$(HOSTNAME).$(COMP)
-include $(SCIPDIR)/make/local/make.$(HOSTNAME).$(COMP).$(OPT)


#-----------------------------------------------------------------------------
# default settings
#-----------------------------------------------------------------------------

LIBPATH		=	lib
USRCFLAGS	+=      -isystem$(LIBPATH)
USRCXXFLAGS	+=      -isystem$(LIBPATH)

OPT		=	dbg
LPS		=	spx2
VERSION		=	1.0
CONTINUE        =       false
LOCK            =       false
TEST            =       simple
SETTINGS        =       default
TIME            =       3600
NODES           =       2100000000
MEM             =       20000
DISPFREQ        =       10000
PERMUTE         =       0
ONLYPRE         =       false
SETCUTOFF       =       false
TEST		=
EXCLUSIVE	=	true
QUEUETYPE               =       srun
QUEUE                   =       moskito
PPN                     =       -1
MEM                     =       27000
CLIENTTMPDIR            =       /tmp
NOWAITCLUSTER           =       1
EXCLUSIVE               =       true
override DEBUGTOOL      =       none


#-----------------------------------------------------------------------------
# Programs
#-----------------------------------------------------------------------------

SCIP		=	scip

SCIPOBJ		=	cons_knapsack.o \
			myscipdefplugins.o \
			main.o \
			prop_symmetry.o

SCIPSRC		=	cons_knapsack.c \
			myscipdefplugins.c \
			main.cpp \
			prop_symmetry.c

SCIPOBJFILES 	=	$(addprefix $(OBJDIR)/,$(SCIPOBJ))
SCIPSRCFILES 	=	$(addprefix $(SRCDIR)/,$(SCIPSRC))
SCIPDEP	  	=	$(SRCDIR)/depend.$(SCIPSRC)
SCIPFILE	=	$(BINDIR)/$(SCIP).$(BASE).$(LPS)$(EXEEXTENSION)

#-----------------------------------------------------------------------------
# Rules
#-----------------------------------------------------------------------------

ifeq ($(VERBOSE),false)
.SILENT:	$(SCIPFILE) $(SCIPOBJFILES)
endif

.PHONY: all
all:            $(LIBDIR) $(SCIPDIR) $(SCIPFILE)

# ----------- tests -------------

.PHONY: testcluster
testcluster:
	cd check; \
	$(SHELL) ./check_cluster.sh $(TEST) $(SCIPFILE) $(SETTINGS) \
	$(notdir $(SCIPFILE)).$(HOSTNAME) $(TIME) $(NODES) $(MEM) \
	$(DISPFREQ) $(CONTINUE) $(VERSION) \
	$(LPS) $(QUEUE) $(QUEUETYPE) $(PPN) $(CLIENTTMPDIR) $(NOWAITCLUSTER) $(PERMUTE) $(SETCUTOFF) $(EXCLUSIVE);

# ----------- others -------------
.PHONY: doc
doc:
		cd doc; $(DOXY) scip.dxy

$(OBJDIR):
		@-mkdir -p $(OBJDIR)

$(BINDIR):
		@-mkdir -p $(BINDIR)

$(LIBDIR):
		@-mkdir -p lib;

.PHONY: tags
tags:
		rm -f TAGS; ctags -e src/*.c src/*.h $(SCIPDIR)/src/scip/*.c $(SCIPDIR)/src/scip/*.h;

.PHONY: clean
clean:		$(OBJDIR)
ifneq ($(OBJDIR),)
		@-(rm -f $(OBJDIR)/*.o $(OBJDIR)/*.d && rmdir $(OBJDIR));
		@echo "-> remove main objective files"
endif
		@-rm -f $(MAINFILE) $(MAINLINK) $(MAINSHORTLINK)
		@echo "-> remove binary"

.PHONY: depend
depend:		$(SCIPDIR)
		$(SHELL) -ec '$(DCXX) $(FLAGS) $(DFLAGS) $(SCIPSRCFILES) \
		| sed '\''s|^\([0-9A-Za-z\_]\{1,\}\)\.o *: *$(SRCDIR)/\([0-9A-Za-z_/]*\).c|$$\(OBJDIR\)/\2.o: $(SRCDIR)/\2.c|g'\'' \
		>$(SCIPDEP)'

# include dependencies
-include	$(SCIP)



# link targets
$(SCIPFILE): $(BINDIR) $(OBJDIR) $(SCIPLIBFILE) $(LPILIBFILE) $(SCIPOBJFILES)
		@echo "-> linking $@"
ifdef LINKCCSCIPALL
		-$(CXX) $(SCIPOBJFILES) $(LINKCCSCIPALL) -o $@
else
		-$(CXX) $(SCIPOBJFILES) -L$(SCIPDIR)/lib -l$(SCIPLIB) -l$(OBJSCIPLIB) -l$(LPILIB) -l$(NLPILIB) $(OFLAGS) $(LPSLDFLAGS) $(LDFLAGS) -o $@
endif


# ----------------------------------------------------------------------------
$(OBJDIR)/%.o:	$(SRCDIR)/%.c
		@echo "-> compiling $@"
		$(CC) $(FLAGS) $(OFLAGS) $(BINOFLAGS) $(CFLAGS) $(CC_c) $< $(CC_o)$@

$(OBJDIR)/%.o:	$(SRCDIR)/%.cpp
		@echo "-> compiling $@"
		$(CXX) $(FLAGS) $(OFLAGS) $(LIBOFLAGS) $(CXXFLAGS) $(CXX_c)$< $(CXX_o)$@

# --- EOF ---------------------------------------------------------------------
