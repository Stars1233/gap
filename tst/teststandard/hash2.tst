#############################################################################
##
##  Test orbit algorithms, which use hashing
##  Exclude from testinstall.g as it takes considerable time.
##
gap> START_TEST("hash2.tst");
gap> g:=GL(18,2);;
gap> Length(Orbit(g,g.1[1],OnRight));
262143
gap> g:=GL(8,2);;
gap> Length(Orbit(g,g.1,OnPoints));
32385
gap> m1:=NullMat(32,32,Z(2));;
gap> for i in [1,9..25] do m1{[i..i+7]}{[i..i+7]}:=g.1;od;
gap> m2:=NullMat(32,32,Z(2));;
gap> for i in [1,9..25] do m2{[i..i+7]}{[i..i+7]}:=g.2;od;
gap> h:=Group(m1,m2);;
gap> Length(Orbit(h,h.1,OnPoints));
32385
gap> g:=SU(6,3);;
gap> Length(Orbit(g,g.1[1],OnRight));
177632
gap> g:=SU(6,2);;
gap> Length(Orbit(g,g.2^5,OnPoints));
693
gap> m1:=NullMat(60,60,Z(4));;
gap> for i in [1,7..55] do m1{[i..i+5]}{[i..i+5]}:=g.1;od;
gap> m2:=NullMat(60,60,Z(4));;
gap> for i in [1,7..55] do m2{[i..i+5]}{[i..i+5]}:=g.2;od;
gap> h:=Group(m1,m2);;
gap> Length(Orbit(h,h.1[1],OnRight));
2079
gap> Length(Orbit(h,h.2^5,OnPoints));
693
gap> Length(Orbit(SymmetricGroup(14), [1 .. 7], OnSets));
3432
gap> Length(Orbit(SymmetricGroup(16), [1 .. 8], OnSets));
12870
gap> STOP_TEST("hash2.tst");
