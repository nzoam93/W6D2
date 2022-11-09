class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |method_name|
      define_method("#{method_name}=") do |new_value|
        instance_variable_set("@#{method_name}", new_value)
      end
    end

    names.each do |method_name|
      define_method("#{method_name}") do
        instance_variable_get("@#{method_name}")
      end
    end
  end
end
