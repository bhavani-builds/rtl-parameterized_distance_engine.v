
module parameterized_distance_engine #(
    parameter DATA_WIDTH = 16,
    parameter NUM_FEATURES = 4,
    parameter DIST_WIDTH = 64
)(
    input wire clk,
    input wire reset,
    input wire enable,

    input wire [DATA_WIDTH*NUM_FEATURES-1:0] features,
    input wire [DATA_WIDTH*NUM_FEATURES-1:0] references,

    output reg [DIST_WIDTH-1:0] distance,
    output reg valid
);

    integer i;
    reg signed [DATA_WIDTH:0] difference;
    reg signed [(2*DATA_WIDTH)+1:0] square;
    reg [DIST_WIDTH-1:0] sum;

    always @(posedge clk) begin
        if (reset) begin
            distance <= 0;
            valid <= 0;
        end else begin
            // Valid is a one-cycle completion pulse
            valid <= 0;

            if (enable) begin
                sum = 0;

                for (i = 0; i < NUM_FEATURES; i = i + 1) begin
                    difference =
                        $signed(features[i*DATA_WIDTH +: DATA_WIDTH]) -
                        $signed(references[i*DATA_WIDTH +: DATA_WIDTH]);

                    square = difference * difference;
                    sum = sum + square;
                end

                distance <= sum;
                valid <= 1;
            end
        end
    end

endmodule
