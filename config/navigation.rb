# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.active_leaf_class = ''
  navigation.autogenerate_item_ids = false

  navigation.items do |primary|
    primary.dom_class = 'nav'
    primary.item :talks, 'Palestras', talks_path do |tabs|
      tabs.dom_class = 'nav nav-tabs'
      tabs.item :open, 'Em aberto', talks_path, \
        highlights_on: lambda { !params.has_key? :deadline }
      tabs.item :past, 'Passadas', talks_path(params.merge(deadline: 'past')), \
        highlights_on: lambda { params[:deadline] == 'past' }
    end
  end
end
