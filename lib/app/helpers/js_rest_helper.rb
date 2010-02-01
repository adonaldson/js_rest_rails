module JsRestHelper
  def render_js_rest_data(data_name, data_array, options = {})
    @js_rest_model_includes ||= {}

    unless @js_rest_model_includes[data_name.to_sym]
      javascript "js_rest_models/#{data_name.singularize}"
      @js_rest_model_includes[data_name.to_sym] = true
    end

    json_options = {}
    json_options[:only] = options[:only] unless options[:only].blank?
    json_options[:except] = options[:except] unless options[:except].blank?
    
    javascript do
      "Data.#{data_name.singularize} = {
        #{render :partial => 'shared/js_rest_item', :collection => data_array, :locals => { :json_options => json_options }}
      };"
    end
  end

  def js_rest_javascript_includes
    javascript_include_tag('js_rest/inheritance', 'js_rest/data', 'js_rest/view', 'js_rest/model')
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
