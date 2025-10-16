module comparatore(input A, input B, output GT, output EQ, output LT);
assign GT = A & ~B; 
/*
0 0 -> 0
0 1 -> 0
1 1 -> 0
1 0 -> 1
quindi l'espressione fa quello che fa l'operazione di confronto "maggiore di" */
assign EQ = ~(A ^ B); 
/*
0 0 -> 1
0 1 -> 0
1 0 -> 0
1 1 -> 1 */
assign LT = ~A & B;
/*
speculare a quello che abbiamo fatto per GT
*/
endmodule