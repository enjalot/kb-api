
module Import
  class CreateRoadsOS < Step

    def up
      #shapefile = "rocquev2/rocque_segments.shp"
      shapefile = "data/geo/roads/os/os_beta/R_Z_J_620.shp"
      importfile = "data/geo/roads/os/importer.sql"
      dbname = "kl_development"
      tablename = "roads_os"
      username = "enjalot" # TODO: figure out the actual way to do this

      value = %x(echo 'importing #{shapefile} into #{dbname} #{tablename}')
      puts value
      value = %x(ogr2ogr -f "PostgreSQL" PG:"dbname=#{dbname} user=#{username}" "#{shapefile}" -nln #{tablename} -s_srs EPSG:3857 -t_srs EPSG:4326)
      puts value
      value = %x(psql -d #{dbname} -a -f #{importfile})
      puts value
      puts "done creating OS roads"
    end

    def down
      %x(echo 'down')
    end

  end
end
