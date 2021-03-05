module Madmin
  module Fields
    class BelongsTo < Field
      def options_for_select(record)
        association = record.class.reflect_on_association(attribute_name)

        klass = association.klass
        klass.all.map do |r|
          ["#{klass.name} ##{r.id}", r.id]
        end
      end

      def to_param
        "#{attribute_name}_id"
      end

      def show(record:)
        object = value(record)
        return if object.nil?

        link_to(
          Madmin.resource_for(object).display_name(object),
          Madmin.resource_for(object).show_path(object)
        ).html_safe
      end
    end
  end
end
