#!/usr/bin/env python3

# Copyright 2021 Google LLC
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

import base64
import json
from gsuite_exporter.cli import sync_all


def run(data, context):

    # Decode Data From Pubsub Message
    name = base64.b64decode(data['data']).decode('utf-8')

    # Load Data in JSON
    dictionary = json.loads(name)

    # Parse JSON to Set Variables
    project_id = dictionary['PROJECT_ID']
    gsuite_admin_user = dictionary['GSUITE_ADMIN_USER']

    # Run Log Sync
    sync_all(
            admin_user=gsuite_admin_user,
            api='reports_v1',
            applications=['login', 'admin', 'drive', 'mobile', 'token'],
            project_id=project_id,
            exporter_cls='stackdriver_exporter.StackdriverExporter'
        )
