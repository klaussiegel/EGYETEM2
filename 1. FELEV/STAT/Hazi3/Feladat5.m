function Feladat5()
    prob = [1:4 ; 50/200 , 65/200 , 70/200 , 15/200];

    candidates = 1000;

    blood_type = InversionBySequentialSearch( p , 'LEcuyer' , candidates );
    match = 0;
    mismatch = 0;

    for i=1:candidates
        if (blood_type(i)==2 || blood_type(i)==3)
            match = match + 1;
        else
            mismatch = mismatch + 1;
        end
    end

    probability = match / candidates
    avg = mismatch / match
    hist(blood_type);
end