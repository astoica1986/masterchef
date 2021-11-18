namespace :utils do
  desc 'import recipes from json file'
  task import_recipes: :environment do
    RecipesImporterService.call(ENV['path'])
  end
end

