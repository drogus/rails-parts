module Parts
  module DefaultLayout
    def _default_layout(require_layout = false)
      layout_name = super

      layout_name || _layout || controller_name
    end
  end
end
