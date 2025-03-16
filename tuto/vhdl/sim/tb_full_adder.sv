module tb_full_adder();

    time WAITING_TIME = 10ns;

    logic l_i_operand1;
    logic l_i_operand2;
    logic l_i_carry;

    logic l_o_result;
    logic l_o_carry;

    full_adder full_adder_instance (
        .i_operand1(l_i_operand1),
        .i_operand2(l_i_operand2),
        .i_carry(l_i_carry),
        .o_result(l_o_result),
        .o_carry(l_o_carry)
    );

    initial begin
        for (int i = 0; i < 2; i++) begin
            for (int j = 0; j < 2; j++) begin
                for (int k = 0; k < 2; k++) begin
                    l_i_operand1    = i;
                    l_i_operand2    = j;
                    l_i_carry       = k;

                    #WAITING_TIME;

                    if (i + j + k == 0) begin
                        assert(l_o_result == 0) else $fatal;
                        assert(l_o_carry == 0) else $fatal;
                    end

                    if (i + j + k == 1) begin
                        assert(l_o_result == 1) else $fatal;
                        assert(l_o_carry == 0) else $fatal;
                    end

                    if (i + j + k == 2) begin
                        assert(l_o_result == 0) else $fatal;
                        assert(l_o_carry == 1) else $fatal;
                    end

                    if (i + j + k == 3) begin
                        assert(l_o_result == 1) else $fatal;
                        assert(l_o_carry == 1) else $fatal;
                    end
                end
            end
        end
        $stop;
    end


endmodule
