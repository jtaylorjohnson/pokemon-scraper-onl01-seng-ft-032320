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
  student = self.new(id, name, grade)
  student
  end
  
  def self.find(name)
    sql = "SELECT * FROM pokemon WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    self.new_from_db(result.flatten)
  end
  
  def update
    sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end

end

