MIME-Version: 1.0
Date: Tue, 5 May 2009 10:08:44 -0400
Message-ID: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
From: Arc Riley <arcriley@gmail.com>
Content-Type: multipart/alternative; boundary=001636284f2215919304692ad1c1
Subject: [B.A.T.M.A.N.] batman-adv use in Manchester NH
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--001636284f2215919304692ad1c1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We're setting up batman-adv on open-mesh.com OM1P routers and unidirectional
antennas to connect homes and businesses across the city.

I've read the protocol docs, but a few key questions about the current
kernel implementation;

Is there currently a multicast protocol or method for a node on the network
to get local link stats from every other node on the network?  We're looking
at this for a GUI desktop diagnostics tool which shows the current 1-hop
link states for all nodes on the network

Is there a layer 3 solution for routing each end user to the nearest IP
gateway that works well on top of a batman-adv network?

Does batman-adv currently support "bonding"; ie, will it route all packets
through the best connection until it's saturated, or will it spread packets
across connections (especially that are near the same quality) for optimal
speed?

What kind of traffic throughput is the kernel module capable of?  Does the
module multithread properly for multicore utilization?  Would a FPGA variant
be needed to have a "mesh switch" or would a high-end multicore ARM be
reasonably able to handle say an 8-port gigabit mesh switch?

These questions are less to evaluate batman-adv for our uses than looking
forward at what we'll need to develop as we expand.

Thanks!

--001636284f2215919304692ad1c1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

We&#39;re setting up batman-adv on <a href=3D"http://open-mesh.com">open-me=
sh.com</a> OM1P routers and unidirectional antennas to connect homes and bu=
sinesses across the city.<br><br>I&#39;ve read the protocol docs, but a few=
 key questions about the current kernel implementation;<br>
<br>Is there currently a multicast protocol or method for a node on the net=
work to get local link stats from every other node on the network?=C2=A0 We=
&#39;re looking at this for a GUI desktop diagnostics tool which shows the =
current 1-hop link states for all nodes on the network<br>
<br>Is there a layer 3 solution for routing each end user to the nearest IP=
 gateway that works well on top of a batman-adv network?<br><br>Does batman=
-adv currently support &quot;bonding&quot;; ie, will it route all packets t=
hrough the best connection until it&#39;s saturated, or will it spread pack=
ets across connections (especially that are near the same quality) for opti=
mal speed?<br>
<br>What kind of traffic throughput is the kernel module capable of?=C2=A0 =
Does the module multithread properly for multicore utilization?=C2=A0 Would=
 a FPGA variant be needed to have a &quot;mesh switch&quot; or would a high=
-end multicore ARM be reasonably able to handle say an 8-port gigabit mesh =
switch?<br>
<br>These questions are less to evaluate batman-adv for our uses than looki=
ng forward at what we&#39;ll need to develop as we expand.<br><br>Thanks!<b=
r>

--001636284f2215919304692ad1c1--
