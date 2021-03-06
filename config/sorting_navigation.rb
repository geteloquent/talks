# -*- coding: utf-8 -*-

SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.active_leaf_class = ''
  navigation.autogenerate_item_ids = false

  navigation.items do |primary|
    primary.dom_class = 'btn-group'
    primary.item :next, 'Próximas', \
      talks_path(params.merge(sort_by: 'status').except(:page)), class: 'btn', \
      highlights_on: lambda { params[:sort_by] != 'score' }
    primary.item :most_voted, 'Mais Votadas', \
      talks_path(params.merge(sort_by: 'score').except(:page)), class: 'btn', \
      highlights_on: lambda { params[:sort_by] == 'score' }
  end
end
