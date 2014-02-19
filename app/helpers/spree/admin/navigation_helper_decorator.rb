module Spree
  module Admin
    module NavigationHelper
      # Make an admin tab that coveres one or more resources supplied by symbols
      # Option hash may follow. Valid options are
      #   * :label to override link text, otherwise based on the first resource name (translated)
      #   * :route to override automatically determining the default route
      #   * :match_path as an alternative way to control when the tab is active, /products would match /admin/products, /admin/products/5/variants etc.
      def tab *args
        options = { label: args.first.to_s }

        # Return if resource is found and user is not allowed to :admin
        return '' if klass = klass_for( options[ :label ] ) and cannot?( :admin, klass )

        if args.last.is_a?( Hash )
          options = options.merge( args.pop )
        end
        options[ :route ] ||=  "admin_#{ args.first }"

        destination_url = options[ :url ] || spree.send( "#{ options[ :route ] }_path" )
        titleized_label = Spree.t( options[ :label ], default: options[ :label ], scope: [ :admin, :tab ] ).titleize

        css_classes = []

        if options[ :icon ]
          link = link_to_with_icon options[ :icon ], titleized_label, destination_url       
        else
          link = link_to titleized_label, destination_url 
        end

        selected = if options[ :match_path ].is_a? Regexp
          request.fullpath =~ options[ :match_path ]
        elsif options[ :match_path ]
          request.fullpath.starts_with?( "#{ admin_path }#{ options[ :match_path ] }" )
        else
          args.include?( controller.controller_name.to_sym )
        end
        css_classes << 'active' if selected

        if options[ :css_class ]
          css_classes << options[ :css_class ]
        end
        
        content_tag( 'li', link, data: { hook: "#{ titleized_label.tr( ' ', '_' ).downcase! }_tab" }, class: css_classes.empty? ? nil : css_classes.join( ' ' ) )
      end

      def link_to_with_icon icon_name, text, url, options = {}
        options[ :class ]  = ( options[ :class ].to_s + " with-tip" ).strip
        options[ :title ]  = text if options[ :no_text ]
        text               = options[ :no_text ] ? '' : raw( " #{ text }" )
        text               = raw "<span class='glyphicon glyph#{ icon_name }'></span> #{ text }"
        options.delete( :no_text )

        link_to text, url, options
      end

      def icon icon_name
        icon_name ? content_tag( :span, '', class: "glyphicon glyph#{ icon_name }" ) : ''
      end

      def button text, icon_name = nil, button_type = 'submit', options = {}
        button_tag options.merge( type: button_type, class: "btn btn-default" ) do 
          if !icon_name
            raw "<span class='glyphicon glyph#{ icon_name }'></span> #{ text }"
          else
            text
          end
        end
      end

      def button_link_to text, url, html_options = {}
        if ( html_options[ :method ] &&
             html_options[ :method ].to_s.downcase != 'get' &&
             !html_options[ :remote ] )
          
          form_tag( url, method: html_options.delete( :method ) ) do
            button text, html_options.delete( :icon ), nil, html_options
          end
        else
          if html_options[ 'data-update' ].nil? && html_options[ :remote ]
            object_name, action           = url.split( '/' )[ -2..-1 ]
            html_options[ 'data-update' ] = [ action, object_name.singularize ].join( '_' )
          end

          html_options.delete( 'data-update' ) unless html_options[ 'data-update' ]

          html_options[ :class ] = 'btn btn-primary'
          html_options[ :role ]  = 'button'

          if html_options[ :icon ]
            link_to url, html_options do 
              raw "<span class='glyphicon glyph#{ html_options[ :icon ] }'></span> #{ text_for_button_link( text, html_options ) }"
            end
          else
            link_to text_for_button_link( text, html_options ), url, html_options
          end
        end
      end

      def text_for_button_link text, html_options
        s =  ''
        s << text

        raw s
      end

      def configurations_menu_item link_text, url, description = ''
        %(<tr>
            <td>#{ link_to( link_text, url ) }</td>
            <td>#{ description }</td>
          </tr>
        ).html_safe
      end

      def configurations_sidebar_menu_item link_text, url, options = {}
        is_active = url.ends_with?( controller.controller_name ) || 
                    url.ends_with?( "#{ controller.controller_name }/edit" ) ||
                    url.ends_with?( "#{ controller.controller_name.singularize }/edit" )
        options.merge!( class: is_active ? 'active' : nil )

        content_tag( :li, options ) do
          link_to link_text, url
        end
      end
    end
  end
end