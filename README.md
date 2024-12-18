This repository contains information about how to reproduce the numerical results presented in the article

> Computational Aspects of Lifted Cover Inequalities for Knapsack with Few Different Weights

by Christopher Hojny and Cédric Roy.

In the following, we explain which software is required to build the code and how to run numerical experiments to reproduce the numerical results of the article.
Our implementation mainly builds upon the constraint handler plug-in `cons_knapsack`of [SCIP](https://scipopt.org), which we have modified and which is available in this repository.
The parts we have modified are:

- lines 157 to 174
- lines 239 to 282
- lines 712 to 926
- lines 12131 to 13873
- lines 15442 to 15501

Moreover, we extended SCIP's plug-in `prop_symmetry` to be able to add our extended formulations for orbisacks. The relevant changes are in prop_symmetry.c:handleSymresackCons(), which adds functionality to add different extended formulations for orbisacks.


# I Installation

Please check the installation instructions provided [here](INSTALL.md).

# II Running Experiments

## Running One Instance

To run the program, enter

> `bin/scip.$(OSTYPE).$(ARCH).$(COMP).$(OPT).$(LPS).none`

(e.g. "bin/scip.linux.x86_64.gnu.opt.spx2.none") and provide the argument `<path/to/instance>` to specify an instance that shall be solved. An exemplary call is

> `./bin/scip.linux.x86_64.gnu.opt.spx2.none <path/to/instance>`

Additional parameters can be:

- -s `<settingname>`
- -t `<timelimit>`
- -m `<memlimit>`
- -n `<nodelimit>`
- -d `<displayfrequency>`

## Test Sets

In the experiments described in the article, we have used publicly available instances. To reproduce the results, please download the instance collection [MIPLIB2017](https://miplib.zib.de/downloads/collection.zip). The lists of the different test sets used for the different experiments can be found in the directory `testset`.

- `miplib2017_orbisack.test` test set for the experiments regarding extended formulations for orbisacks
- `miplib2017_sknapsack_min3_max4.test` test set for the experiments regarding LCI separation for sparse knapsacks

## Settings

In our experiments, we used different settings to test various parameterizations of our code. These settings can be found in the directory `settings` and test the following parameterizations:

For the knapsack experiments we used the following settings, with the prefix `mins_X_maxs_Y` enforcing the minimal and maximal sparsity value.
We bound the generation of independent sets as well as covers to 10000 each. 
The largest possible value for any coefficient in the LCIs is set to 2147483647.
The first two settings have the parameter `usesparse` set to `FALSE`, whereas the remaining 10 have it set to `TRUE`, that is, the routine for separating sparse knapsack is enabled in the latter case.
Lastly the parameter `sepafreq` can be set to `0`, meaning we only separate at the root node, `5` means that we separate at every fifth layer of the branch-and-bound tree, and the parameters `a`, `b` and `c` refer to the settings `SSS`, `S0R` and `0SR` respectively in the paper whereas no letter is `SSR`. 

- `mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_FALSE_sepafreq_0.set`
- `mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_FALSE_sepafreq_5a.set`
- `mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_0.set`
- `mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5a.set`
- `mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5b.set`
- `mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5c.set`
- `mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5.set`
- `mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_0.set`
- `mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5a.set`
- `mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5b.set`
- `mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5c.set`
- `mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5.set`

For the orbisack experiments we used the following settings. 
With `form_x` indicating if it is EF1, EF2, or EF3 or default SCIP when x=0.
The string `maxrow_X` corresponds to the number of rows enabled.


- `orbisack_form_0_maxrow_10_initial_TRUE_relaxonly_FALSE.set`
- `orbisack_form_1_maxrow_10_initial_TRUE_relaxonly_FALSE.set`
- `orbisack_form_1_maxrow_30_initial_TRUE_relaxonly_FALSE.set`
- `orbisack_form_2_maxrow_10_initial_TRUE_relaxonly_FALSE.set`
- `orbisack_form_2_maxrow_30_initial_TRUE_relaxonly_FALSE.set`
- `orbisack_form_3_maxrow_10_initial_TRUE_relaxonly_FALSE.set`
- `orbisack_form_3_maxrow_30_initial_TRUE_relaxonly_FALSE.set`

# III Evaluating Experiments

We have collected logs of all our experiments that are provided in the tarball `results.tar.gz`. These log files summarize all experiments for a specific test set and setting in a common file. To evaluate the experiments to reproduce the tables presented in the article, unpack the tarball. Afterwards, run the script

> scripts/evaluate_knapsack_experiments.sh <path/to/results>

to create the tables for the experiments on sparse knapsacks and

> scripts/evaluate_orbisack_experiments.sh <path/to/results>

to create the tables for the experiments on extended formulations for orbisacks. In both cases `<path/to/results>` is a relative or absolute path to the unpacked tarball containing the logs of our experiments.
