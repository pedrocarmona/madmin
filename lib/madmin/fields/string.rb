module Madmin
  module Fields
    class String < Field
      def form(record:, form:, resource:)
        [
          form.label(attribute_name, class: "inline-block w-32 flex-shrink-0"),
          form.text_field(attribute_name, class: "form-input")
        ].join("\n").html_safe
      end
    end
  end
end
