
module Import
  class CreateRoadsRocque < Step

    def up
      #shapefile = "rocquev2/rocque_segments.shp"
      #shapefile = "data/geo/roads/rocque/rocque/Rocque_QA_final.shp"
      shapefile = "data/geo/roads/rocque/rocque/roc_lines.shp"
      importfile = "data/geo/roads/rocque/importer.sql"
      dbname = "kl_development"
      tablename = "roads_rocque"
      username = "enjalot" # TODO: figure out the actual way to do this

      value = %x(echo 'importing #{shapefile} into #{dbname} #{tablename}')
      puts value
      value = %x(ogr2ogr -f "PostgreSQL" PG:"dbname=#{dbname} user=#{username}" "#{shapefile}" -nln #{tablename} -s_srs EPSG:3857 -t_srs EPSG:4326)
      puts value
      value = %x(psql -d #{dbname} -a -f #{importfile})
      puts value
      puts "done creating rocque roads"
    end

    def down
      %x(echo 'down')
    end

  end
end
