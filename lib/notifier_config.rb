class NotifierConfig
  def initialize(input = 'config/notifications.yml')
    @config = YAML.load(File.read(input))
  end

  def notifications_for(project, event)
    destinations(project).fetch(event.to_s, 'group').to_sym
  end

  def destinations(project)
    @config.fetch(project, {}).fetch('destinations', {})
  end

  def include_ignore_string?(project, target)
    ignore_strings(project).each do |ignore_string|
      return true if target.include?(ignore_string)
    end
    false
  end

  def ignore_strings(project)
    @config.fetch(project, {}).fetch('ignore_strings', [])
  end
end
