# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/api'

require 'hanami/middleware/body_parser'
use Hanami::Middleware::BodyParser, :json

class App < Hanami::API
  helpers do
    def map_body_to_outbound
      {
        job: {
          pickups: [{
            address: params[:package][:collect_task][:address][:street_name]
          }],
          dropoffs: [{
            client_reference: params[:package][:reference],
            package_type: params[:package][:dimensions][:size],
            address: params[:package][:deliver_task][:address][:street_name],
            contact: {
              contact_phone: params[:package][:deliver_task][:address][:contact_phone]
            }
          }]
        }
      }
    end

    def make_request(_body)
      {
        id: 100_432_273,
        status: 'in_progress',
        package_type: 'something',
        deliveries: [
          {
            id: 100_515_659,
            status: 'waiting_at_dropoff',
            delivered_at: nil,
            client_reference: 'client-reference',
            package_description: nil,
            package_type: 'something',
            pickup: {
              id: 2_598_682,
              address: {
                street: 'something'
              }
            },
            dropoff: {
              id: 2_598_683,
              address: {
                street: 'something'
              },
              contact: {
                phone: '3312211234',
                company_name: nil,
                email: nil
              }
            }
          }
        ]
      }
    end

    def map_outbound_response_body(response_body)
      {
        package: {
          reference: response_body[:deliveries].first[:client_reference]
        }
      }
    end
  end

  post '/' do
    outbound_body = map_body_to_outbound
    response_body = make_request(outbound_body)
    json map_outbound_response_body(response_body)
  end
end

run App.new
