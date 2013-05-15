module ApplicationHelper

	def javascript_after(*files)
  		content_for(:javascript_after) { javascript_include_tag(*files) }
	end

	def javascript_before(*files)
  		content_for(:javascript_before) { javascript_include_tag(*files) }
	end

	def stylesheet(*files)
  		content_for(:head) { stylesheet_link_tag(*files) }
	end

end
