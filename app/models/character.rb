# frozen_string_literal: true

class Character < ApplicationRecord
  include Filterable

  SEASONS = {
    '1' => 1..11,
    '2' => 12..21,
    '3' => 22..31,
    '4' => 32..41,
    '5' => 42..51,
    '6' => 52..61
  }

  search_scope :name, lambda { |name|
    where('LOWER(name) LIKE LOWER(:name)', name: "%#{name}%")
  }

  search_scope :episode, lambda { |episode|
    where("#{episode} = ANY (episode)")
  }

  search_scope :episodes, lambda { |episodes|
    where("episode && ?", "{#{episodes.join(',')}}")
  }

  search_scope :season, lambda { |season|
    where("episode && ?", "{#{SEASONS[season].to_a.join(',')}}")
  }

  search_scope :seasons, lambda { |seasons|
    episodes = []
    seasons.each do |season|
      episodes += SEASONS[season].to_a
    end
    where("episode && ?", "{#{episodes.join(',')}}")
  }
end
