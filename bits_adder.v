
module bits_adder

#(	parameter width = 3)

(	input [width*2-1:0]SW,
	input SW10,
	output reg [width-1:0] LEDR,
	output reg LEDR10
);

reg [width-1:0] data_a;
reg [width-1:0] data_b;
reg [width-1:0] data_b2;
reg [width-1:0] sum;
reg [width:0] carry;
reg add_sub;
integer i;

always @ (SW, SW10) begin
	data_a = SW[width-1:0];
	data_b = SW[width*2-1:width];
	add_sub = SW10;

	if (add_sub == 1)
		data_b2 = ~data_b;
	else
	   data_b2 = data_b;

	carry[0] = add_sub;

	for(i = 0; i < width; i=i+1) begin
		sum[i] = data_a[i] ^ data_b2[i] ^ carry[i];
		carry[i+1] = (data_a[i]&data_b2[i])|(data_a[i]&carry[i])|(data_b2[i]&carry[i]);
	end

	LEDR10 = carry[width];
	LEDR = sum;
end
endmodule
