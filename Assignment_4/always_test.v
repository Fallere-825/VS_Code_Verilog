module always_test();
    reg a;
    reg b;
    reg c;
    
    function test_1;
        always @(*)
        begin
            c = a + b;
        end
    endfunction
    
    task test_2;
        always @(*)
        begin
            c = a + b;
        end
    endtask
endmodule
