# frozen_string_literal: true

require "json"

package_json_path = "lookbook/package.json"
package_json = JSON.parse(File.read(package_json_path))
package_json["dependencies"]["@primer/css"] = "file:/workspaces/@primer/css"
File.write(package_json_path, package_json.to_json)
