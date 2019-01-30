import base64
import json
from gsuite_exporter.cli import sync_all

def run (data, context):

    # Decode Data From Pubsub Message
    name = base64.b64decode(data['data']).decode('utf-8')

    # Load Data in JSON
    json_string = json.loads(name)
    
    # Parse JSON to Set Variables
    project_id = json_string['PROJECT_ID']  
    gsuite_admin_user = json_string['GSUITE_ADMIN_USER']

    # Run Log Sync
    sync_all(
            admin_user=gsuite_admin_user,
            api='reports_v1',
            applications=['login', 'admin', 'drive', 'mobile', 'token'],
            project_id=project_id,
            exporter_cls='stackdriver_exporter.StackdriverExporter'
        )