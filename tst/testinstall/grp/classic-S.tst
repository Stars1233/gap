#
# Tests for the "special" group constructors: SL, SO, SU, Sp, SigmaL
#
gap> START_TEST("classic-S.tst");

#
gap> SL(0,5);
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `SpecialLinearGroupCons' on 3 arguments
gap> SL(1,5);
SL(1,5)
gap> ForAll([2,3,4,5,7,9,11], q -> IsTrivial(SL(1,q)));
true
gap> SL(2,5);
SL(2,5)
gap> last = SL(2,GF(5));
true
gap> SL(IsPermGroup,3,4);
Perm_SL(3,4)
gap> last = SL(IsPermGroup,3,GF(4));
true
gap> SL(3);
Error, usage: SpecialLinearGroup( [<filter>, ]<d>, <R> )
gap> SL(3,6);
Error, usage: SpecialLinearGroup( [<filter>, ]<d>, <R> )

#
gap> G:=SL(1,Integers);
SL(1,Integers)
gap> Size(G);
1
gap> Elements(G);
[ [ [ 1 ] ] ]
gap> [[1]] in G;
true
gap> [[-1]] in G;
false

#
gap> G:=SL(2,Integers);
SL(2,Integers)
gap> Size(G);
infinity
gap> [[2,3],[0,1]] in G;
false
gap> [[1,3],[0,1]] in G;
true

#
gap> G := SO(3,5);
SO(0,3,5)
gap> G = SO(0,3,5);
true
gap> G = SO(3,GF(5));
true
gap> G = SO(0,3,GF(5));
true
gap> SO(IsPermGroup,3,5);
Perm_SO(0,3,5)

#
gap> IsTrivial( SO(1,3) );
true
gap> IsTrivial( SO(1,4) );
true

#
gap> SO(3);
Error, usage: SpecialOrthogonalGroup( [<filt>, ][<e>, ]<d>, <q>[, <form>] )
or SpecialOrthogonalGroup( [<filt>, ]<form> )
gap> SO(3,6);
Error, <subfield> must be a prime or a finite field
gap> SO(-1,3,5);
Error, sign <e> <> 0 but dimension <d> is odd
gap> SO(+1,3,5);
Error, sign <e> <> 0 but dimension <d> is odd
gap> SO(2,3,5);
Error, sign <e> must be -1, 0, +1

#
gap> SO(-1,4,9);
SO(-1,4,9)
gap> last = SO(-1,4,GF(9));
true
gap> SO(IsPermGroup,-1,4,9);
Perm_SO(-1,4,9)

#
gap> SO(1,4,9);
SO(+1,4,9)
gap> last = SO(+1,4,GF(9));
true
gap> SO(IsPermGroup,1,4,9);
Perm_SO(+1,4,9)

#
gap> SO(4,9);
Error, sign <e> = 0 but dimension <d> is even
gap> SO(0,4,9);
Error, sign <e> = 0 but dimension <d> is even

#
gap> SU(3,5);
SU(3,5)
gap> SU(IsPermGroup,3,4);
Perm_SU(3,4)
gap> SU(3);
Error, usage: SpecialUnitaryGroup( [<filt>, ]<d>, <q>[, <form>] )
or SpecialUnitaryGroup( [<filt>, ]<form> )
gap> SU(3,6);
Error, <subfield> must be a prime or a finite field

#
gap> Sp(4,5);
Sp(4,5)
gap> last = Sp(4,GF(5));
true
gap> Sp(IsPermGroup,4,5);
Perm_Sp(4,5)
gap> Sp(3,5);
Error, the dimension <d> must be even
gap> Sp(4);
Error, usage: SymplecticGroup( [<filt>, ]<d>, <q>[, <form>] )
or SymplecticGroup( [<filt>, ]<d>, <R>[, <form>] )
or SymplecticGroup( [<filt>, ]<form> )
gap> Sp(4,6);
Error, <subfield> must be a prime or a finite field

#
gap> SigmaL(3,5);
SL(3,5)
gap> SigmaL(3,9);
SigmaL(3,9)
gap> Size(last) / Size(SL(3,9));
2
gap> SigmaL(IsPermGroup,3,9);
Perm_SigmaL(3,9)
gap> SigmaL(3);
Error, usage: SpecialSemilinearGroup( [<filter>, ]<d>, <q> )
gap> SigmaL(3,6);
Error, <subfield> must be a prime or a finite field

#
gap> STOP_TEST("classic-S.tst");
