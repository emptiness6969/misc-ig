old = hookfunction(getgenv, function(...)
    print(...)    
    return old(...)
end)
