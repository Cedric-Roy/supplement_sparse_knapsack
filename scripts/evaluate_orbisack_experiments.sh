RESULTDIR=${1}

echo "\begin{table}[t]"
echo "  \caption{Comparison of extended formulations for orbisacks and separation of LCIs.}"
echo "  \label{tab:orbisack}"
echo "  \scriptsize"
echo "  \centering"
echo "  \begin{tabular*}{\textwidth}{@{}l@{\;\;\extracolsep{\fill}}rrrrrrrrr@{}}"
echo "    \toprule"
echo "    & & & & \multicolumn{6}{c}{max.\ 10 rows}\\\\"
echo "    \cmidrule{5-10}"
echo "    & & \multicolumn{2}{c}{default} & \multicolumn{2}{c}{EF1} & \multicolumn{2}{c}{EF2} & \multicolumn{2}{c}{EF3}\\\\"
echo "    \cmidrule{3-4}\cmidrule{5-6}\cmidrule{7-8}\cmidrule{9-10}"
echo "    subset & \# & time & solved & time & solved & time & solved & time & solved\\\\"
echo "    \midrule"

python evaluate_orbisack_experiments.py $RESULTDIR/final_experiments_orbisack --timelim 7200 --testset miplib2017_orbisack --affThreshold 0.0\
       --sett orbisack_form_0_maxrow_10_initial_TRUE_relaxonly_FALSE\
       --sett orbisack_form_1_maxrow_10_initial_TRUE_relaxonly_FALSE\
       --sett orbisack_form_2_maxrow_10_initial_TRUE_relaxonly_FALSE\
       --sett orbisack_form_3_maxrow_10_initial_TRUE_relaxonly_FALSE

echo "    \midrule"
echo "    & & & & \multicolumn{6}{c}{max.\ 30 rows}\\\\"
echo "    \cmidrule{5-10}"

python evaluate_orbisack_experiments.py $RESULTDIR/final_experiments_orbisack --timelim 7200 --testset miplib2017_orbisack --affThreshold 0.0\
       --sett orbisack_form_0_maxrow_10_initial_TRUE_relaxonly_FALSE\
       --sett orbisack_form_1_maxrow_30_initial_TRUE_relaxonly_FALSE\
       --sett orbisack_form_2_maxrow_30_initial_TRUE_relaxonly_FALSE\
       --sett orbisack_form_3_maxrow_30_initial_TRUE_relaxonly_FALSE

echo "    \bottomrule"
echo "  \end{tabular*}"
echo "\end{table}"
