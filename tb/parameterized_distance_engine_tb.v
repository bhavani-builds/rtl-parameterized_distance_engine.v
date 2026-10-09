
`timescale 1ns/1ps

module parameterized_distance_engine_tb;

    reg clk, reset, enable;
    reg [63:0] features, references;
    wire [63:0] distance;
    wire valid;

    parameterized_distance_engine dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .features(features),
        .references(references),
        .distance(distance),
        .valid(valid)
    );

    always #5 clk = ~clk;

    task run_test;
        input [63:0] input_features;
        input [63:0] input_references;
        input [63:0] expected_distance;
        begin
            @(negedge clk);
            features = input_features;
            references = input_references;
            enable = 1;

            @(negedge clk);
            enable = 0;

            // Check after the registered output updates
            #1;
            if (valid !== 1'b1 || distance !== expected_distance) begin
                $error("FAIL: Expected %0d, got %0d",
                       expected_distance, distance);
                $fatal(1);
            end

            $display("PASS: Distance = %0d", distance);
        end
    endtask

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        features = 0;
        references = 0;

        repeat (2) @(negedge clk);
        reset = 0;

        // Normal sample: distance = 31
        run_test(
            {16'd405, 16'd299, 16'd201, 16'd102},
            {16'd400, 16'd300, 16'd200, 16'd100},
            64'd31
        );

        // Anomaly sample: distance = 532400
        run_test(
            {16'd100, 16'd800, 16'd20, 16'd500},
            {16'd400, 16'd300, 16'd200, 16'd100},
            64'd532400
        );

        $display("PASS: All distance tests completed.");
        $finish;
    end

endmodule
