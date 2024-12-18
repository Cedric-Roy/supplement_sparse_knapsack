import argparse
import math

SOLVED = 0
MEMORYLIMIT = 1
TIMELIMIT = 2

TIMESHIFT = 1.0
INTEGRALSHIFT = 0

MAXGAP = 10000.0

HARD = 0
SEMIEASY = 1
EASY = 2
SEMIHARD = 3

EXCLUDED_INSTANCES = ["cvs16r70-62.mps.gz", "sp98ar.mps.gz", "toll-like.mps.gz", "cvs16r106-72.mps.gz", "cvs16r128-89.mps.gz", "seymour.mps.gz", "sct32.mps.gz", "leo1.mps.gz", "bley_xs2.mps.gz"]

def get_fill(time):

    if time < 10:
        return "   "
    if time < 100:
        return "  "
    if time < 1000:
        return " "
    return ""

def extract_statistics(results_file, timelim):

    statistics = dict()

    f = open(results_file, 'r')

    name = ""
    stats = None
    for line in f:

        if line.startswith("@01"):
            name = line.split()[1].split('/')[-1]
            stats = {
                "status": SOLVED,
                "time": -1,
                "gap": -1
                }
        elif line.startswith("SCIP Status        : solving was interrupted [memory limit reached]"):
            stats["status"] = MEMORYLIMIT
        elif line.startswith("SCIP Status        : solving was interrupted [time limit reached]"):
            stats["status"] = TIMELIMIT
        elif line.startswith("Solving Time (sec)"):
            if stats["status"] == MEMORYLIMIT:
                stats["time"] = timelim
            else:
                stats["time"] = min(timelim, float(line.split()[-1]))
        elif line.startswith("Gap                :"):
            if line.split()[2] == "infinite":
                stats["gap"] = MAXGAP
            else:
                stats["gap"] = float(line.split()[2])
        elif line.startswith("@04"):
            if not name in EXCLUDED_INSTANCES:
                statistics[name] = stats

    f.close()

    return statistics

def get_affected_instances(statistics, affThreshold):

    settings = list(statistics.keys())

    # find affected instances
    affected_instances = []
    for inst in statistics[settings[0]]:
        min_time = min( statistics[sett][inst]["time"] for sett in settings )
        max_time = max( statistics[sett][inst]["time"] for sett in settings )

        if max_time >= (1 + affThreshold) * min_time:
            affected_instances.append(inst)

    return affected_instances

def get_selected_instances(statistics, settings, instances, time_bound, timelimit, criterion):

    selected_instances = []
    for inst in instances:
        if criterion == HARD:
            min_val = min( statistics[sett][inst]["time"] for sett in settings )
            if min_val >= time_bound and min_val < timelimit:
                selected_instances.append(inst)
        elif criterion == SEMIHARD:
            max_val = max( statistics[sett][inst]["time"] for sett in settings )
            min_val = min( statistics[sett][inst]["time"] for sett in settings )
            if max_val >= time_bound and min_val < timelimit:
                selected_instances.append(inst)
        elif criterion == EASY:
            max_val = max( statistics[sett][inst]["time"] for sett in settings )
            if max_val <= time_bound:
                selected_instances.append(inst)
        elif criterion == SEMIEASY:
            max_val = max( statistics[sett][inst]["time"] for sett in settings )
            if max_val >= time_bound and max_val < timelimit:
                selected_instances.append(inst)

    return selected_instances

def get_sgm_time(statistics, selected_instances):

    sgm = 1.0
    cnt = 0
    
    for inst in selected_instances:
        sgm = math.pow(sgm, cnt/(cnt+1)) * math.pow(statistics[inst]["time"] + TIMESHIFT, 1/(cnt+1))
        cnt +=1
        if sgm <= 1:
            print(inst)

    return sgm - TIMESHIFT

def get_nsolved(statistics, selected_instances, timelimit):

    cnt = 0
    for inst in selected_instances:
        if statistics[inst]["time"] < timelimit:
            cnt += 1

    return cnt

def evaluate_statistics(statistics, affThreshold, timelimit):

    settings = list(statistics.keys())

    affected_instances = get_affected_instances(statistics, affThreshold)

    times = [0, 100, 1000, 3000, 6000]

    for mintime in times:
        selected_instances = get_selected_instances(statistics, settings, affected_instances, mintime, 7200, SEMIHARD)
        fill = get_fill(mintime)
        line = f"({mintime},{timelimit}){fill} & ({len(selected_instances)})"
        for sett in settings:
            line += f" & \\num{{{get_sgm_time(statistics[sett], selected_instances):7.2f}}} & \\num{{{get_nsolved(statistics[sett], selected_instances, timelimit):4d}}}"
        line+="\\\\"
        print(line)


if __name__ == "__main__":

    # create a parser for arguments
    parser = argparse.ArgumentParser(description='evaluates the running times for a collection of settings')
    parser.add_argument('--testset', metavar='testset', type=str, default="miplib2017_benchmark", help='name of test set')
    parser.add_argument('--path', metavar='results', type=str, action='append', help='directory containing results for next setting')
    parser.add_argument('--sett', metavar='sett', type=str, action='append', help='name of setting to be added')
    parser.add_argument('--timelim', metavar='timelim', type=int, default=7200, help='time limit of experiments')
    parser.add_argument('--affThreshold', metavar='affThreshold', type=float, default=0.02, help='threshold to categorize an instance as affected')

    args = parser.parse_args()
    assert len(args.path) == len(args.sett)

    # get statistics
    statistics = dict()
    for s in range(len(args.sett)):
        path = args.path[s]
        sett = args.sett[s]
        name = path + "/"  + f"check.moskito.{args.testset}.scip.linux.x86_64.gnu.opt.spx2.moskito.{sett}.out"
        statistics[path,sett] = extract_statistics(name, args.timelim)

    # evaluate statistics
    evaluate_statistics(statistics, args.affThreshold, args.timelim)
