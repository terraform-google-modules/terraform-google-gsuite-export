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

instance_name = attribute('gsuite_export')[:instance_name]
instance_zone = attribute('gsuite_export')[:instance_zone]
instance_project = attribute('gsuite_export')[:instance_project]

control "gcp" do
  title "GSuite exporter VM"

  describe google_compute_instance(
    project: instance_project,
    zone: instance_zone,
    name: instance_name
  ) do
    it { should exist }
  end
end
