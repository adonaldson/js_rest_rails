module JsRestHelper
  def render_js_rest_data(data_name, data_array)
    @js_rest_model_includes ||= {}

    unless @js_rest_model_includes[data_name.to_sym]
      javascript "js_rest_models/#{data_name.singularize}"
      @js_rest_model_includes[data_name.to_sym] = true
    end

    javascript do
      "Data.post = {
        #{render :partial => 'shared/js_rest_item', :collection => data_array}
      };"
    end
  end

  def js_rest_javascript_includes
    javascript_include_tag('js_rest_base/inheritance', 'js_rest_base/data', 'js_rest_base/view', 'js_rest_base/model')
  end

  private
  
  def javascript(*sources)
    if block_given?
      content_for(:javascript) do
        '<script type="text/javascript" charset="utf-8">' +
        '//<![CDATA[
        ' +
          yield +
        '
        //]]>' +
        '</script>'
      end
    else
      content_for(:head) { javascript_include_tag(*sources) }
    end
  end

end
