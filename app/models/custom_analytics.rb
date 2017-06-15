# app/models/analytics.rb
class CustomAnalytics
  class_attribute :backend
  self.backend = Analytics

  def initialize(user, client_id = nil)
    @user = user
    @client_id = client_id
  end

  def track_user_creation
    identify
    track(
      {
        user_id: user.id,
        event: 'Create User'
      }
    )
  end

  def track_user_sign_in
    identify
    track(
      {
        user_id: user.id,
        event: 'Sign In User'
      }
    )
  end

  def track_company_all(company_name)
    identify
    track(
      {
        user_id: user.id,
        event: "Company Clicked",
        properties: {
            category: "All-Links",
            label: company_name
        }
      }
    )
  end

  def track_company_category(company_name, category)
    identify
    track(
      {
        user_id: user.id,
        event: "Company Clicked",
        properties: {
            category: category,
            label: company_name
        }
      }
    )
  end

  def track_company_rank_all(company_name, rank)
    identify
    track(
      {
        user_id: user.id,
        event: "Company Rank",
        properties: {
            category: "All-Links",
            label: company_name + "#" + rank.to_s
        }
      }
    )
  end

  def track_company_rank_category(company_name, rank, category)
    identify
    track(
      {
        user_id: user.id,
        event: "Company Clicked",
        properties: {
            category: category,
            label: company_name + "#" + rank.to_s
        }
      }
    )
  end

  private

  def identify
    backend.identify(identify_params)
  end

  attr_reader :admin, :client_id

  def identify_params
    {
      user_id: user.id,
      traits: user_traits
    }
  end

  def user_traits
    {
      email: user.email
    }.reject { |key, value| value.blank? }
  end

  def track(options)
    if client_id.present?
      options.merge!(
        context: {
          'Google Analytics' => {
            clientId: client_id
          }
        }
      )
    end
    backend.track(options)
  end
end