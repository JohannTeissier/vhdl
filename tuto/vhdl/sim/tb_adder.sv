module tb_adder();

    // Constants and Parameters
    time WAITING_TIME = 10ns;
    parameter int ITERATIONS = 500;
    parameter int N_BITS = 8;

    // Signals
    logic [N_BITS - 1 : 0] l_i_operand1;
    logic [N_BITS - 1 : 0] l_i_operand2;
    logic [N_BITS - 1 : 0] l_o_result;
    logic l_o_overflow;

    // Instantiate the Device Under Test (DUT)
    adder #(
        .N_BITS(N_BITS)
    ) adder_instance (
        .i_operand1(l_i_operand1),
        .i_operand2(l_i_operand2),
        .o_result(l_o_result),
        .o_overflow(l_o_overflow)
    );

    // Test process
    initial begin
        // Seed for random number generation
        int x1, x2;

        // Special case test
        l_i_operand1 = {N_BITS{1'b1}}; // 2**N_BITS - 1
        l_i_operand2 = 1;
        #WAITING_TIME;

        // Check the result and overflow
        assert(l_o_result == 0) else $fatal("Result is incorrect");
        assert(l_o_overflow == 1) else $fatal("Overflow flag is incorrect");

        // Test with random values
        for(int i = 0; i < ITERATIONS; i++) begin

            // Generate random values
            x1 = $urandom_range(0, 2**N_BITS - 1);
            x2 = $urandom_range(0, 2**N_BITS - 1);

            l_i_operand1 = x1;
            l_i_operand2 = x2;
            #WAITING_TIME;

            $display("\n------------ Iterations : %0d ------------\n", i);
            $display("x1 : %0d, x2 : %0d", x1, x2);
            $display("result : %0d, overflow : %0b", l_o_result, l_o_overflow);
            $display("\n------------------------------------------\n");


            // Check the result and overflow
            if (x1 + x2 < 2**N_BITS) begin
                assert(l_o_result == (x1 + x2)) else $stop;
                assert(l_o_overflow == 0) else $stop;
            end else begin
                assert(l_o_result == (x1 + x2) % (2**N_BITS)) else $stop;
                assert(l_o_overflow == 1) else $stop;
            end

        end

        $display("Test completed successfully.");
        $stop;
    end

endmodule
