module ApplicationHelper
	
	
def errors_for(model, attribute)
  if model.errors[attribute].present?
    content_tag :span, class: 'error_explanation' do
      model.errors[attribute].first
    end
  end
end



end
