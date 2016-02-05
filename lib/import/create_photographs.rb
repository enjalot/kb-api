
module Import
  class CreatePhotographs < Step

    def up
      csv('photos/master.csv').each do |row|

        @old = row
        @new = Photograph.new

        set_core_fields
        set_permission_fields
        set_lonlat

        @new.save

      end
    end

    #
    # Set origin / descriptive fields.
    #
    def set_core_fields
      @new.attributes = {
        flickr_id:  @old['photo_id'],
        url:        @old['img_orig'],
        address:    @old['address'],
        title:      @old['p_title'],
      }
    end

    #
    # Set copyright / permission fields.
    #
    def set_permission_fields

      @new.attributes = {
        license: @old['license'],
        fee: @old['fee?'],
        credit: @old['credit line to include'],
      }

      if @old['copyright permission secured'] == 'yes'
        @new.permission = true
      end

      if @old['permission date']
        parsed = Date.strptime(@old['permission date'], '%m/%d/%y')
        @new.permission_date = parsed
      end

    end

    #
    # Set the coordinate, if provided.
    #
    def set_lonlat

      point = eval(@old['coordinates'])

      if point[0] != ''

        @new.lonlat = Helpers::Geo.point(
          point[0].to_f,
          point[1].to_f,
        )

        @new.accuracy = 0

      end

    end

    def down
      Photograph.delete_all
    end

  end
end
