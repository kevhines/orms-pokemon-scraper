class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(name:, type:, db:, id:nil)
        self.name = name
        self.type = type
        self.db = db
        @id = id
    end

    def self.save(name, type, db)
            sql = <<-SQL
              INSERT INTO pokemon (name, type) 
              VALUES (?, ?)
            SQL
            db.execute(sql, name, type)
          @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon  
            WHERE id = ?
         SQL
      poke_record = db.execute(sql, id).first
     # binding.pry 
      new_pokemon = self.new({name: poke_record[1], type: poke_record[2], db: db, id: id})  
    end
end
