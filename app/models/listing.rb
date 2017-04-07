class Listing < ApplicationRecord
	if Rails.env.development?
		has_attached_file :image, styles: { big: "1000x", medium: "50x", thumb: "100x100>" }, default_url: "default.jpg"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  else
    has_attached_file :image, styles: { big: "1000x", medium: "200x", thumb: "100x100>" }, default_url: "default.jpg",
    									:storage => :dropbox,
    									:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    									:path => ":style/:id_:filename"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	end

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates_attachment_presence :image

  belongs_to :user
  has_many :orders
end

