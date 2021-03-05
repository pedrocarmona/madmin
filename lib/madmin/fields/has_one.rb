module Madmin
  module Fields
    class HasOne < Field
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
