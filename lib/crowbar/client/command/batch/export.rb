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

require "base64"
require "easy_diff"

module Crowbar
  module Client
    module Command
      module Batch
        #
        # Implementation for the batch export command
        #
        class Export < Base
          def request
            args.easy_merge!(
              includes: options.includes,
              excludes: options.excludes
            )

            @request ||= Request::Batch::Export.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                if write(request.parsed_response)
                  say "Successfully exported batch"
                else
                  err "Failed to export batch"
                end
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def write(body)
            path(body["name"]).tap do |path|
              path.binmode
              path.write(
                Base64.decode64(
                  body["file"]
                )
              )

              true
            end
          rescue
            false
          end

          def path(name = nil)
            @path ||=
              case args.file
              when "-"
                stdout.to_io
              when File
                args.file
              else
                File.new(
                  args.file || name,
                  File::CREAT | File::TRUNC | File::RDWR
                )
              end
          end
        end
      end
    end
  end
end
