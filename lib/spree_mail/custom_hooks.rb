module SpreeMail
  class CustomHooks < Spree::ThemeSupport::HookListener

    # public    
    insert_after :footer_left,  'hooks/footer_left'
    insert_after :footer_right,  'hooks/footer_right'
    insert_after :signup_below_password_fields, 'hooks/signup_checkbox'

    # admin
    insert_after :admin_tabs,   'admin/hooks/subscribers_tab'

  end
end