class Search
  def self.find_by_name(resource, name)
    resource.where('LOWER(name) LIKE ?', "%#{name.downcase}%")
  end
end
