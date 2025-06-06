#@local G,M,M2,M3,M4,M5,V,bf,bo,cf,homs,m,mat,qf,randM,res,sf,subs,mats,Q,orig,S
gap> START_TEST("meataxe.tst");

#
# GModuleByMats input validation
#
gap> GModuleByMats();
Error, Usage: GModuleByMats(<mats>,[<dim>,]<field>)
gap> GModuleByMats([], 2, GF(2), "extra");
Error, Usage: GModuleByMats(<mats>,[<dim>,]<field>)
gap> GModuleByMats([[[Z(2)]]], 2, GF(2));
Error, matrices and dim do not fit together
gap> GModuleByMats([[[Z(2),Z(2)]]], GF(2));
Error, <l> must be a list of square matrices of the same dimension
gap> GModuleByMats([[[Z(2)]], [[Z(2),Z(2)],[Z(2),0*Z(2)]]], GF(2));
Error, <l> must be a list of square matrices of the same dimension

# module with no generators
gap> GModuleByMats([], 2, GF(2));
rec( IsOverFiniteField := true, dimension := 2, field := GF(2), 
  generators := [ <an immutable 2x2 matrix over GF2> ], isMTXModule := true, 
  smashMeataxe := rec( isZeroGens := true ) )

#
#
#
gap> G:=SymmetricGroup(3);;
gap> M:=PermutationGModule(G,GF(2));
rec( IsOverFiniteField := true, dimension := 3, field := GF(2), 
  generators := [ <an immutable 3x3 matrix over GF2>, 
      <an immutable 3x3 matrix over GF2> ], isMTXModule := true )
gap> MTX.ModuleAutomorphisms(M);
<matrix group of size 1 with 4 generators>
gap> MTX.IsIndecomposable(M);
false
gap> MTX.IsAbsolutelyIrreducible(M);
false
gap> Display(MTX.IsomorphismModules(M,M));
 1 . .
 . 1 .
 . . 1

#
# Trivial module
#
gap> G:=SL(3,3);;
gap> TrivialGModule(G, GF(2));
rec( IsOverFiniteField := true, dimension := 1, field := GF(2), 
  generators := [ <an immutable 1x1 matrix over GF2>, 
      <an immutable 1x1 matrix over GF2> ], isMTXModule := true )

#
#
#
gap> M2:=TensorProductGModule(M,M);
rec( IsOverFiniteField := true, dimension := 9, field := GF(2), 
  generators := [ <an immutable 9x9 matrix over GF2>, 
      <an immutable 9x9 matrix over GF2> ], isMTXModule := true )
gap> IdGroup(MTX.ModuleAutomorphisms(M2));
[ 1344, 11301 ]
gap> cf:=MTX.CompositionFactors(M2);;
gap> ForAll(cf, MTX.IsAbsolutelyIrreducible);
true
gap> # FIXME:
gap> List(Filtered(cf, x -> x.dimension=2), MTX.InvariantQuadraticForm);
[ <an immutable 2x2 matrix over GF2>, <an immutable 2x2 matrix over GF2>, 
  <an immutable 2x2 matrix over GF2> ]

#
#
#
gap> G:=SymmetricGroup(5);;
gap> M:=PermutationGModule(G,GF(49));
rec( IsOverFiniteField := true, dimension := 5, field := GF(7^2), 
  generators := 
    [ 
      [ [ 0*Z(7), Z(7)^0, 0*Z(7), 0*Z(7), 0*Z(7) ], 
          [ 0*Z(7), 0*Z(7), Z(7)^0, 0*Z(7), 0*Z(7) ], 
          [ 0*Z(7), 0*Z(7), 0*Z(7), Z(7)^0, 0*Z(7) ], 
          [ 0*Z(7), 0*Z(7), 0*Z(7), 0*Z(7), Z(7)^0 ], 
          [ Z(7)^0, 0*Z(7), 0*Z(7), 0*Z(7), 0*Z(7) ] ], 
      [ [ 0*Z(7), Z(7)^0, 0*Z(7), 0*Z(7), 0*Z(7) ], 
          [ Z(7)^0, 0*Z(7), 0*Z(7), 0*Z(7), 0*Z(7) ], 
          [ 0*Z(7), 0*Z(7), Z(7)^0, 0*Z(7), 0*Z(7) ], 
          [ 0*Z(7), 0*Z(7), 0*Z(7), Z(7)^0, 0*Z(7) ], 
          [ 0*Z(7), 0*Z(7), 0*Z(7), 0*Z(7), Z(7)^0 ] ] ], isMTXModule := true 
 )
gap> MTX.ModuleAutomorphisms(M);
<matrix group of size 2304 with 4 generators>
gap> MTX.IsIndecomposable(M);
false
gap> MTX.IsAbsolutelyIrreducible(M);
false

#
gap> M2:=First(MTX.CompositionFactors(M), m -> m.dimension = 4);;
gap> IdGroup(MTX.ModuleAutomorphisms(M2));
[ 48, 2 ]
gap> MTX.IsIndecomposable(M2);
true
gap> MTX.IsAbsolutelyIrreducible(M2);
true
gap> V:= M2.field^[4,4];;
gap> bf:=MTX.InvariantBilinearForm(M2);; bf in V;
true
gap> sf:=MTX.InvariantSesquilinearForm(M2);; sf in V;
true
gap> qf:=MTX.InvariantQuadraticForm(M2);;  qf in V;
true
gap> bo:=MTX.BasisInOrbit(M2);; bo in V;
true
gap> MTX.OrthogonalSign(M2);
1
gap> SMTX.RandomIrreducibleSubGModule(M2); # returns false for irreducible module
false

#
gap> Display(MTX.IsomorphismModules(M,M));
 1 . . . .
 . 1 . . .
 . . 1 . .
 . . . 1 .
 . . . . 1
gap> mat:=
> [[ Z(7^2)^35, 0*Z(7), Z(7^2)^31, Z(7^2)^13, Z(7^2)^9 ],
>  [ Z(7^2)^39, Z(7^2)^3, Z(7^2)^4, Z(7^2)^26, Z(7^2)^36 ],
>  [ Z(7^2)^35, Z(7^2)^38, Z(7^2)^19, 0*Z(7), Z(7^2)^28 ],
>  [ Z(7^2)^45, Z(7^2)^7, Z(7^2)^11, Z(7^2)^25, Z(7^2)^42 ],
>  [ Z(7^2)^37, Z(7^2)^27, Z(7^2)^4, Z(7^2)^44, Z(7^2)^5 ] ];;
gap> M3:=PermutationGModule(G,GF(49));;
gap> M3.generators := List(M3.generators, x -> x^mat);;
gap> fail <> MTX.IsomorphismModules(M,M3);
true

#
gap> M4:=InducedGModule(SymmetricGroup(6),G,M);
rec( IsOverFiniteField := true, dimension := 30, field := GF(7^2), 
  generators := [ < immutable compressed matrix 30x30 over GF(49) >, 
      < immutable compressed matrix 30x30 over GF(49) > ], 
  isMTXModule := true )
gap> SortedList(List(MTX.CompositionFactors(M4), m -> m.dimension));
[ 1, 5, 5, 9, 10 ]

#
gap> M5:=WedgeGModule(M);
rec( IsOverFiniteField := true, dimension := 10, field := GF(7^2), 
  generators := [ < immutable compressed matrix 10x10 over GF(49) >, 
      < immutable compressed matrix 10x10 over GF(49) > ], 
  isMTXModule := true )
gap> SortedList(List(MTX.CompositionFactors(M5), m -> m.dimension));
[ 4, 6 ]
gap> cf:=MTX.CollectedFactors(M5);;
gap> MTX.Distinguish(cf,1);
gap> MTX.Distinguish(cf,2);
gap> MTX.BasesSubmodules(M5);
[ [  ], < immutable compressed matrix 4x10 over GF(49) >, 
  < immutable compressed matrix 6x10 over GF(49) >, 
  < immutable compressed matrix 10x10 over GF(49) > ]
gap> MTX.BasesMinimalSubmodules(M5);
[ < immutable compressed matrix 4x10 over GF(49) >, 
  < immutable compressed matrix 6x10 over GF(49) > ]
gap> MTX.BasesMaximalSubmodules(M5);
[ < immutable compressed matrix 6x10 over GF(49) >, 
  < immutable compressed matrix 4x10 over GF(49) > ]
gap> MTX.BasisRadical(M5);
[  ]
gap> MTX.BasisSocle(M5);
< immutable compressed matrix 10x10 over GF(49) >
gap> subs:=SMTX.MinimalSubGModules(M2,M5);
[ < immutable compressed matrix 4x10 over GF(49) > ]
gap> MTX.BasesMinimalSupermodules(M5,subs[1]) = [ IdentityMat(10,Z(7)) ];
true
gap> homs:=MTX.Homomorphisms(M2,M5);
[ < immutable compressed matrix 4x10 over GF(49) > ]
gap> MTX.Homomorphism(M2,M5,homs[1]);
[ [ Z(7)^0, 0*Z(7), 0*Z(7), 0*Z(7) ], [ 0*Z(7), Z(7)^0, 0*Z(7), 0*Z(7) ], 
  [ 0*Z(7), 0*Z(7), Z(7)^0, 0*Z(7) ], [ 0*Z(7), 0*Z(7), 0*Z(7), Z(7)^0 ] 
 ] -> < immutable compressed matrix 4x10 over GF(49) >

#
gap> randM := SMTX.RandomIrreducibleSubGModule(M)[2];;
gap> MTX.IsIrreducible(randM);
true

#
# Tests for individual Smash meataxe functions
#

#
gap> m:=RegularModule(SymmetricGroup(3), GF(2));
[ [ (1,2,3), (1,2) ], 
  rec( IsOverFiniteField := true, dimension := 6, field := GF(2), 
      generators := [ <an immutable 6x6 matrix over GF2>, 
          <an immutable 6x6 matrix over GF2> ], isMTXModule := true ) ]
gap> res:=SMTX.BasesCSSmallDimUp(m[2]);
[ [  ], [ <a GF2 vector of length 6> ], 
  [ <a GF2 vector of length 6>, <a GF2 vector of length 6> ], 
  [ <a GF2 vector of length 6>, <a GF2 vector of length 6>, 
      <a GF2 vector of length 6>, <a GF2 vector of length 6> ], 
  [ <a GF2 vector of length 6>, <a GF2 vector of length 6>, 
      <a GF2 vector of length 6>, <a GF2 vector of length 6>, 
      <a GF2 vector of length 6>, <a GF2 vector of length 6> ] ]
gap> Display(res[2]);
 1 1 1 1 1 1
gap> Display(res[3]);
 1 . . 1 1 .
 . 1 1 . . 1
gap> Display(res[5]);
 1 . . . . .
 . 1 . . . .
 . . 1 . . .
 . . . 1 . .
 . . . . 1 .
 . . . . . 1

#
gap> G:= SymmetricGroup(3);;
gap> M:= PermutationGModule( G, GF(2) );;
gap> mat:= [ [ 1, 1, 1 ], [ 0, 1, 1 ] ] * Z(2);;
gap> orig:= Immutable( mat );;
gap> S:= MTX.SubGModule( M, mat );;
gap> mat = orig;    # the function call must not change the 2nd argument
true
gap> S = MTX.SubGModule( M, orig ); # 2nd argument may be immutable
true

#
# Tests for MTX.InvariantQuadraticForm and MTX.OrthogonalSign
# (the documentation is a bit unorthodox)
#
# the easy cases:
gap> mats:= GeneratorsOfGroup( GO( 1, 4, 3 ) );;
gap> m:= GModuleByMats( mats, GF(3) );;
gap> Q:= MTX.InvariantQuadraticForm( m );;
gap> Q = TransposedMat( Q );  # bilinear form divided by 2
true
gap> MTX.OrthogonalSign( m );
1
gap> mats:= GeneratorsOfGroup( GO( -1, 4, 3 ) );;
gap> m:= GModuleByMats( mats, GF(3) );;
gap> Q:= MTX.InvariantQuadraticForm( m );;
gap> Q = TransposedMat( Q );  # bilinear form divided by 2
true
gap> MTX.OrthogonalSign( m );
-1
gap> mats:= GeneratorsOfGroup( GO( 5, 3 ) );;
gap> m:= GModuleByMats( mats, GF(3) );;
gap> Q:= MTX.InvariantQuadraticForm( m );;
gap> Q = TransposedMat( Q );  # bilinear form divided by 2
true
gap> MTX.OrthogonalSign( m );
0
gap> mats:= GeneratorsOfGroup( GO( 1, 4, 2 ) );;
gap> m:= GModuleByMats( mats, GF(2) );;
gap> Q:= MTX.InvariantQuadraticForm( m );;
gap> IsLowerTriangularMat( Q );  # characteristic 2
true
gap> MTX.OrthogonalSign( m );
1
gap> mats:= GeneratorsOfGroup( GO( 5, 2 ) );;
gap> m:= GModuleByMats( mats, GF(2) );;
gap> MTX.InvariantQuadraticForm( m );
Error, Argument of InvariantQuadraticForm is not an absolutely irreducible mod\
ule
gap> MTX.OrthogonalSign( m );
Error, Argument of InvariantBilinearForm is not an absolutely irreducible modu\
le
gap> mats:= GeneratorsOfGroup( SP( 4, 2 ) );;
gap> m:= GModuleByMats( mats, GF(2) );;
gap> Q:= MTX.InvariantQuadraticForm( m );
fail
gap> MTX.OrthogonalSign( m );
fail
gap> G:= SU(4, 3);;
gap> m:= GModuleByMats( GeneratorsOfGroup( G ), GF(9) );;
gap> MTX.InvariantBilinearForm( m );
fail
gap> MTX.InvariantQuadraticForm( m );
fail

# the subtle case: odd characteristic, antisymmetric bilinear form
gap> mats:= GeneratorsOfGroup( SP( 4, 3 ) );;
gap> m:= GModuleByMats( mats, GF(3) );;
gap> Q:= MTX.InvariantQuadraticForm( m );;  # matrix for the zero form
gap> Q = TransposedMat( Q );
false
gap> MTX.OrthogonalSign( m );
fail

#
gap> STOP_TEST("meataxe.tst");
