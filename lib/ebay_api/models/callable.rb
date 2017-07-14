module EbayApi::Callable
  def call(*args)
    new(*args)
  end

  def [](*args)
    new(*args)
  end
end
