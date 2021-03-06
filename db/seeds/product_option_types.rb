species        = Spree::OptionType.find_by_presentation!( 'Species' )
stem_cell_type = Spree::OptionType.find_by_presentation!( 'Type' )

[ 
	'NMTx NMT-RE -xxa',
	'NMTx NMT-RE -xxb',
	'NMTx NMT-RE -xxx',
	'NMTx NMT-MSN -xxa',
	'NMTx NMT-MSN -xxb',
	'NMTx NMT-MSN -xxx'
].each do | name |
	product              = Spree::Product.find_by_name!( name )
	product.option_types = [ species ]

	product.save!
end

nmtx_stem_cells              = Spree::Product.find_by_name!( 'NMTx Stem Cells' )
nmtx_stem_cells.option_types = [ species, stem_cell_type ]
nmtx_stem_cells.save!
