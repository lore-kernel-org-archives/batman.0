Return-Path: <ed.okerson@gmail.com>
MIME-Version: 1.0
Date: Thu, 5 May 2011 10:37:05 -0500
Message-ID: <BANLkTikaMjY9t=0gDQCn0xUzz+c4YPz7gQ@mail.gmail.com>
From: Ed Okerson <ed.okerson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Routing decisions
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

Hi,

We are evaluating using Batman in an environment where there could be
200-300 devices in a single building.  We started out setting up 10
devices in our office to figure out how everything works and do some
throughput testing.  We have noticed that the routing decisions always
send the packet to the node towards the destination with the highest
signal strength.  This causes the packet to always traverse the
network with the maximum possible number of hops, which causes
performance to degrade quickly.  Is it possible to use a different
routing algorithm?  It would seem that sending to the node closest to
the destination that the source node can still communicate with
directly would minimize the number of hops.

Ed Okerson
