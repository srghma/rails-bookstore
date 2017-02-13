class Dimensions
  def initialize(height: nil, width: nil, depth: nil)
    @measurements = { h: height, w: width, d: depth }
  end

  def empty?
    @measurements.all? { |_, measurement| measurement.blank? }
  end

  def to_s
    @measurements
      .map { |label, measurement| measurement_to_s(label, measurement) }
      .compact
      .join(' × ')
  end

  private

  def measurement_to_s(label, measurement)
    return if measurement.blank? || measurement.zero?
    format '%s:%0.1f′′', label.capitalize, measurement
  end
end
