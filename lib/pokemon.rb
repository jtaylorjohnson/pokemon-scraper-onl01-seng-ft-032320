class Pokemon
  
  attr_accessor :id, :name, :type, :db 
  
  def initialize (id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
      SQL
    db.execute(sql, name, type) 
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.create(name, type)
    pokemon = Pokemon.new(name, type)
    pokemon.save
    pokemon
  end
  
  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    type = row[2]
    pokemon = self.new(id, name, type)
    pokemon
  end
  
  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    result = db.execute(sql, id)[0]
    self.new_from_db(result)
  end
  
  def update
    sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.type, self.id)
  end

end

