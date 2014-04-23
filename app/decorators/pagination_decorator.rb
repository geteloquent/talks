class PaginationDecorator < Draper::CollectionDecorator
  # Kaminari.
  delegate :current_page, :total_pages, :limit_value
end
