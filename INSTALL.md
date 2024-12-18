# Installation Instructions

This file explains how to install the code, which has been used for the paper

> Computational Aspects of Lifted Cover Inequalities for Knapsack with Few Different Weights

by Christopher Hojny and Cédric Roy.

Here is what you have to do to get the code running:

1. Download SCIP from [https://scipopt.org/](https://scipopt.org/). We recommend to use at least version 9.0.1, because the code has not been tested with older versions.

2. Install SCIP and compile it as described in the INSTALL file of SCIP's main
   directory with your individual settings. Make sure to create the necessary
   softlinks in SCIP's lib directory.

    To replicate the results from the above paper, we recommend to use the compilation
    command "make LPS=spx OPT=opt", i.e.,
    to use the following settings:

    (a) LPS=spx: Use SoPlex as LP solver. For this you have to install SoPlex,
         which you can also find at [http://scipopt.org](https://scipopt.org/). If you have installed SCIP
	 via the SCIP-OptSuite, then you also have installed SoPlex.

    (b) OPT=opt: The code is compiled in optimized mode and runs significantly
         faster.

    On some machines, you should use gmake instead of make.

3. Clone this repository (it contains the project).

4. There are two options to determine the path to the SCIP directory:

    - Set the environment variable `SCIP_PATH` to contain the path to SCIP's root
      directory.

    - Edit the Makefile of this directory, edit the
      variable SCIPDIR if necessary.  It should point to the directory
      that contains SCIP, i.e., `$SCIPDIR/lib` contains the SCIP library files.

5. Compile the project: In the main directory, enter exactly
   the same compilation command as used in Step 2.

6. To run the program, enter
   `bin/scip.$(OSTYPE).$(ARCH).$(COMP).$(OPT).$(LPS)`
   (e.g., "bin/scip.linux.x86_64.gnu.opt.spx2") with one mandatory argument
   that specifies the instance to be solved.


    Additional parameters can be:

    -s `<setting file>`

    -t `<time limit>`

    -m `<mem limit>`

    -n `<node limit>`

    -d `<display frequency>`
