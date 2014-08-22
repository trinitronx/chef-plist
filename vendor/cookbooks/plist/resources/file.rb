# -*- coding: utf-8 -*-
#
# Copyright 2014 Roy Liu
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

require "pathname"

actions [:update]
default_action :update

attribute :domain, kind_of: String, name_attribute: true
attribute :file, kind_of: Pathname
attribute :format, kind_of: [NilClass, Symbol, String], equal_to: [nil, :binary, "binary", :xml, "xml"]

attr_reader :keys_values
attr_reader :css_queries
attr_reader :css_query_callback

def set(*keys, value)
  raise "Setting the plist root `dict` requires an instance of `Hash`" \
    if keys.size == 0 && !value.is_a?(Hash)

  @keys_values.push([keys, value])
end

def css_select(*css_queries, &css_query_callback)
  raise "Please provide a callback for the CSS3 query results" \
    if !css_query_callback

  @css_queries = css_queries
  @css_query_callback = css_query_callback
end

def initialize(domain, run_context)
  super

  @css_queries = []
  @keys_values = []
end