Return-Path: <jluehr@online.de>
From: =?iso-8859-1?Q?Jan_L=FChr?= <jluehr@online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Mar 2011 13:39:51 +0100
Message-Id: <9B37313E-1B65-4D3F-BE01-1374D13681A8@online.de>
Mime-Version: 1.0 (Apple Message framework v1082)
Subject: [B.A.T.M.A.N.] Batman-adv gateways vs IPv6
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello @all,

I'm new to batman - so, sorry if this was discussed already...

We're up to deploy batman-adv in an wireless mesh network with multiple =
routers / gateways providing access to the outside world. Furthermore =
deploying an IPv4 / v6 dual stack networking is one goals we're trying =
to archive.
We stumbled up on batman-adv and its gateway feature, which looks quite =
promising. (http://www.open-mesh.org/wiki/batman-adv-gateways)
However, since dhcp is used for implementing batman-adv gateways, this =
feature doesn't affect IPv6 ND / icmp6 - am I right?

Having this in mind, what do you think is a suitable deployment strategy =
for IPv6 in batman-adv networks?
Of course, assigning a single /64 to the mesh-cloud is a simple option, =
but icmp6 flooding might occur ...

Thanks,
Jan


