require 'csv'
class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :get_links

	def get_info company
		info = {}
		if company.lat.nil? or company.lng.nil? or !company.photo? or company.address.nil? or company.rating.nil?
			begin
				url = "#{Rails.application.secrets[:google_place_url]}query=#{company.name}+#{company.city}&key=#{Rails.application.secrets[:google_place_key]}"
				puts url
				result = RestClient.get url
				result_json = JSON.parse result
			rescue Exception => e
				info['lat'] = 37.779044
				info['lng'] = -122.418757
				info['img'] = 'place-image.png'
				info['address'] = '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102'
				info['rating'] = 2.5
			else
				if result_json['results'].nil? or result_json['results'].first.nil?
					info['lat'] = 37.779044
					info['lng'] = -122.418757
					info['img'] = 'place-image.png'
					info['address'] = '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102'
					info['rating'] = 2.5
				else
					info['lat'] = result_json['results'].first['geometry']['location']['lat']
					info['lng'] = result_json['results'].first['geometry']['location']['lng']
					info['address'] = result_json['results'].first['formatted_address'].nil? ? '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102' : result_json['results'].first['formatted_address']
					info['rating'] = result_json['results'].first['rating'].nil? ? 2.5 : result_json['results'].first['rating']
					if result_json['results'].first['photos'].nil?
						info['img'] = 'place-image.png'
					else
						photo_reference = result_json['results'].first['photos'].first['photo_reference']
						info['img'] = "#{Rails.application.secrets[:google_photo_url]}maxheight=400&photoreference=#{photo_reference}&key=#{Rails.application.secrets[:google_photo_key]}"
						company.photo_from_url(info['img'])
						info['img'] = company.photo.url
					end
				end
			end

			# Set image from online url and update info['img'] with locally generated url from paperclip
			company.update( :lat => info['lat'], :lng => info['lng'], :address => info['address'], :rating => info['rating'] )
		else
			info['lat'] = company.lat
			info['lng'] = company.lng
			# update info['img'] with locally generated url from paperclip
			info['img'] = company.photo.url
			info['address'] = company.address
			info['rating'] = company.rating
		end

		return info
	end

	def get_ip
		request.remote_ip
		remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
		return remote_ip
	end

	def url_decode url
		decode_url = url.gsub("-", " ")
		# decode_url = decode_url.split.map(&:capitalize).join(' ')
		return decode_url
	end

	def get_links
		@active_links = NavLink.where(active: true).order(:position)
	end

	# Creates a list of models according to required fields mentioned by Model returns nil if format is invalid
	def import_from_csv(file, class_type)
		headers = CSV.read(file.path)[0]
		attributes = class_type.required_columns
		if (attributes - headers).blank?
			list = Array.new
			CSV.foreach(file.path, headers: true) do |row|
				item = class_type.where(name: row[0][1]).first_or_initialize row.to_hash
				list.push item.attributes
			end
			return list
		else
			return nil
		end
    end

	def current_admin
		super || Admin.new
	end

	def analytics
		@analytics ||= CustomAnalytics.new(current_admin, google_analytics_client_id)
	end

	def staccato
		@tracker ||= Staccato.tracker('UA-101010430-1', google_analytics_client_id)	
	end

	def google_analytics_client_id
		google_analytics_cookie.gsub(/^GA\d\.\d\./, '')
	end

	def google_analytics_cookie
		cookies['_ga'] || ''
	end
end