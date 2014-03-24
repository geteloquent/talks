# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.active_leaf_class = ''
  navigation.autogenerate_item_ids = false

  navigation.items do |primary|
    primary.dom_class = 'nav'
    primary.item :add_talk, 'Adicionar palestra', new_talk_path
  end
end
