class DummyRelation
  include ArPrettySql::InstanceMethods

  # dummy method to be used in test instances
  def to_sql
    <<-SQL
SELECT * FROM users WHERE name like '%Geoff' AND age <= 23 ORDER BY id ASC LIMIT 10
    SQL
  end
end
