# frozen_string_literal: true

class GetCharactersService
  def call(filter_params, page = 1)
    characters = Character.all

    filter_params&.each do |key, value|
      characters = characters.public_send("filter_by_#{key}", value)
    end

    characters = characters.page(page).per(15)

    meta = {
      current_page: characters.current_page,
      next_page: characters.next_page,
      prev_page: characters.prev_page,
      total_pages: characters.total_pages
    }

    characters = insertion_sort(characters.to_a)

    {
      data: characters,
      meta: meta
    }
  end

  private

  def insertion_sort(objects)
    (1...(objects.length)).each { |i|
      value = objects[i]
      p "value - #{value.to_json}"
      temp = i
      while temp > 0 && objects[temp - 1].name > value.name
        objects[temp] = objects[temp - 1]
        temp = temp - 1
      end
      objects[temp] = value
    }
    objects
  end
end
