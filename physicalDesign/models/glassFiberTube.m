function mass = glassFiberTube(L, r)
    rStar = 0.05;
    dStar = rStar*2;
    lStar = 2.5;
    mStar = 3;
    mBulkStar = 1;

    mass = mStar * r / 0.05 * L/lStar;
end