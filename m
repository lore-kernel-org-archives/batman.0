Message-ID: <20080316145709.npkacbtvi84kssc4@webmail.ddmesh.de>
Date: Sun, 16 Mar 2008 14:57:09 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Memory Leak-batmand-exp rev1003
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
To: "Open-Mesh, Mailinglist" <b.a.t.m.a.n@open-mesh.net>

Hi,

I have found that the batmand-experimental (rev1003) still consumes more
and more memory if you have specified the -r1 or -r2 options. I haven't tried
  -r3.
If I turn off gateway with option -r0 the memory consumtion is constant.
It seems that the memory increase is in steps of 16kbyte but the time  
when this
happens is different.

the syslog does not show any hint despite of several tries to name the bat0
interface (about ever two minutes):
Mar 16 14:50:49 (none) kern.err bmxd[2133]: Startup parameters:  
/sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63  
--no-unreachable-rule --no-throw-rules --no-prio-rules  
--one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
Mar 16 14:52:27 (none) kern.err bmxd[2398]: Trying to name tunnel to bat0 ...
Mar 16 14:52:27 (none) kern.err bmxd[2398]: success!
Mar 16 14:54:04 (none) kern.err bmxd[2601]: Trying to name tunnel to bat0 ...
Mar 16 14:54:04 (none) kern.err bmxd[2601]: success!

Both interfaces eth1 and tbb are active and conntected.
The WRT54 that has the option -r0 set, has a constant memory consumtion.

During this test I got a very strange message on the wrt that only has  
the eth1
interface. There is no other router with the same ip address.

Mar 16 14:52:21 (none) kern.err bmxd[21119]: Drop packet: DAD alert!  
OGM from 10.12.10.17 via NB 10.12.10.17 with out of range seqno! rcvd  
sqno 28347, last valid seqno: 23290 at 6096067!               Maybe  
two nodes are using this IP!? Waiting 0 more seconds before r
Mar 16 14:52:22 (none) kern.err bmxd[21119]: Drop packet: DAD alert!  
OGM from 10.12.10.17 via NB 10.12.10.17 with out of range seqno! rcvd  
sqno 28348, last valid seqno: 23290 at 6096067!               Maybe  
two nodes are using this IP!? Waiting 0 more seconds before r


Setup:

laptop-tbb-----------tbb[10.12.0.17]eth1--------eth1[10.12.10.1]
         |                             |           |
         +------------tbb[10.12.10.17]eth1---------+


/stephan





