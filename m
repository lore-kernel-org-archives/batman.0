Message-ID: <a934d3f30804160140h36192f2ci3bed5efe52ff78f9@mail.gmail.com>
Date: Wed, 16 Apr 2008 04:40:46 -0400
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
In-Reply-To: <4805198F.8080705@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4886_1009413.1208335246063"
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>
	<018CC2A5-4DD5-421B-AD00-AF9B3CC50D2B@philippeapril.com>
	<200804160202.23971.lindner_marek@yahoo.de>
	<C2223079-2ACE-4EA6-BB82-C9B4A1547149@philippeapril.com>
	<4804FC55.3010407@gmx.net>
	<A46801E6-B4A6-452F-A1DE-C787A4E947D5@philippeapril.com>
	<4805198F.8080705@gmx.net>
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

------=_Part_4886_1009413.1208335246063
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Philippe...seems your problem and mine are similar hence continuing posting
in
this thread,if you feel its different please tell me ill repost as a new
thread.

My network setup is as shown

                        Gateway 10.24.249.96
                        -------------------------------------
                                     |
                50ft             |
                                 |
                               |
                             |
                   Node 1  (10.1.125.158)
                   -------------------------------------
                                   |
                 25ft               |
                                          |
                                Node 2 (10.1.52.)236
                               -------------------------------------

The wifi signal strength between  Gateway and Node 1 is good and so is
between Node 1 and Node 2 .In general the average signal strength between
Node 2 and gateway is bad.
But momentarily there seems to be an improvement in direct link between the
Gateway and Node 2  and at this point of time the the tunnel formed from
Node 2 to gateway via Node 1 is deleted and the a new direct tunnel is
formed which again looses link as its average signal strength is bad.

This is what batmand -cd3 on the Node 2 shows


/ # batmand -cd3
WARNING: You are using the unstable batman branch. If you are interested in
*using* batman get the latest stable release !
Gateway client - successfully refreshed IP lease: 10.24.249.96
Deleting route to 10.24.249.96 via 0.0.0.0 (table 66 - ath0)
Adding route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
Deleting route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
Adding route to 10.24.249.96 via 0.0.0.0 (table 66 - ath0)
Deleting route to 10.24.249.96 via 0.0.0.0 (table 66 - ath0)
Adding route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
Gateway client - disconnecting from unresponsive gateway (10.24.249.96):
could not refresh IP lease
Deleting default route via gate0 (table 68)
Adding default route to 10.24.249.96 (gw_flags: 41, tq: 178, gw_product: 0)
Adding default route to 10.24.249.96 (gw_flags: 41, tq: 171, gw_product: 0)
Gateway client - got IP (169.254.0.2) from gateway: 10.24.249.96
Adding default route via gate0 (table 68)
Gateway client - gateway (10.24.249.96) says: IP (169.254.0.2) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.24.249.96 (gw_flags: 41, tq: 46, gw_product: 0)
Gateway client - got IP (169.254.0.2) from gateway: 10.24.249.96
Adding default route via gate0 (table 68)
Deleting route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
Adding route to 10.24.249.96 via 0.0.0.0 (table 66 - ath0)
Deleting route to 10.24.249.96 via 0.0.0.0 (table 66 - ath0)
Adding route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
Deleting route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
Adding route to 10.24.249.96 via 0.0.0.0 (table 66 - ath0)
Deleting route to 10.24.249.96 via 0.0.0.0 (table 66 - ath0)
Adding route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
Deleting route to 10.24.249.96/32 via 10.1.125.158 (table 66 - ath0)
--CUT--

The above keeps happening very frequently (at times even every 5-10 secs)
and in my case eventually the gateway crashed (which is my second problem  i
had posted separately yesterday).

I have noticed that while i am connected to Node 2 and am downloading or
transfering data from internet the link keeps chopping up and in most cases
times out....however as my wan ip is constant the downloads don't get
disconnected.

-- 
Vinay Menon

------=_Part_4886_1009413.1208335246063
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Philippe...seems your problem and mine are similar hence continuing posting in<br>this thread,if you feel its different please tell me ill repost as a new thread.<br><br>My network setup is as shown<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gateway <a href="http://10.24.249.96">10.24.249.96</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------------------------------<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50ft&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; |<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; Node 1&nbsp; (<a href="http://10.1.125.158">10.1.125.158</a>)<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; -------------------------------------<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; |<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 25ft&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Node 2 (10.1.52.)236<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; -------------------------------------<br>
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;  <br>The wifi signal strength between&nbsp; Gateway and Node 1 is good and so is between Node 1 and Node 2 .In general the average signal strength between Node 2 and gateway is bad.<br>But momentarily there seems to be an improvement in direct link between the Gateway and Node 2&nbsp; and at this point of time the the tunnel formed from Node 2 to gateway via Node 1 is deleted and the a new direct tunnel is formed which again looses link as its average signal strength is bad.<br>
<br>This is what batmand -cd3 on the Node 2 shows<br>&nbsp;<br><br>/ # batmand -cd3<br>WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !<br>Gateway client - successfully refreshed IP lease: <a href="http://10.24.249.96">10.24.249.96</a><br>
Deleting route to <a href="http://10.24.249.96">10.24.249.96</a> via <a href="http://0.0.0.0">0.0.0.0</a> (table 66 - ath0)<br>Adding route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>
Deleting route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>Adding route to <a href="http://10.24.249.96">10.24.249.96</a> via <a href="http://0.0.0.0">0.0.0.0</a> (table 66 - ath0)<br>
Deleting route to <a href="http://10.24.249.96">10.24.249.96</a> via <a href="http://0.0.0.0">0.0.0.0</a> (table 66 - ath0)<br>Adding route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>
Gateway client - disconnecting from unresponsive gateway (<a href="http://10.24.249.96">10.24.249.96</a>): could not refresh IP lease<br>Deleting default route via gate0 (table 68)<br>Adding default route to <a href="http://10.24.249.96">10.24.249.96</a> (gw_flags: 41, tq: 178, gw_product: 0)<br>
Adding default route to <a href="http://10.24.249.96">10.24.249.96</a> (gw_flags: 41, tq: 171, gw_product: 0)<br>Gateway client - got IP (<a href="http://169.254.0.2">169.254.0.2</a>) from gateway: <a href="http://10.24.249.96">10.24.249.96</a><br>
Adding default route via gate0 (table 68)<br>Gateway client - gateway (<a href="http://10.24.249.96">10.24.249.96</a>) says: IP (<a href="http://169.254.0.2">169.254.0.2</a>) is expired<br>Deleting default route via gate0 (table 68)<br>
Adding default route to <a href="http://10.24.249.96">10.24.249.96</a> (gw_flags: 41, tq: 46, gw_product: 0)<br>Gateway client - got IP (<a href="http://169.254.0.2">169.254.0.2</a>) from gateway: <a href="http://10.24.249.96">10.24.249.96</a><br>
Adding default route via gate0 (table 68)<br>Deleting route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>Adding route to <a href="http://10.24.249.96">10.24.249.96</a> via <a href="http://0.0.0.0">0.0.0.0</a> (table 66 - ath0)<br>
Deleting route to <a href="http://10.24.249.96">10.24.249.96</a> via <a href="http://0.0.0.0">0.0.0.0</a> (table 66 - ath0)<br>Adding route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>
Deleting route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>Adding route to <a href="http://10.24.249.96">10.24.249.96</a> via <a href="http://0.0.0.0">0.0.0.0</a> (table 66 - ath0)<br>
Deleting route to <a href="http://10.24.249.96">10.24.249.96</a> via <a href="http://0.0.0.0">0.0.0.0</a> (table 66 - ath0)<br>Adding route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>
Deleting route to <a href="http://10.24.249.96/32">10.24.249.96/32</a> via <a href="http://10.1.125.158">10.1.125.158</a> (table 66 - ath0)<br>--CUT--<br><br>The above keeps happening very frequently (at times even every 5-10 secs) <br>
and in my case eventually the gateway crashed (which is my second problem&nbsp; i had posted separately yesterday). <br><br>I have noticed that while i am connected to Node 2 and am downloading or transfering data from internet the link keeps chopping up and in most cases times out....however as my wan ip is constant the downloads don&#39;t get disconnected.<br clear="all">
<br>-- <br>Vinay Menon

------=_Part_4886_1009413.1208335246063--
