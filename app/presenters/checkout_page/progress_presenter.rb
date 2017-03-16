module CheckoutPage
  class ProgressPresenter < Rectify::Presenter
    def initialize(steps, current_step, select_up_to_step)
      @steps = steps
      @current_step = current_step
      @select_up_to_step_index = @steps.index select_up_to_step
    end

    def steps
      @steps.each_with_index.map do |s, index|
        classes = 'step'
        classes += ' active' if active?(index)

        number = index + 1

        name = s.capitalize

        divider = !last?(index)

        { classes: classes, number: number, name: name, divider: divider }
      end
    end

    private

    def last?(index)
      @last_index ||= @steps.length - 1
      index == @last_index
    end

    def active?(index)
      index <= @select_up_to_step_index
    end
  end
end
