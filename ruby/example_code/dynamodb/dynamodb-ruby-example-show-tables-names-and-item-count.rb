# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

# Purpose:
# dynamodb-ruby-example-show-tables-names-and-item-count.rb demonstrates how to
# count items in a table in Amazon DynamoDB using the AWS SDK for Ruby.

# snippet-start:[dynamodb.Ruby.showTableNames]

require 'aws-sdk-dynamodb'

# @param dynamodb_client [Aws::DynamoDB::Client] An initialized
#   Amazon DynamoDB client.
# @return [Array] The list of available table names as an array of type String.
# @example
#   table_names = get_table_names(
#     Aws::DynamoDB::Client.new(region, 'us-west-2')
#   )
#   table_names.each do |table_name|
#     puts table_name
#   end
def get_table_names(dynamodb_client)
  result = dynamodb_client.list_tables
  result.table_names
rescue StandardError => e
  puts "Error getting table names: #{e.message}"
  'Error'
end

# Gets a count of items in a table in Amazon DynamoDB.
#
# @param dynamodb_client [Aws::DynamoDB::Client] An initialized
#   Amazon DynamoDB client.
# @param table_name [String] The name of the table.
# @return [Integer] The number of items in the table.
# @example
#   puts get_count_of_table_items(
#     Aws::DynamoDB::Client.new(region, 'us-west-2'),
#     'Movies'
#   )
def get_count_of_table_items(dynamodb_client, table_name)
  result = dynamodb_client.scan(table_name: table_name)
  result.items.count
rescue StandardError => e
  puts "Error getting items for table '#{table_name}': #{e.message}"
  'Error'
end

# Full example call:
def run_me
# Replace us-west-2 with the AWS Region you're using for Amazon DynamoDB.
  region = 'us-west-2'

  dynamodb_client = Aws::DynamoDB::Client.new(region: region)
  table_names = get_table_names(dynamodb_client)

  if table_names == 'Error'
    puts 'Cannot get table names. Stopping program.'
  elsif table_names.count.zero?
    puts "Cannot find any tables in AWS Region '#{region}'."
  else
    puts "Found #{table_names.count} tables in AWS Region '#{region}':"
    puts "(Displaying information for only the first 100 tables)" if table_names.count > 100

    table_names.each do |table_name|
      table_items_count = get_count_of_table_items(dynamodb_client, table_name)

      if table_items_count == 'Error'
        puts "Cannot get count of items for table '#{table_name}'."
      elsif table_items_count.zero?
        puts "Table '#{table_name}' has no items."
      else
        puts "Table '#{table_name}' has #{table_items_count} items."
      end

    end
  end
end

run_me if $PROGRAM_NAME == __FILE__
# snippet-end:[dynamodb.Ruby.showTableNames]
