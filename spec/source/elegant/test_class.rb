module BadlyNamed
  class TestClass
    def foo(*args)
      arg_str = args.join(" ")
      puts("The values passed: #{arg_str}")
    end
  end
end
