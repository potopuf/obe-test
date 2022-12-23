# frozen_string_literal: true

namespace :migration do
  # Run command 'rake migration:characters'
  desc 'Create characters'
  task characters: :environment do
    def request(page)
      response = HTTP.get("https://rickandmortyapi.com/api/character?page=#{page}")
      unless response.status.success?
        Rails.logger.error(response.status)
        raise HTTP::Error.new
      end
      Oj.load(response.body.to_s, symbol_keys: true)
    end

    def save_characters(characters)
      now = Time.now.utc
      db_data = characters.map do |c|
        episodes = c[:episode]

        {
          name: c[:name],
          status: c[:status],
          species: c[:species],
          gender: c[:gender],
          episode: episodes.map { |e| e.split('/').last },
          created_at: now,
          updated_at: now
        }
      end
      Character.insert_all!(db_data)
    end

    page = 1
    data = request(1)
    save_characters(data[:results])
    pages = data[:info][:pages]
    page = page + 1

    while page <= pages
      data = request(page)
      save_characters(data[:results])
      page = page + 1
    end
  end
end
