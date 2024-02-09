# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

class ::ArticleForPagination < ActiveRecord::Base
  include OpenSearch::Model

  # NOTE: This was added to fix pagination tests in ruby 3. It is not clear why
  # this is necessary since this should be done automatically by including
  # `OpenSearch::Model`.
  include OpenSearch::Model::Importing

  scope :published, -> { where(published: true) }

  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    mapping do
      indexes :title,      type: 'text', analyzer: 'snowball'
      indexes :created_at, type: 'date'
    end
  end
end
