module tb_half_adder;

    // Parameters
    time WAITING_TIME = 10ns;

    // Inputs
    logic operand1;
    logic operand2;

    // Outputs
    logic result;
    logic carry;

    // Instantiate the Unit Under Test (UUT)
    half_adder uut (
        .i_operand1(operand1),
        .i_operand2(operand2),
        .o_result(result),
        .o_carry(carry)
    );

    initial begin

        // Apply test vectors
        for (int i = 0; i < 2; i++) begin
            for (int j = 0; j < 2; j++) begin
                operand1 = i;
                operand2 = j;

                #WAITING_TIME;

                // Check the result
                if (i + j == 0) begin
                    assert(result == 0) else $fatal("Test failed for input (%b, %b)", operand1, operand2);
                    assert(carry == 0) else $fatal("Test failed for input (%b, %b)", operand1, operand2);
                end

                if (i + j == 1) begin
                    assert(result == 1) else $fatal("Test failed for input (%b, %b)", operand1, operand2);
                    assert(carry == 0) else $fatal("Test failed for input (%b, %b)", operand1, operand2);
                end

                if (i + j == 2) begin
                    assert(result == 0) else $fatal("Test failed for input (%b, %b)", operand1, operand2);
                    assert(carry == 1) else $fatal("Test failed for input (%b, %b)", operand1, operand2);
                end
            end
        end

        // Finish the simulation
        $stop;
    end

endmodule
