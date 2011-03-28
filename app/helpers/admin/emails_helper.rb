module Admin
  module EmailsHelper
      
    def progress_steps
      states = Email.state_machine.states.map &:name      
      steps = states.map do |state|
        current_index = states.index(@email.state.to_sym)
        state_index = states.index(state)
        text = t("email_states.#{state}")
        if state_index <= current_index
          link_to text, admin_email_state_path(state)
        else
          text
        end
      end
      content_tag('div', raw(steps.join("\n")), :class => 'progress-steps', :id => "checkout-step-#{@email.state}")
    end
      
  end
end