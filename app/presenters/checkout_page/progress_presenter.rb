module CheckoutPage
  class ProgressPresenter < Rectify::Presenter
    Step = Struct.new(:classes, :number, :name, :divider?)

    def steps
      wizard_steps.each_with_index.map do |s, index|
        classes = 'step'
        classes += ' active' if index <= current_step_index

        number = index + 1

        name = s.capitalize

        divider = !last?(index)

        Step.new(classes, number, name, divider)
      end
    end

    private

    def last?(index)
      @last ||= wizard_steps.length - 1
      index == @last
    end

    def current?(s)
      step == s
    end

    def current_step_index
      @current_index ||= wizard_steps.index step
    end
  end
end
