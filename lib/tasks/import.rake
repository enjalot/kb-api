
require_all './lib/vacuum', './lib/import'

runner = Vacuum::Runner.from_steps([

  Import::CreateEvents,
  Import::CreateEventTypes,
  Import::CreateEventRoles,
  Import::CreatePeople,
  Import::CreateLandmarks,
  Import::CreateOccupations,

  Import::CreatePhotographs,
  Import::CreateSupplementPhotographs,
  Import::ApplyPhotographCorrections,

  Import::CreateRoadsRocque,
  Import::CreateRoadsOS,
  Import::CreateRoadsGreenwood,

  Import::LinkPeopleWithEvents,
  Import::LinkPeopleWithOccupations,

])

road_runner = Vacuum::Runner.from_steps([
  Import::CreateRoadsRocque,
  Import::CreateRoadsOS,
  Import::CreateRoadsGreenwood,
])


photo_runner = Vacuum::Runner.from_steps([
  Import::CreatePhotographs,
  Import::CreateSupplementPhotographs,
  Import::ApplyPhotographCorrections,
])

namespace :db do
  namespace :import do

    desc 'Import data'
    task :up, [:step] => :environment do |t, args|
      args.with_defaults(step: nil)
      runner.up(args.step)
    end

    desc 'Roll back import'
    task :down, [:step] => :environment do |t, args|
      args.with_defaults(step: nil)
      runner.down(args.step)
    end

    desc 'Run an individual step'
    task :run, [:step] => :environment do |t, args|

      args.with_defaults(step: nil)

      runner.down(args.step)
      runner.up(args.step)

    end

  end
end

namespace :roads do
  desc 'Load road networks into PostgresSQL'
  task :import, [:step] => :environment do |t, args|
    args.with_defaults(step: nil)
    road_runner.up(args.step)
  end
end

namespace :photos do

  desc 'Harvest photos from Flickr'
  task :harvest => :environment do
    Photograph.harvest
  end

  desc 'Import photos independently'
  task :import, [:step] => :environment do |t, args|
    args.with_defaults(step: nil)
    photo_runner.up(args.step)
  end

end
