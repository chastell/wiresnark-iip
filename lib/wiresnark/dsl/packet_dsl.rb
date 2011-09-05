module Wiresnark module DSL::PacketDSL

  def destination_mac mac
    params[:destination_mac] = mac
  end

  def min_size size
    params[:min_size] = size
  end

  def params
    @params ||= {}
  end

  def payload payload
    params[:payload] = payload
  end

  def random_size range
    params[:random_size] = range
  end

  def source_mac mac
    params[:source_mac] = mac
  end

  def type type
    params[:type] = type
  end

end end
