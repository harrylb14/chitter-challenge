require 'pg'
require_relative 'database_connection'

class Peep
  attr_reader :id, :content
  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM peeps;")
    result.map do |peep| 
      Peep.new(id: peep['id'], content: peep['content'])
    end
  end

  def self.add(content:)
    result = DatabaseConnection.query("INSERT INTO peeps (content) 
      VALUES ('#{content}') 
      RETURNING *;")
    Peep.new(id: result[0]['id'], content: result[0]['content'])
  end
end
