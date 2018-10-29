class Employee
  attr_reader :name
  attr_accessor :title, :salary, :boss 
  
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multiplier)
    @salary * multiplier
  end
  
  # def do_work
  #   p "type"
  # end
end

class Manager < Employee
  attr_accessor :employees
  
  def initialize(*args)
    super(args[0], args[1], args[2], args[3])
    @employees = args[4]
  end
  
  def bonus(multiplier)
    bonus = 0
    @employees.each {|employee| bonus += employee.salary }
    bonus * multiplier
  end
  
  # def do_work
  #   p "Hey you go "
  #   super
  # end
end