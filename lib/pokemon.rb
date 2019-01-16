class Pokemon

  attr_accessor :id, :name, :type, :db

  @@all = []

  def initialize(id:, name:, type:, db: @db )
    @id = id
    @name = name
    @type = type
    @db = db
    @@all << self unless @@all.include?(self)
    Pokemon.save(name, type, db) unless @@all.include?(self)
  end

  def self.all
    @@all
  end

  def self.save(pokemon_name, type, db)
    sql = <<-SQL
      insert into pokemon (name, type) values (?, ?)
      SQL
      db.execute(sql, pokemon_name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      select * from pokemon where id = ?
      SQL
      data = db.execute(sql, id)
      Pokemon.new(id: data[0][0], name: data[0][1], type: data[0][2])
  end

end
