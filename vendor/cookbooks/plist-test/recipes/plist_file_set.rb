# -*- coding: utf-8 -*-
#
# Copyright 2014-2016 Roy Liu
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

require "time"

test_file = Pathname.new(Dir.tmpdir) + "#{recipe_name}_spec.plist"

plist_file "#{recipe_name}_spec" do
  file test_file

  set "outer0", "inner0", "key1", {a: {c: [false, 0, 1.23], b: [true, "a"], a: Time.iso8601("2014-01-01T00:00:00Z")}}
  set "outer0", "inner0", "key0", true
  set "outer1", "inner1", "key0",
      Plist::Data.new("abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz")
  set "outer1", "inner1", "key2",
      Plist::Data.new(
          "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5emFiY2RlZmdo" \
          "aWprbG1ub3BxcnN0dXZ3eHl6", false
      )

  options intermediate: true do
    set "outer7", "inner7", "a", 1
  end

  set "outer7", "inner7", "b", 2

  options intermediate: true do
    set "outer7", "inner9", "a", 1
    push "outer7", "inner8", "a", 1
  end

  action :create
end
