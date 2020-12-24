class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:contact]

  def index
    @contacts = Contact.all.order(created_at: :desc)
  end

  def contact

    if params[:contacts].present?
      params[:contacts].each do |index, contact|
         next if Contact.find_by(email: contact["email"]["0"]['address']).present? if contact["email"].present? && contact["email"]["0"].present?

        attr = {
          first_name: contact["first_name"].present? ? contact["first_name"] : "",
          last_name: contact["last_name"].present? ? contact["last_name"] : "",
          email: contact["email"].present? && contact["email"]["0"].present? ? contact["email"]["0"]['address'] : "",
          phone_number: contact["phone"].present? && contact["phone"]["0"].present? ? contact["phone"]["0"]["number"] : "",
          job_title: contact["job_title"] ? contact["job_title"] : "",
          dob: contact["dob"] ? contact["dob"] : "",
        }

        if contact["addresses"].present? && (address = contact["addresses"]["0"]).present?
          attr.merge!({
            street: address["street"],
            city: address["city"],
            region: address["region"],
            country: address["country"],
            postal_code: address["postal_code"],
            full_address: address["formatted"].present? ? address["formatted"] : ""
          })
        end

        Contact.create!(attr)
      end
    end
  end

end
