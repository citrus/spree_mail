module SpreeMail
  class CustomHooks < Spree::ThemeSupport::HookListener
    
    insert_after :footer_left,  'hooks/footer_left'
    insert_after :signup_below_password_fields, 'hooks/signup_checkbox'

    insert_after :admin_tabs,   'admin/hooks/subscribers_tab'

  end
end