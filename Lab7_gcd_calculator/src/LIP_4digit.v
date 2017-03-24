`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// LIP_4digit : LOGSYS IP k�nyvt�ri elem kijelz�vez�rl�sre
// N�gy sz�mjegyes kijelz� modul hexadecim�lis vagy BCD �rt�kek kijelz�s�re
// Az adatbemenet 16 p�rhuzamos vonal a 4 sz�mjegy bitjei sz�m�ra �s egy k�l�n 
// 4 bites busz a tizedes (hexadecim�lis) pontok vez�rl�s�re. A bemeneti 
// �rt�k lehet hexadecim�lis vagy BCD k�dban, minden k�d �rv�nyes szegmensk�pet 
// eredm�nyez. A kijelz�s id�multiplex m�don t�rt�nik, 1kHz k�r�li kapcsol�si 
// frekvenci�val (a 16MHz �rajelb�l sz�rmaztatva), ami sz�p megjelen�t�st eredm�nyez. 
// Megjegyz�s: Az egys�g m�k�d�si m�dj�b�l k�vetkez�en az adatbemeneti vonalak
// �rt�k�nek v�ltoztat�sa a kijelz�si �llapothoz k�pest tetsz�leges id�pontban
// megt�rt�nhet, az adatbemenet �rajelhez szinkroniz�ci�j�ra nincs sz�ks�g.
//////////////////////////////////////////////////////////////////////////////////
module LIP_4digit(
            input  clk16M,                   	// 16MHz frekvenci�j� �rajel
            input  rst,                         // Szinkron RESET jel
            input  [15:0] number,               // 16 bites sz�m bemenet
            input  [ 3:0] dp,                   // Tizedes pontok
            output [ 7:0] seg,                  // Szegmens kimenetek
            output reg [ 3:0] dig               // Digit kimenetek
                 );


///////////////////////////////////////////////////////////////////////////////////
// A l�ptet�s frekvenci�ja megk�zel�t�en 1kHz, amit a 16MHz-es �rajelb�l �ll�tunk el�
// A bin�ris sz�ml�l�val alap� oszt� minden 2^14 �rajelben el��ll�t egy l�ptet� jelet
///////////////////////////////////////////////////////////////////////////////////

reg [13:0] div;                                 // �rajeloszt� sz�ml�l�
wire rate = &div;	                              // V�g�rt�k pulzus kiad�sa, 
                                                // ha minden bit magas


always @ (posedge clk16M)                       // A sz�ml�l� a 16MHz-r�l fut	
   if (rst)  div <= 14'b0;                      // Kezd��llapot be�ll�t�sa
	else      div <= div + 1;                    // Sz�ml�l�s felfel�
 
//////////////////////////////////////////////////////////////////////////////////
// A 4 sz�mjegyes id�multiplex vez�rl�st egy n�gybites gy�r�s sz�ml�l� vez�rli,
// a sz�mjegyek megjelen�t�se sorrendje balr�l jobbra, MSD -> LSD ir�nyba t�rt�nik
// A sz�ml�l� enged�lyezhet�, l�ptet�se a RATE jel �tem�ben t�rt�nik
// A dig bitekkel k�zvetlen�l v�lasztunk a bemeneti 16 bites adat sz�mjegyei k�z�l
// �s egy�ttal a megfelele� tizedes pontot is kiv�lasztjuk (ha haszn�ljuk)
///////////////////////////////////////////////////////////////////////////////////

always	 @ (posedge clk16M)								// 16MHz-r�l, a RATE jel �tem�ben		
   if (rst)       dig <= 4'b1000;                  // Kezd��llapot, digit[3] akt�v
	else if (rate) dig <= {dig[0], dig[3:1]};       // majd a rate jel �tem�ben l�p
                                                            
wire [3:0] value;
wire  decp;

assign value = ({4{dig[3]}} & number[15:12]) | 		// Elosztott multiplexer h�l�zat, 
					({4{dig[2]}} & number[11: 8]) | 		// a hat�kony er�forr�s kihaszn�l�shoz
					({4{dig[1]}} & number[ 7: 4]) |     // Egy 4 bites 4:1-be busz MUX-ot val�s�t 
					({4{dig[0]}} & number[ 3: 0]);      // meg, AND-OR h�l�zattal

assign decp =  (dig[3] & dp[3]) |						// Ugyanez 1 biten a 4 tizedes pontra
               (dig[2] & dp[2]) |
 					(dig[1] & dp[1]) |
					(dig[0] & dp[0]);
///////////////////////////////////////////////////////////////////////////////////
// A kiv�lasztott sz�m�rt�ket 7 szegmenses kijelz� k�dd� konvert�ljuk
// Az �tk�dol� logik�t pozit�v logika szerint �rjuk fel, azaz az akt�v szegmensek �rt�ke 1
// A szegmensk�p k�dol�sa a k�vetkez�:
//      0            
//     ---
//  5 |   | 1
//     --- <--6
//  4 |   | 2
//     ---  .
//      3   7 A tizedespont a 7. bit, ezt a dekodol�s ut�n illesztj�k be
///////////////////////////////////////////////////////////////////////////////////

reg [6:0] segment;											// V�ltoz� deklar�ci�

always @(*)                   		           		// K�dkonverter kombin�ci�s h�l�zat,  
   begin                                           // L�nyeg�ben egy 16*7 bites ROM
      case (value)            //6543210  szegmensek   
         4'b0000 : segment = 7'b0111111;   // 0
         4'b0001 : segment = 7'b0000110;   // 1
         4'b0010 : segment = 7'b1011011;   // 2
         4'b0011 : segment = 7'b1001111;   // 3
         4'b0100 : segment = 7'b1100110;   // 4
         4'b0101 : segment = 7'b1101101;   // 5
         4'b0110 : segment = 7'b1111101;   // 6
         4'b0111 : segment = 7'b0000111;   // 7
         4'b1000 : segment = 7'b1111111;   // 8
         4'b1001 : segment = 7'b1101111;   // 9
         4'b1010 : segment = 7'b1110111;   // A
         4'b1011 : segment = 7'b1111100;   // b
         4'b1100 : segment = 7'b0111001;   // C
         4'b1101 : segment = 7'b1011110;   // d
         4'b1110 : segment = 7'b1111001;   // E
         4'b1111 : segment = 7'b1110001;   // F
         default : segment = 7'b0000000;   // 0
      endcase
   end 
 
assign seg = {decp,segment};       // Tizedes pont �s szegmensk�d

endmodule 


