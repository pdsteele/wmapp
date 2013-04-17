module WorklogHelper

  def store_workorder (workorder)
    self.current_workorder = workorder
  end

  def current_workorder=(workorder)
    @current_workorder = workorder
  end

  def get_current_workorder
    @current_workorder = self.current_workorder
  end
end
