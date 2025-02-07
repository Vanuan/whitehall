require 'test_helper'

class PublishingApiPresenters::TopicalEventTest < ActiveSupport::TestCase
  test 'presents a valid placeholder "topical_event" content item' do
    topical_event = create(:topical_event, :active, name: "Humans going to Mars")
    public_path = '/government/topical-events/humans-going-to-mars'

    expected_hash = {
      base_path: public_path,
      publishing_app: "whitehall",
      rendering_app: "whitehall-frontend",
      format: "placeholder_topical_event",
      title: "Humans going to Mars",
      description: nil,
      locale: "en",
      need_ids: [],
      routes: [
        {
          path: public_path,
          type: 'exact'
        }
      ],
      redirects: [],
      public_updated_at: topical_event.updated_at,
      details: {
        start_date: topical_event.start_date,
        end_date: topical_event.end_date,
      }
    }

    presenter = PublishingApiPresenters::TopicalEvent.new(topical_event)

    assert_equal expected_hash, presenter.content
    assert_valid_against_schema(presenter.content, 'placeholder')
  end

  test 'handles topical events without dates' do
    topical_event = create(:topical_event, name: "Humans going to Mars")
    public_path = '/government/topical-events/humans-going-to-mars'

    expected_hash = {
      base_path: public_path,
      publishing_app: "whitehall",
      rendering_app: "whitehall-frontend",
      format: "placeholder_topical_event",
      title: "Humans going to Mars",
      description: nil,
      locale: "en",
      need_ids: [],
      routes: [
        {
          path: public_path,
          type: 'exact'
        }
      ],
      redirects: [],
      public_updated_at: topical_event.updated_at,
      details: {}
    }

    presenter = PublishingApiPresenters::TopicalEvent.new(topical_event)

    assert_equal expected_hash, presenter.content
    assert_valid_against_schema(presenter.content, 'placeholder')
  end

  test "handles topical events without an end_date" do
    topical_event = create(:topical_event, start_date: Date.today)

    presenter = PublishingApiPresenters::TopicalEvent.new(topical_event)

    assert_equal({ start_date: Date.today }, presenter.content[:details])
    assert_valid_against_schema(presenter.content, 'placeholder')
  end
end
