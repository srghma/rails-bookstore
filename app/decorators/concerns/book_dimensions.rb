module BookDimensions
  def dimensions
    Dimensions.new(
      height: __getobj__.height,
      width:  __getobj__.width,
      depth:  __getobj__.depth
    )
  end
end
