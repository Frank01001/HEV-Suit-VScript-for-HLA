function Activate ()
    thisEntity:SetThink(Verbose)
end

function Verbose ()
    print(thisEntity:GetClassname())
    return 1
end