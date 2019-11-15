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

project_id = attribute("gsuite-export")["instance_project"]

control "stackdriver" do
  title "GSuite export - bare (without log export)"

  describe command("gcloud --project=#{project_id} services list --enabled") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "monitoring.googleapis.com" }
    its(:stdout) { should include "compute.googleapis.com" }
    its(:stdout) { should include "admin.googleapis.com" }
    its(:stdout) { should include "iam.googleapis.com" }
  end
end
