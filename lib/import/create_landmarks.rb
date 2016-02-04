
module Import
  class CreateLandmarks < Step

    def up

      # Form the CSV path.
      path = Rails.root.join('data/landmarks.csv')

      CSV.foreach(path, :headers => true) do |row|

        lon = row['Lon'].to_f
        lat = row['Lat'].to_f

        Landmark.create(
          name: row['Name'],
          unveiled_year: row["Date of unveiling"],
          lonlat: Helpers::Geo.point(lon, lat),
        )

      end

    end

    def down
      Landmark.delete_all
    end

  end
end
