RESULTDIR=${1}

echo "\begin{table}[t]"
echo "  \caption{Comparison of separation algorithms for LCIs with a time limit of~2 hours and sparsity~4.}"
echo "  \label{tab:knapsack2}"
echo "  \scriptsize"
echo "  \centering"
echo "  \begin{tabular*}{\textwidth}{@{}l@{\;\;\extracolsep{\fill}}rrrrrrrrrrr@{}}"
echo "    \toprule"
echo "    & & \multicolumn{2}{c}{4-4-0RR} & \multicolumn{2}{c}{4-4-SSS} & \multicolumn{2}{c}{4-4-S0R} & \multicolumn{2}{c}{4-4-0SR} & \multicolumn{2}{c}{4-4-SSR}\\\\"
echo "    \cmidrule{3-4}\cmidrule{5-6}\cmidrule{7-8}\cmidrule{9-10}\cmidrule{11-12}"
echo "    subset & \# & time & solved & time & solved & time & solved & time & solved & time & solved\\\\"
echo "    \midrule"

python evaluate_knapsack_experiments.py --timelim 7200 --testset miplib2017_sknapsack_min3_max4 --affThreshold 0.0\
       --path $RESULTDIR/final_experiments_knapsack --sett mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_FALSE_sepafreq_0\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim2 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5a\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim2 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5b\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim2 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5c\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim2 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5

echo "    \bottomrule"
echo "  \end{tabular*}"
echo "\end{table}"

echo "\begin{table}[t]"
echo "  \caption{Comparison of separation algorithms for LCIs with a time limit of~4 hours and sparsity~4.}"
echo "  \label{tab:knapsack4}"
echo "  \scriptsize"
echo "  \centering"
echo "  \begin{tabular*}{\textwidth}{@{}l@{\;\;\extracolsep{\fill}}rrrrrrrrrrr@{}}"
echo "    \toprule"
echo "    & & \multicolumn{2}{c}{4-4-0RR} & \multicolumn{2}{c}{4-4-SSS} & \multicolumn{2}{c}{4-4-S0R} & \multicolumn{2}{c}{4-4-0SR} & \multicolumn{2}{c}{4-4-SSR}\\\\"
echo "    \cmidrule{3-4}\cmidrule{5-6}\cmidrule{7-8}\cmidrule{9-10}\cmidrule{11-12}"
echo "    subset & \# & time & solved & time & solved & time & solved & time & solved & time & solved\\\\"
echo "    \midrule"

python evaluate_knapsack_experiments.py --timelim 14400 --testset miplib2017_sknapsack_min3_max4 --affThreshold 0.0\
       --path $RESULTDIR/final_experiments_knapsack_timelim4 --sett mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_FALSE_sepafreq_0\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim4 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5a\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim4 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5b\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim4 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5c\
       --path $RESULTDIR/final_experiments_knapsack_sepa/timelim4 --sett mins_4_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5

echo "    \bottomrule"
echo "  \end{tabular*}"
echo "\end{table}"

echo "\begin{table}[t]"
echo "  \caption{Comparison of separation algorithms for LCIs with a time limit of~2 hours and sparsity~3 or~4.}"
echo "  \label{tab:knapsack2a}"
echo "  \scriptsize"
echo "  \centering"
echo "  \begin{tabular*}{\textwidth}{@{}l@{\;\;\extracolsep{\fill}}rrrrrrrrrrr@{}}"
echo "    \toprule"
echo "    & & \multicolumn{2}{c}{3-4-0RR} & \multicolumn{2}{c}{3-4-SSS} & \multicolumn{2}{c}{3-4-S0R} & \multicolumn{2}{c}{3-4-0SR} & \multicolumn{2}{c}{3-4-SSR}\\\\"
echo "    \cmidrule{3-4}\cmidrule{5-6}\cmidrule{7-8}\cmidrule{9-10}\cmidrule{11-12}"
echo "    subset & \# & time & solved & time & solved & time & solved & time & solved & time & solved\\\\"
echo "    \midrule"

python evaluate_knapsack_experiments.py --timelim 7200 --testset miplib2017_sknapsack_min3_max4 --affThreshold 0.0\
       --path $RESULTDIR/final_experiments_knapsack --sett mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_FALSE_sepafreq_0\
       --path $RESULTDIR/final_experiments_knapsack_34 --sett mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5a\
       --path $RESULTDIR/final_experiments_knapsack_34 --sett mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5b\
       --path $RESULTDIR/final_experiments_knapsack_34 --sett mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5c\
       --path $RESULTDIR/final_experiments_knapsack_34 --sett mins_3_maxs_4_maxindep_10000_maxcover_10000_coefbound_2147483647_usesparse_TRUE_sepafreq_5

echo "    \bottomrule"
echo "  \end{tabular*}"
echo "\end{table}"
