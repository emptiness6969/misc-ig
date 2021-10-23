old = hookfunction(getfenv, function(...)
    print(...)    
    return old(...)
end)
