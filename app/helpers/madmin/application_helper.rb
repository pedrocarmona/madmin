module Madmin
  module ApplicationHelper
    include Pagy::Frontend

    # Converts a Rails version to a NPM version
    def npm_rails_version
      version = [
        Rails::VERSION::MAJOR,
        Rails::VERSION::MINOR,
        Rails::VERSION::TINY
      ].join(".")

      version += "-#{Rails::VERSION::PRE}" if Rails::VERSION::PRE
      version
    end

    def render_field(field:, partial:, record:, form: nil, resource: nil)
      send(
        "render_field_via_#{field.class.renderer}",
        field: field,
        partial: partial,
        record: record,
        form: form,
        resource: resource
      )
    end

    private

    def render_field_via_partial(field:, partial:, record:, form:, resource:)
      render(
        partial: field.to_partial_path(partial),
        locals: { field: field, record: record, form: form, resource: resource }
      )
    end

    def render_field_via_method(field:, partial:, record:, form:, resource:)
      case partial.to_s
      when 'form'
        field.form(record: record, form: form, resource: resource)
      when 'index'
        field.index(record: record)
      when 'show'
        field.show(record: record)
      end
    end
  end
end
