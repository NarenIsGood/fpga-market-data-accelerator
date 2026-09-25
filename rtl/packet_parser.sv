module packet_parser (
    input logic clk,
    input logic reset,
    input logic [7:0] data_in,
    input logic valid,

    output logic [7:0] message_type,
    output logic [7:0] symbol_id,
    output logic [15:0] price,
    output logic parsed_valid
);

    logic [1:0] byte_count;
    logic [7:0] price_high;

    always_ff @(posedge clk) begin
        if (reset) begin
            byte_count <= 2'd0;
            message_type <= 8'd0;
            symbol_id <= 8'd0;
            price_high <= 8'd0;
            price <= 16'd0;
            parsed_valid <= 1'b0;
        end
        else begin
            parsed_valid <= 1'b0;

            if (valid) begin
                case (byte_count)

                    2'd0: begin
                        message_type <= data_in;
                        byte_count <= 2'd1;
                    end

                    2'd1: begin
                        symbol_id <= data_in;
                        byte_count <= 2'd2;
                    end

                    2'd2: begin
                        price_high <= data_in;
                        byte_count <= 2'd3;
                    end

                    2'd3: begin
                        price <= {price_high, data_in};
                        parsed_valid <= 1'b1;
                        byte_count <= 2'd0;
                    end

                    default: begin
                        byte_count <= 2'd0;
                    end

                endcase
            end
        end
    end

endmodule