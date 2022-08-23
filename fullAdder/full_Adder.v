module full_adder
  (
    input      a,b,ci,
    output     sum,co
  );
  //-----------arch-----------
  assign {co, sum} = a+b+ci;

endmodule //full_adder
