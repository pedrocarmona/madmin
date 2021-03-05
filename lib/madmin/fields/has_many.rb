module Madmin
  module Fields
    class HasMany < Field
      def options_for_select(record)
        association = record.class.reflect_on_association(attribute_name)

        klass = association.klass
        klass.all.map do |r|
          ["#{klass.name} ##{r.id}", r.id]
        end
      end

      def to_param
        {"#{attribute_name.to_s.singularize}_ids".to_sym => []}
      end

      def show(record:)
        value(record).map do |object|
          content_tag(
            :div,
            link_to(
              Madmin.resource_for(object).display_name(object),
              Madmin.resource_for(object).show_path(object)
            )
          )
        end.join("\n").html_safe
      end
    end
  end
end
