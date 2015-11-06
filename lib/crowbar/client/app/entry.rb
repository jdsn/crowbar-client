#
# Copyright 2015, SUSE Linux GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Crowbar
  module Client
    module App
      class Entry < Base
        map [
          "--version",
          "-v"
        ] => :version

        class_option :config,
          type: :string,
          default: nil,
          aliases: ["-c"],
          desc: "Path to a configuration file"

        class_option :alias,
          type: :string,
          default: "default",
          aliases: ["-a"],
          desc: "Alias for a config section"

        class_option :username,
          type: :string,
          default: "crowbar",
          aliases: ["-U"],
          desc: "Specify username for connection"

        class_option :password,
          type: :string,
          default: "crowbar",
          aliases: ["-P"],
          desc: "Specify password for connection"

        class_option :server,
          type: :string,
          default: "http://127.0.0.1:80",
          aliases: ["-s"],
          desc: "Specify server for connection"

        class_option :timeout,
          type: :numeric,
          default: 60,
          aliases: ["-t"],
          desc: "Specify timeout for connection"

        class_option :anonymous,
          type: :boolean,
          default: false,
          aliases: ["-a"],
          desc: "Skip API user authentication"

        class_option :debug,
          type: :boolean,
          default: false,
          aliases: ["-d"],
          desc: "Output more debug information"

        desc "version",
          "Display the current version of the client"

        long_desc <<-LONGDESC
          `version` will print out the version of the currently used
          crowbar-client, this is some usefull information if you try
          to debug some issue with the current implementation.
        LONGDESC

        def version
          say "crowbar-client v#{Crowbar::Client::Version}"
        end

        desc "barclamp [COMMANDS]",
          "Barclamp specific commands, call without params for help"
        subcommand "barclamp", Crowbar::Client::App::Barclamp

        desc "batch [COMMANDS]",
          "Batch specific commands, call without params for help"
        subcommand "batch", Crowbar::Client::App::Batch

        desc "network [COMMANDS]",
          "Network specific commands, call without params for help"
        subcommand "network", Crowbar::Client::App::Network

        desc "node [COMMANDS]",
          "Node specific commands, call without params for help"
        subcommand "node", Crowbar::Client::App::Node

        desc "proposal [COMMANDS]",
          "Proposal specific commands, call without params for help"
        subcommand "proposal", Crowbar::Client::App::Proposal

        desc "repository [COMMANDS]",
          "Repository specific commands, call without params for help"
        subcommand "repository", Crowbar::Client::App::Repository

        desc "reset [COMMANDS]",
          "Reset specific commands, call without params for help"
        subcommand "reset", Crowbar::Client::App::Reset

        desc "role [COMMANDS]",
          "Role specific commands, call without params for help"
        subcommand "role", Crowbar::Client::App::Role
      end
    end
  end
end