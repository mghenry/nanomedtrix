Spree::Image.class_eval do
	attachment_definitions[ :attachment ][ :styles ] = {
		mini:    '48x48',
		small:   '64x64',
		product: '240x240',
		large:   '600x600'
	}
end