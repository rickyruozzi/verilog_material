module comparatore4(input [3:0] A, input [3:0] B, output GT, output EQ, output LT);
wire GT1, EQ1, LT1;
wire GT2, EQ2, LT2;
wire GT3, EQ3, LT3;
wire GT4, EQ4, LT4;
comparatore C1(A[3], B[3], GT1, EQ1, LT1);
comparatore C2(A[2], B[2], GT2, EQ2, LT2);
comparatore C3(A[1], B[1], GT3, EQ3, LT3);
comparatore C4(A[0], B[0], GT4, EQ4, LT4);
assign GT = GT1 | (EQ1 & GT2) | (EQ1 & EQ2 & GT3) | (EQ1 & EQ2 & EQ3 & GT4);
/*
- se il primo bit è maggiore imposta su 1 GT
- se il primo bit è uguale , ma il secondo è maggiore imposta su 1 GT
- ... 
*/
assign EQ = EQ1 & EQ2 & EQ3 & EQ4;
/*
tutti i bit devono essere uguali 
*/
assign LT = LT1 | (EQ1 & LT2) | (EQ1 & EQ2 & LT3) | (EQ1 & EQ2 & EQ3 & LT4);
/*
- se il primo bit è inferiore imposta su 1 LT
- se il primo bit è uguale, ma il secondo è minore imposta su 1 LT
- ... 
*/
endmodule