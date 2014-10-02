Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
Date: Thu, 2 Oct 2014 15:12:12 -0600
Message-ID: <CAA_JP8US55s-QhJD=iVymGOHpkJjT1OY4Tth06NB1dNkvAY9UQ@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] mikrotik routers + openwrt + batman-adv *or* alix
	apu1c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

mikrotik)
Is anyone running/testing any mikrotik gear such as the rb911 or
rb912, rb922, rb433, etc w/ openwrt and batman-adv?

I'm considering a multi-radio mesh node and I think this platform
might be priced well enough.  I do fixed wireless broadband but am
looking at reaching into some heavily wooded areas that nothing else
can penetrate.

The rb922 in particular has an 5Ghz 'ac radio and mini-pcie that can
take a second 5Ghz 'ac radio.  That makes for a really great dual
802.11'ac radio w/ gigabit port and PoE ethernet to run a cable into
the customer's house.  An RB433 can take 2 'ac radios and a 900Mhz
radio which you could artificially increase the cost on for a lower
throughput tree-penetrating backup link to be placed every x number of
hops.

The rb922 version would be a sub $200 high performance mesh node.

alix)
now, the alix apu1c is a 2 mini-pcie box with dual 1Ghz x86 CPUs ready
to run debian and has 3 gigabit ethernet ports.  This would be a nice
'edge' node with 1 or 2 of those gigabit ports dedicated to backhaul
radios.

***

So, the concept is that clients wouldn't actually be on wireless and
batman-adv would just be handling distribution. Clients would be wired
up ethernet to a PoE injector.  This dual radio mesh should only add
latency at each hop as a result, though the obvious link quality and
capacity are taken into account.   I can bring in 20-200Mbps of
service but can't penetrate the trees for more than a few houses on
the edge.  I could do two links to reachable homes and have any number
(throughput limited) of clients connect w/ the redundant path.



Thoughts?
