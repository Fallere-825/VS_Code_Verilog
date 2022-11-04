module initial_test();
    reg a;
    reg b;
    reg c;
    
    task test_1;
        initial @(*)
        begin
            c = a + b;
        end
    endtask
    
    function test_2;
        initial @(*)
        begin
            c = a + b;
        end
    endfunction
endmodule
