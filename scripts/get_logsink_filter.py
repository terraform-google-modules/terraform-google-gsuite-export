import sys
import json
from copy import copy

def main(project, apps):
    filter = ""
    filter_str = "logName:projects/{}/logs/{}"

    # Build filter string
    for ix, app_name in enumerate(apps):
        log_filter = copy(filter_str).format(project, app_name)
        if ix != 0: # not the first filter
            filter += " OR "
        filter += log_filter

    # Print output
    data = { 'filter': filter }
    out_json = json.dumps(data)
    sys.stdout.write(out_json)

if __name__ == '__main__':
    project = sys.argv[1]
    apps = sys.argv[2].split(' ')
    main(project, apps)
