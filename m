Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 20 Oct 2016 23:56:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161020215614.GG32033@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Add VLAN tag size to MTU recommendation?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Leo =?utf-8?Q?Kr=C3=BCger?= <leo@hamburg.freifunk.net>

Hi,

First of all, just wanted to forward this awesome diagram
regarding MTUs in Gluon-Setups which Freifunk Hamburg created
:D :

https://twitter.com/ohrensesselnet/status/789176399655350272

Which might be helpful for anyone new to understand how the
encapsulation in batman-adv works and how the MTU recommendations
of the underlying hard interfaces are calculated.

(I need to ask Leo for the sources, maybe a version without the
fastd overhead might be interesting for an MTU-explained page in
the open-mesh.org wiki :)?)


While checking the calculations Freifunk Hamburg did, I was
wondering whether the batadv_hardif_min_mtu() function should add
an extra 4 bytes for VLAN tagged, encapsulated payload to the MTU
calculations and the kmesg recommendations, especially since
Antonio's great work made TT fully VLAN-aware?

Open-Mesh.com/Cloudtrax routers are using the VLAN awareness, right?
Is the wifi interface MTU there just set to +4 bytes over the kmesg
recommedation?

Regards, Linus
