class Task < Ticket
	
  def self.model_name
    Ticket.model_name
  end

  def get_class_colour
  	(task_id.presence ? "#C0BA10" : "#198DE8")
  end

  def get_glyph
    (task_id.presence ? "glyphicon glyphicon-duplicate" : "glyphicon glyphicon-tasks")
  end
end
