# Tips

* sys
  * sys.argv -> list
  * sys.exit("something to print")

* csv
  * csv.reader(file) -> list
  * csv.DictReader(file) -> dict(according to the first line)
  * csv.writer(file) -> list writer.writerow(list)
  * csv.DictWriter(file) -> dict writer.writerow(dict)

* raise
  * raise ValueError("something to print")

* class
  * \__init\__() -> constructor
  
  * \__str\__() -> if it has \__str\__()，then print(z) -> print(z.\__str\__())

  * \__call\__(self) -> if it has \__call\__(), then z() -> z.\__call\__()

  * operator overloading
    
    1. \__add__(self, other) -> +
  
  * @property -> getter 把函数变成属性调用

  * @property.setter -> setter
  
    ```python
    class person:
    	def __init__(self, name):
        self.name = name
    
    	@property
    	def name(self):
        return self._name
     
    	@name.setter
    	def name(self, name):
        if not name:
            raise ValueError("Name cannot be empty")
        self._name = name

    	@classmethod
    	def Get(cls):
      	name = input("What is your name? ")
      	return cls(name) 
    ```
  
  * @classmethod exists in class not in object
    
    ```python
    class Hat:
      houses = ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]
    
      @classmethod
      def sort(cls, name):
        return cls.houses[hash(name) % 4]
      
    ClassName.classmethod_name()
    ```

  * @staticmethod 将一个方法转换为静态方法，它不接收隐式的第一个参数（self或cls）

  	```python
  	ClassName.staticmethod_name()
  	```

  * inheritance 
  
    ```python
    class person:
      def __init__(self, name):
        if not name:
          raise ValueError("Name cannot be empty")
        self.name = name
    
    class student(person):
      def __init__(self, name, school):
        super().__init__(name)
        self.school = school 
    ```
    
    