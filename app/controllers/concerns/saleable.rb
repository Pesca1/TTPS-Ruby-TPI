module Saleable
  extend ActiveSupport::Concern

  def create_params_validation(r)
    errors = []
    if r.key?(:products) && r[:products].any?
      r[:products].each do |p|
        if (!p.key? :id) || (!p.key? :amount)
          errors.push 'invalid_product_request'
          break
        end
        null = false
        if Product.find_by(id: p[:id]).nil?
          errors.push 'invalid_product_id'
          null = true
        end
        if p[:amount] <= 0
          errors.push 'invalid_product_amount'
        elsif !null && p[:amount] > Product.find_by(id: p[:id]).stock
          errors.push 'no_stock'
        end
      end
    else
      errors.push 'no_products'
    end
    if (!r.key? :client_id) || Client.find_by(id: r[:client_id]).nil?
      errors.push 'no_client'
    end
    if errors.any?
      render status: :bad_request, json: { errors: errors.map {|e| { code: e } }}
    end
    return !errors.any?
  end 
end