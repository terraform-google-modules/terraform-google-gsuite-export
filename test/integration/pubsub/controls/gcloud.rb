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

project_id = attribute('pubsub')['project_id']
sink_name = attribute('gsuite-log-export')['log_sink_resource_name']
writer_identity = attribute('gsuite-log-export')['writer_identity']
destination_uri = attribute('gsuite-log-export')['destination_uri']
filter = attribute('gsuite-log-export')['filter']

control "pubsub sink" do
  title "Log exports - project level pubsub destination - gcloud commands"

  describe command("gcloud logging sinks list --project #{project_id} --filter=\"name:#{sink_name}\" --format json") do
    its('exit_status') { should eq 0 }
    its('stderr') { should eq '' }
    let(:sink) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout, symbolize_names: true)[0]
      else
        []
      end
    end

    it "does return the correct log sink" do
      expect(sink).to include(
        name: sink_name
      )
    end

    it "does contain the correct writerIdentity" do
      expect(sink).to include(
        writerIdentity: writer_identity
      )
    end

    it "does contain the correct destination" do
      expect(sink).to include(
        destination: destination_uri
      )
    end

    it "does contain the correct filter" do
      expect(sink).to include(
        filter: filter
      )
    end
  end
end
