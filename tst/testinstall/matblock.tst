#@local dim,m1,m2,m3,mm,o1,o2,p1,p2,p3,p4,tmp,z,R,G,H,reps,ind,img
gap> START_TEST("matblock.tst");
gap> m1 := BlockMatrix( [ [ 1, 1, [[1,1],[0,1]] ],
>                         [ 1, 3, [[1,0],[0,1]] ],
>                         [ 2, 2, [[0,1],[1,0]] ],
>                         [ 3, 4, [[1,0],[0,0]] ] ], 3, 4 );
<block matrix of dimensions (3*2)x(4*2)>
gap> m2 := BlockMatrix( [ [ 1, 3, [[1,0],[0,1]] ],
>                         [ 2, 1, [[1,0],[0,1]] ],
>                         [ 3, 2, [[1,0],[0,1]] ] ], 3, 3 );
<block matrix of dimensions (3*2)x(3*2)>
gap> m3 := AsBlockMatrix( m2, 2, 2 );
<block matrix of dimensions (2*3)x(2*3)>
gap> z  := BlockMatrix( [], 3, 3, 2, 2, 0 );
<block matrix of dimensions (3*2)x(3*2)>
gap> NrRows( m1 ); NrCols( m1 ); DimensionsMat( m1 );
6
8
[ 6, 8 ]
gap> NrRows( m2 ); NrCols( m2 ); DimensionsMat( m2 );
6
6
[ 6, 6 ]
gap> NrRows( m3 ); NrCols( m3 ); DimensionsMat( m3 );
6
6
[ 6, 6 ]
gap> NrRows( z ); NrCols( z );  DimensionsMat( z );
6
6
[ 6, 6 ]
gap> m1[3];
[ 0, 0, 0, 1, 0, 0, 0, 0 ]
gap> m1[3][4] := 4;
Error, List Assignment: <list> must be a mutable list
gap> m1[3];
[ 0, 0, 0, 1, 0, 0, 0, 0 ]
gap> z[2];
[ 0, 0, 0, 0, 0, 0 ]
gap> m2 = m3;
true
gap> p1:= m2 * m1;
<block matrix of dimensions (3*2)x(4*2)>
gap> p2:= m3 * m1;
[ [ 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0 ], 
  [ 1, 1, 0, 0, 1, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 1, 0, 0 ], 
  [ 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0 ] ]
gap> p1 = p2;
true
gap> p3:= m1 * TransposedMat( m1 );
<block matrix of dimensions (3*2)x(3*2)>
gap> mm:= MatrixByBlockMatrix( m1 );
[ [ 1, 1, 0, 0, 1, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 1, 0, 0 ], 
  [ 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0 ], 
  [ 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0 ] ]
gap> mm * TransposedMat( mm ) = p3;
true
gap> p4:= TransposedMat( m1 ) * m2;
<block matrix of dimensions (4*2)x(3*2)>
gap> p3 = p4;
false
gap> z = AsBlockMatrix( z, 2, 2 );
true
gap> Zero( m3 ) = z;
true
gap> MatrixByBlockMatrix( m1 );
[ [ 1, 1, 0, 0, 1, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 1, 0, 0 ], 
  [ 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0 ], 
  [ 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0 ] ]
gap> MatrixByBlockMatrix( m2 );
[ [ 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 0, 0 ], 
  [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ] ]
gap> Print( m1 + m1, "\n" );
BlockMatrix( [ [ 1, 1, [ [ 2, 2 ], [ 0, 2 ] ] ], 
  [ 1, 3, [ [ 2, 0 ], [ 0, 2 ] ] ], [ 2, 2, [ [ 0, 2 ], [ 2, 0 ] ] ], 
  [ 3, 4, [ [ 2, 0 ], [ 0, 0 ] ] ] ],3,4,2,2,0 )
gap> m2 + m3;
[ [ 0, 0, 0, 0, 2, 0 ], [ 0, 0, 0, 0, 0, 2 ], [ 2, 0, 0, 0, 0, 0 ], 
  [ 0, 2, 0, 0, 0, 0 ], [ 0, 0, 2, 0, 0, 0 ], [ 0, 0, 0, 2, 0, 0 ] ]
gap> Print( AdditiveInverse( m3 ), "\n" );
BlockMatrix( [ [ 1, 1, [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ -1, 0, 0 ] ] ], 
  [ 1, 2, [ [ 0, -1, 0 ], [ 0, 0, -1 ], [ 0, 0, 0 ] ] ], 
  [ 2, 1, [ [ 0, -1, 0 ], [ 0, 0, -1 ], [ 0, 0, 0 ] ] ], 
  [ 2, 2, [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ -1, 0, 0 ] ] ] ],2,2,3,3,0 )
gap> m1 * [ 1, 2, 3, 4, 5, 6, 7, 8 ];
[ 8, 8, 4, 3, 7, 0 ]
gap> m2 * [ 1, 2, 3, 4, 5, 6 ];
[ 5, 6, 1, 2, 3, 4 ]
gap> [ 1, 2, 3, 4, 5, 6 ] * m1;
[ 1, 3, 4, 3, 1, 2, 5, 0 ]
gap> z * [ 1, 2, 3, 4, 5, 6 ];
[ 0, 0, 0, 0, 0, 0 ]
gap> [ 1, 2, 3, 4, 5, 6 ] * z;
[ 0, 0, 0, 0, 0, 0 ]
gap> 3 * m1;
<block matrix of dimensions (3*2)x(4*2)>
gap> Print( m2 * 5, "\n" );
BlockMatrix( [ [ 1, 3, [ [ 5, 0 ], [ 0, 5 ] ] ], 
  [ 2, 1, [ [ 5, 0 ], [ 0, 5 ] ] ], [ 3, 2, [ [ 5, 0 ], [ 0, 5 ] ] ] ],3,3,2,
2,0 )
gap> o1:= One( m2 );
<block matrix of dimensions (3*2)x(3*2)>
gap> o2:= One( z );
<block matrix of dimensions (3*2)x(3*2)>
gap> o1 = o2;
true

# New style access to block matrix
gap> dim := DimensionsMat( m1 );;
gap> tmp := List([1..dim[1]], row->List([1..dim[2]], col -> m1[row,col]));;
gap> tmp = MatrixByBlockMatrix(m1);
true
gap> dim := DimensionsMat( m2 );;
gap> tmp := List([1..dim[1]], row->List([1..dim[2]], col -> m2[row,col]));;
gap> tmp = MatrixByBlockMatrix(m2);
true

# block matrices are immutable
#@if IsHPCGAP
gap> m1[1,2] := 5;
Error, Matrix Assignment: <mat> must be a mutable matrix (not an atomic compon\
ent object)
#@else
gap> m1[1,2] := 5;
Error, Matrix Assignment: <mat> must be a mutable matrix (not a component obje\
ct)
#@fi

# Matrix operations for block matrices
gap> R:= BaseDomain( MatrixByBlockMatrix( m2 ) );;
gap> R = BaseDomain( m2 );
true
gap> TraceMatrix( m2 ) = TraceMatrix( MatrixByBlockMatrix( m2 ) );
true
gap> Determinant( m2 ) = Determinant( MatrixByBlockMatrix( m2 ) );
true
gap> MinimalPolynomial( R, m2 ) = MinimalPolynomial( R, MatrixByBlockMatrix( m2 ) );
true

# Groups that consist of block matrices
gap> G:= SmallGroup( 24, 12 );;
gap> H:= SylowSubgroup( G, 2 );;
gap> reps:= IrreducibleRepresentations( H );;
gap> ind:= InducedRepresentation( reps[5], G );;
gap> img:= Image( ind );;
gap> ForAll( GeneratorsOfGroup( img ), IsBlockMatrixRep );
true
gap> Size( img );
24

#
gap> STOP_TEST("matblock.tst");
