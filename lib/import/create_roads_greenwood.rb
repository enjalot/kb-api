
module Import
  class CreateRoadsGreenwood < Step

    def up
      #shapefile = "rocquev2/rocque_segments.shp"
      shapefile = "data/geo/roads/greenwood/greenwood_0819/Greenwood_0819.shp"
      importfile = "data/geo/roads/greenwood/importer.sql"
      dbname = "kl_development"
      tablename = "roads_greenwood"

      value = %x(echo 'importing #{shapefile} into #{dbname} #{tablename}')
      puts value
      value = %x(ogr2ogr -f "PostgreSQL" PG:"dbname=#{dbname}" "#{shapefile}" -nln #{tablename} -s_srs EPSG:3857 -t_srs EPSG:4326)
      puts value
      value = %x(psql -d #{dbname} -a -f #{importfile})
      puts value
      puts "done creating Greenwood roads"
    end

    def down
      %x(echo 'down')
    end

  end
end
