# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import sys
import json
from copy import copy


def main(project, apps):
    filter = ""
    filter_str = "logName:projects/{}/logs/{}"

    # Build filter string
    for ix, app_name in enumerate(apps):
        log_filter = copy(filter_str).format(project, app_name)
        if ix != 0:  # not the first filter
            filter += " OR "
        filter += log_filter

    # Print output
    data = {'filter': filter}
    out_json = json.dumps(data)
    sys.stdout.write(out_json)


if __name__ == '__main__':
    project = sys.argv[1]
    apps = sys.argv[2].split(' ')
    main(project, apps)
