module badly_named
   
  class test_class 
    def foo ( a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p   )
      puts "The values passed are these, why did you give me so many?!  #{a} #{b} #{c} #{d} #{e} #{f} #{g} #{h} #{i} #{j} #{j} #{k} #{l} #{m} #{n} #{o} #{p}"
      puts "Lets try some nested ternary operators!"
      result = a == b ? a : c == d ? : e == f ? j : k
    end
  end
end
