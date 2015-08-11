`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:17 04/21/2013 
// Design Name: 
// Module Name:    trafficsystem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module trafficsystem(clk, ns_sensor, ew_sensor, Gew, Gns, Yew, Yns, Rew, Rns);

input ns_sensor, ew_sensor;
input clk;

output reg Gew, Gns, Yew, Yns, Rew, Rns;

reg [3:0] state;
reg [3:0] nextState;
reg [1:0] nsSensorWait;
reg [1:0] ewSensorWait;
wire clkout;

//        NS EW
parameter RedRedforNS = 0;
parameter RedYellow = 1;
parameter RedGreen = 2;
parameter GreenRed = 3;
parameter YellowRed = 4;
parameter RedRedforEW = 5;
parameter RedYellowforNS = 6;
parameter RedYellowforEW = 7;
parameter YellowRedforNS = 8;
parameter YellowRedforEW = 9;
clockdivider cd(clk, clkout);

initial begin
state = RedRedforNS;
nextState = RedRedforNS;
ewSensorWait = 0;
nsSensorWait = 0;
end


always@(posedge clkout) begin

	if (state == RedRedforEW) begin
		Rew = 1; Rns = 1;
		Gew = 0; Gns = 0; Yew = 0; Yns = 0; 
		nextState = RedGreen;
	end
	
	else if (state == RedRedforNS) begin
		Rew = 1; Rns = 1;
		Gew = 0; Gns = 0; Yew = 0; Yns = 0; 
		nextState = GreenRed;
	end
	
   else if (state == RedGreen) begin
		Gew = 1; Rns = 1;
		Rew = 0; Gns = 0; Yew = 0; Yns = 0; 
		if (ns_sensor) begin
			nsSensorWait = nsSensorWait + 1; 
			if (nsSensorWait == 2) begin
				nextState = RedYellowforNS;
				nsSensorWait = 0;
			end
			else begin
				nextState = RedGreen;
			end
		end
		else begin
			nextState = RedGreen;
			nsSensorWait = 0;
		end
	end
	
	else if (state == RedYellowforNS) begin
		Yew = 1; Rns = 1;
		Gew = 0; Gns = 0; Yns = 0; Rew = 0;
		nextState = RedRedforNS;
	end
	
	else if (state == RedYellowforEW) begin
		Yew = 1; Rns = 1;
		Gew = 0; Gns = 0; Yns = 0; Rew = 0;
		nextState = RedRedforEW;
	end
	
	else if (state == YellowRedforNS) begin
		Rew = 1; Yns = 1;
		Gew = 0; Gns = 0; Yew = 0; Rns = 0;
		nextState = RedRedforNS;
	end
	
	else if (state == YellowRedforEW) begin
		Rew = 1; Yns = 1;
		Gew = 0; Gns = 0; Yew = 0; Rns = 0;
		nextState = RedRedforEW;
	end
	
	else if (state == GreenRed) begin
		Rew = 1; Gns = 1;
		Gew = 0; Yns = 0; Yew = 0; Rns = 0;
		if (ew_sensor) begin
			ewSensorWait = ewSensorWait + 1; 
			if (ewSensorWait == 2) begin
				nextState = YellowRedforEW;
				ewSensorWait = 0;
			end
			else begin
				nextState = GreenRed;
			end
		end
		else begin
			nextState = GreenRed;
			ewSensorWait = 0;
		end
	end
	

	state = nextState;
	
	
end




endmodule
