class RecipesImporterService < BaseService
  attr_accessor :import_file, :batch_size

  def initialize(import_file, batch_size = 1000)
    @import_file = import_file
    @batch_size = batch_size
    raise 'Must provide a file path!' unless File.exist?(import_file.to_s)
  end

  # TODO: download this file from the cloud
  def call
    File.open(import_file) do |file|
      #byebug
      file.lazy.each_slice(batch_size) do |lines|
        recipes = lines.collect do |line|
          parsed_line = JSON.parse(line)
          merge_special_fields(parsed_line)
        end
        Recipe.upsert_all recipes
      end
    end
  end

  private

  def merge_special_fields(parsed_line)
    special_fields = {
      created_at: Time.now,
      updated_at: Time.now,
      prep_time: parse_duration(parsed_line['prep_time']),
      cook_time: parse_duration(parsed_line['cook_time']),
      total_time: parse_duration(parsed_line['total_time']),
      rate: parsed_line['rate'].to_f,
      ingredients: parsed_line['ingredients'].join(';')
    }
    parsed_line.merge!(special_fields)
  end

  def parse_duration(duration_string)
    if duration_string.include? 'h'
      hours, minutes = duration_string.split('h')
      hours.to_i * 60 + minutes.to_i
    else
      duration_string.to_i
    end
  end
end
