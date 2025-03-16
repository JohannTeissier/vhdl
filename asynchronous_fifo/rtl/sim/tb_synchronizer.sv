module tb_synchronizer();

    parameter time DELAY = 3ns;
    parameter time PERIOD = 20ns;

    parameter int ITERATIONS = 100;
    parameter int WIDTH = 16;

    logic l_i_clk;
    logic l_i_rst;
    logic [WIDTH - 1 : 0] l_i_data;

    logic [WIDTH - 1 : 0] l_o_data;

    synchronizer #(
        .WIDTH(WIDTH)
    ) synchronizer_instance (
        .i_clk(l_i_clk),
        .i_rst(l_i_rst),
        .i_data(l_i_data),
        .o_data(l_o_data)
    );

    initial l_i_clk = 0;
    always #(PERIOD/2) l_i_clk = ~l_i_clk;


    initial begin

        int data;

        l_i_rst = 1'b1;

        repeat(5) begin
            @(posedge l_i_clk);
        end

        l_i_rst = 1'b0;

        #(DELAY);

        // Test with random values
        for(int i = 0; i < ITERATIONS; i++) begin

            // Generate random values
            data = $urandom_range(0, 2**WIDTH - 1);

            l_i_data = data;

            repeat(2) begin
                @(posedge l_i_clk);
            end
            #DELAY;

            $display("\n------------ Iterations : %0d ------------\n", i);
            $display("i_data : %0d", data);
            $display("o_data : %0d", l_o_data);
            $display("\n------------------------------------------\n");

            assert(l_o_data == data) else $stop;

        end

        $display("Test completed successfully.");
        $stop;
    end

endmodule