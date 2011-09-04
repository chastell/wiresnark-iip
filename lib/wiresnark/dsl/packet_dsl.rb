module Wiresnark module DSL::PacketDSL

  def destination_mac mac = nil
    mac.nil? ? params[:destination_mac] : params[:destination_mac] = mac
  end

  def min_size size = nil
    size.nil? ? params[:min_size] || 60 : params[:min_size] = size
  end

  def params
    @params ||= {}
  end

  def payload payload = nil
    payload.nil? ? params[:payload] : params[:payload] = payload
  end

  def random_size range = nil
    range.nil? ? params[:random_size] : params[:random_size] = range
  end

  def source_mac mac = nil
    mac.nil? ? params[:source_mac] : params[:source_mac] = mac
  end

  def type type = nil
    type.nil? ? params[:type] : params[:type] = type
  end

end end
