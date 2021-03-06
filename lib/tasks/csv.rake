
namespace :csv do

  desc 'Generate an events CSV'
  task :events, [:path] => :environment do |t, args|

    args.with_defaults(path: 'events.csv')

    CSV.open(args.path, 'w',
      :headers => ['name', 'address', 'longitude', 'latitude'],
      :write_headers => true,
    ) do |fh|

      Event.where { lonlat != nil }.each do |e|
        fh << [e.name, e.address, e.lonlat.x, e.lonlat.y]
      end

    end

  end

  desc 'Generate a photographs CSV'
  task :photos, [:path] => :environment do |t, args|

    args.with_defaults(path: 'photos.csv')

    CSV.open(args.path, 'w',
      :headers => ['id', 'url', 'thumb', 'longitude', 'latitude', 'title', 'address'],
      :write_headers => true,
    ) do |fh|

      Photograph.where { lonlat != nil }.each do |p|
        fh << [p.flickr_id, p.harvested_url, p.thumb_url, p.lonlat.x, p.lonlat.y, p.title, p.address]
      end

    end

  end

  desc 'Generate a landmarks CSV'
  task :landmarks, [:path] => :environment do |t, args|

    args.with_defaults(path: 'landmarks.csv')

    CSV.open(args.path, 'w',
      :headers => ['name', 'longitude', 'latitude'],
      :write_headers => true,
    ) do |fh|

      Landmark.where { lonlat != nil }.each do |l|
        fh << [l.name, l.lonlat.x, l.lonlat.y]
      end

    end

  end

  desc 'Generate CSV with events, photos, and landmarks'
  task :all, [:path] => :environment do |t, args|

    args.with_defaults(path: 'kindred.csv')

    CSV.open(args.path, 'w',
      :headers => ['name', 'type', 'marker', 'longitude', 'latitude'],
      :write_headers => true,
    ) do |fh|

      Event.where { lonlat != nil }.each do |e|
        fh << [e.name, 'event', 'small_red', e.lonlat.x, e.lonlat.y]
      end

      Photograph.where { lonlat != nil }.each do |p|
        fh << [p.url, 'photograph', 'small_green', p.lonlat.x, p.lonlat.y]
      end

      Landmark.where { lonlat != nil }.each do |l|
        fh << [l.name, 'landmark', 'small_blue', l.lonlat.x, l.lonlat.y]
      end

    end

  end

end
