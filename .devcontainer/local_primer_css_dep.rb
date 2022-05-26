# frozen_string_literal: true

require "json"

package_json_path = File.expand_path("../lookbook/package.json", __dir__)
package_json = JSON.parse(File.read(package_json_path))
package_json["dependencies"]["@primer/css"] = "file:/workspaces/@primer/css"
File.write(package_json_path, JSON.pretty_generate(package_json))
