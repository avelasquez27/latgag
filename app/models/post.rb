class Post < ActiveRecord::Base
	def post_params
		params.require(:post).permit(:photo, :title, :description, :user_id)
	end
	belongs_to :user
	validates_presence_of :title, :extension,  :description

	PHOTOS = File.join Rails.root,'public','photo_store'
	after_save :save_photo

	def photo=(file_data)
		unless file_data.blank?
			@file_data = file_data
			self.extension = file_data.original_filename.split('.').last.downcase			
		end
	end

	def photo_filename
		File.join PHOTOS, "#{id}.#{extension}"
	end

	def photo_path
		"/photo_store/#{id}.#{extension}"
	end

	def myposts_path
		"/views/posts/myposts.html.erb"
	end

	private
	
	def save_photo
		if @file_data
			FileUtils.mkdir_p PHOTOS
			File.open(photo_filename, 'wb') do |f|
				f.write(@file_data.read)
			end
		end
	@file_data = nil
	end
end
