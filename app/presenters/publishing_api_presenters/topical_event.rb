require_relative "../publishing_api_presenters"

class PublishingApiPresenters::TopicalEvent < PublishingApiPresenters::Placeholder
  def details
    super.tap do |details|
      details[:start_date] = item.start_date.to_datetime if item.start_date
      details[:end_date] = item.end_date.to_datetime if item.end_date
    end
  end

  def links
    extract_links([:topics])
  end
end
