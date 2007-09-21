From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] routing / direct connection
Date: Fri, 21 Sep 2007 20:38:41 +0200
References: <46F26999.1010307@ddmesh.de>
In-Reply-To: <46F26999.1010307@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709212038.41280.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hey, 

I am working on the documentation of  experimental and on the experiences I 
made at the wcw in graz. sorry I just came back from there and need to keep up 
with some postponed work first.

YOu can have a look on the preliminary documentation
https://www.open-mesh.net/batman/doc/BMX#debug-level-1-parameter
to get an idea about the acronyms used in debug-level 1.

Please tell me if there is something you dont understand, so I can correct it 
before I make this url public.


On Donnerstag 20 September 2007, Freifunk Dresden wrote:
> Hello,
>
> Im using the batmand- experimental and have some problems with routing.
> First I like to know the meaning of all the fields of the debug level
> prints and how they are determined.
> It would be great If you can give a more detailed information when to
> use the extended options and what they do
> with batmand. For instance, why should I change the window size (seen in
> Graz experiment).

The window size defines the frame size or the number of recent OGMs over which 
statistics are made for the neighbor ranking.

So a smaller window-size results in a shorter time for the mesh to converge 
and find new routes if something has changed. However it will also cause more 
unnesssary route changes.

I know I am also late with that documentatioin, be patient...
ciau,
axel

>
> My setup is the following. I have a laptop (linux debian) on a table.
> under the table I have a WRT54GS about 50cm below.
> A second router WRT54GL is places on the top of a cupboard which is
> about  1m higher than the laptop and about 3 m
> away. The laptop is offering a gatway.
>
>        Table
>    (wrt B 10.12.10.1)
> (laptop 10.12.0.1)
> ###########
> (wrt A 10.12.10.17)                                                 #
> cupbord ###
>
> laptop ------------ wrt A
>
> wrt B---------------+
>
> My problem is that the connection from the laptop to B is bad (ssh,http
> connection). batman setups the routes so each device
> has a direct connection to the others.
> OLSR has detected this and does not use the direct connection between
> laptop and wrt B. It creates an routing entry to
> route over wrt A in laptop and wrt B. This results in a fast and better
> connection.
>
> laptop                  wrt A
>
> wrt B---------------+
>
> My problem also causes that the wrt B looses the gatway (laptop) and
> removes the default routing entry.
> I have added some traces of the three devices. All devices stay directly
> connected to each other. After
> network start wrt B still shows the gatway of the laptop (over the bad
> connection).
> Later the gateway will vanish and come back only for a short time before
> vanishing again.
>
> LAPTOP:
> -----------
> batmand -s 10.12.0.1 -g 1024/200 --no-unreachable-rule --no-throw-rules
> --no-prio-rules wlan0 bbs /t 1 /i bbc /t 1 /i"
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: wlan0 10.12.0.1, WindSize: 128, BLT: 2,
> OGI: 1000, UT: 0d 0h 0m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.10.1          wlan0      10.12.10.1 ( 46  47   217    0) [
> wlan0  40  48 106]         10.12.10.17 (  1)
> 10.12.10.17         wlan0     10.12.10.17 ( 47  48   239    0) [
> wlan0  44  49 114]          10.12.10.1 (  1)
>
> WRT A
> ---------
> batmand  --no-unreachable-rule --no-throw-rules --no-prio-rules -r 1 eth1
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: eth1 10.12.10.17, WindSize: 128, BLT:
> 2, OGI: 1000, UT: 0d 0h 3m Originator           viaIF         Router
> (brc rcvd lseq lvld) [    viaIF l2q  lq nlq].. alternatives...
> 10.12.0.1            eth1       10.12.0.1 (  7   7     7    0) [
> eth1 119   7 128]          10.12.10.1 (  0)
> 10.12.10.1           eth1      10.12.10.1 (125 126   176    0) [
> eth1 115 126 116]           10.12.0.1 (  1)
>      Gateway              Router (#/128)
> => 10.12.0.1             10.12.0.1 (110), gw_class 33 -
> 1024KBit/256KBit, reliability: 1
>
> WRT B
> ---------
> batmand  --no-unreachable-rule --no-throw-rules --no-prio-rules -r 1 eth1
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: eth1 10.12.10.1, WindSize: 128, BLT: 2,
> OGI: 1000, UT: 0d 0h 3m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.0.1            eth1       10.12.0.1 ( 23  23    23    0) [
> eth1 119  22 128]         10.12.10.17 (  0)
> 10.12.10.17          eth1     10.12.10.17 (113 124   213    1) [
> eth1 120 113 128]           10.12.0.1 ( 11)
>      Gateway              Router (#/128)
> => 10.12.0.1             10.12.0.1 ( 82), gw_class 33 -
> 1024KBit/256KBit, reliability: 1
>
> ##################
> after a while...
> LAPTOP:
> ------------
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: wlan0 10.12.0.1, WindSize: 128, BLT: 2,
> OGI: 1000, UT: 0d 0h55m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.10.1          wlan0      10.12.10.1 (127 127  3503    0) [
> wlan0 107 127 107]         10.12.10.17 (  0)
> 10.12.10.17         wlan0     10.12.10.17 (128 128  3532    0) [
> wlan0 124 128 124]          10.12.10.1 (  0)
>
> WRT A
> ---------
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: eth1 10.12.10.17, WindSize: 128, BLT:
> 2, OGI: 1000, UT: 0d 0h58m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.0.1            eth1       10.12.0.1 (125 126  3301    0) [
> eth1 123 125 125]          10.12.10.1 (  1)
> 10.12.10.1           eth1      10.12.10.1 (126 128  3470    1) [
> eth1 111 128 111]           10.12.0.1 (  2)
>
>      Gateway              Router (#/128)
> => 10.12.0.1             10.12.0.1 (125), gw_class 33 -
> 1024KBit/256KBit, reliability: 1
>
> WRT B
> ---------
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: eth1 10.12.10.1, WindSize: 128, BLT: 2,
> OGI: 1000, UT: 0d 0h57m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.0.1            eth1       10.12.0.1 (108 118  3264    0) [
> eth1 123 108 128]         10.12.10.17 ( 10)
> 10.12.10.17          eth1     10.12.10.17 (114 121  3461    0) [
> eth1 123 114 128]           10.12.0.1 (  7)
>
>      Gateway              Router (#/128)
>    10.12.0.1             10.12.0.1 (109), gw_class 33 -
> 1024KBit/256KBit, reliability: 6
>
> ###########################################################################
>####### still a little later
> LAPTOP:
> ----------
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: wlan0 10.12.0.1, WindSize: 128, BLT: 2,
> OGI: 1000, UT: 0d 1h11m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.10.1          wlan0      10.12.10.1 (124 128  4411    0) [
> wlan0 107 128 107]         10.12.10.17 (  4)
> 10.12.10.17         wlan0     10.12.10.17 (127 127  4441    0) [
> wlan0 121 128 121]          10.12.10.1 (  0)
>
> WRT A
> ---------
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: eth1 10.12.10.17, WindSize: 128, BLT:
> 2, OGI: 1000, UT: 0d 1h15m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.0.1            eth1       10.12.0.1 (123 125  4308    0) [
> eth1 121 123 125]          10.12.10.1 (  2)
> 10.12.10.1           eth1      10.12.10.1 (126 128  4477    0) [
> eth1 111 128 111]           10.12.0.1 (  2)
>
>      Gateway              Router (#/128)
> => 10.12.0.1             10.12.0.1 (123), gw_class 33 -
> 1024KBit/256KBit, reliability: 1
>
> WRT B
> ---------
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: eth1 10.12.10.1, WindSize: 128, BLT: 2,
> OGI: 1000, UT: 0d 1h14m
> Originator           viaIF         Router (brc rcvd lseq lvld) [
> viaIF l2q  lq nlq].. alternatives...
> 10.12.0.1            eth1       10.12.0.1 (106 115  4277    0) [
> eth1 123 106 128]         10.12.10.17 (  9)
> 10.12.10.17          eth1     10.12.10.17 (117 122  4476    0) [
> eth1 120 117 128]           10.12.0.1 (  5)
>
>      Gateway              Router (#/128)
>    10.12.0.1             10.12.0.1 (110), gw_class 33 -
> 1024KBit/256KBit, reliability: 8
>
>
>
>
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


