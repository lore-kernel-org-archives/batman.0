From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Memory Leak-batmand-exp rev1003
Date: Tue, 18 Mar 2008 14:31:25 +0100
References: <20080316145709.npkacbtvi84kssc4@webmail.ddmesh.de>
In-Reply-To: <20080316145709.npkacbtvi84kssc4@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200803181431.25467.axel@open-mesh.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Sonntag 16 M=E4rz 2008, Freifunk Dresden wrote:
> Hi,
>
> I have found that the batmand-experimental (rev1003) still consumes more
> and more memory if you have specified the -r1 or -r2 options. I haven't
> tried -r3.
> If I turn off gateway with option -r0 the memory consumtion is constant.
> It seems that the memory increase is in steps of 16kbyte but the time
> when this
> happens is different.
>
> the syslog does not show any hint despite of several tries to name the ba=
t0
> interface (about ever two minutes):
> Mar 16 14:50:49 (none) kern.err bmxd[2133]: Startup parameters:
> /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63
> --no-unreachable-rule --no-throw-rules --no-prio-rules
> --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
> Mar 16 14:52:27 (none) kern.err bmxd[2398]: Trying to name tunnel to bat0
> ... Mar 16 14:52:27 (none) kern.err bmxd[2398]: success!
> Mar 16 14:54:04 (none) kern.err bmxd[2601]: Trying to name tunnel to bat0
> ... Mar 16 14:54:04 (none) kern.err bmxd[2601]: success!

Can you give more information about the scenario that might cause the probl=
em=20
and send a debug-level 3 log of the scenario. Maybe I got an idea then.

>
> Both interfaces eth1 and tbb are active and conntected.
> The WRT54 that has the option -r0 set, has a constant memory consumtion.
>
> During this test I got a very strange message on the wrt that only has
> the eth1
> interface. There is no other router with the same ip address.
>
> Mar 16 14:52:21 (none) kern.err bmxd[21119]: Drop packet: DAD alert!
> OGM from 10.12.10.17 via NB 10.12.10.17 with out of range seqno! rcvd
> sqno 28347, last valid seqno: 23290 at 6096067!               Maybe
> two nodes are using this IP!? Waiting 0 more seconds before r

This DAD (duplicate address detection) message indicates a _potential_=20
duplicate address usage. It is triggered by receiving an invalid (or=20
out-of-range) sequence number from the same IP address. During the start of=
=20
each daemon an initial sequencenumber is randomized and then incremented by=
=20
one with each new emitted OGM (by default with an originator interval of on=
e=20
second). A receiving node can now detect abnormal sequences. E.g. after=20
receiving the sequence number n from node A, the next expected sequence=20
numbers should be something around n+1. Ten seconds after receiving sequenc=
e=20
number n+1 a sequence number around n+11 would be expected.=20
This works even if some OGMs (and corresponding sequence=20
numbers got lost). If instead of n+11 a sequence number of n+5000 is receiv=
ed=20
then something is strange. Either two nodes are using the same IP and start=
ed=20
with two different initial sequence numbers or only one node is using this =
IP=20
address but the daemon on that node has been restarted. Then a new initial =

sequence number is randomized and other nodes will be temporary confused.=20
The latter is probably the scenario indicated by your syslog.=20
It logs:=20
 - an "out-of-range sequence number has been detected
 - tells you that related OGMs will be temporary ignored=20
 - and for how long it will continue to ignore these strange sequence numbe=
rs.=20
If no more in-range sequence numbers arrive for a certain time the data set=
=20
of node A is reinitialized and subsequent OGMs from node A will be accepted.

If you look at the debug-output of 10.12.10.17 it should indicate that this=
=20
node has been restarted and thereby changed its sequence number=20
counter from 23290 to 28347.


Hope the explanation helped bit.

regards,
axel

>
> Setup:
>
> laptop-tbb-----------tbb[10.12.0.17]eth1--------eth1[10.12.10.1]
>
>          +------------tbb[10.12.10.17]eth1---------+
>
>
> /stephan
>
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n



