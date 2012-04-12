Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
Date: Thu, 12 Apr 2012 12:26:52 +0200
Message-ID: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Migration to Batman
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

Hi!

I really liked your client roaming support presented at Battlemesh.
But I am still afraid to deploy Batman in the network. As I
understand, we should be migrating the whole network at same time each
time a new version of Batman (or Linux kernel) is released, because
you do not keep things backwards compatible? How serious is this
limitation in practice?

I am also a bit afraid of L2 meshing. How problematic are floods in
the network in practice? Like people broadcasting stuff and so on? Are
there any filters possible for this?

We have a setup where nodes have WiFi connections and VPN links to
central server. We are thinking of migration OpenVPN to L2TP tunnels,
so on the central server there will be many tunnels dynamically
created as nodes connect and disconnect. Is Batman able to add
interfaces it operates during run-time? Probably we should not just
bridge all tunnels and run Batman on top of that? This would probably
hide that there are different links bellow from Batman? Or not? (For
example, on OLSR we should not do this, because then nodes would
discover each other over server as one hop/direct neighbors.)


Mitar
