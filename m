Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
From: tjhowse <tjhowse@gmail.com>
Date: Thu, 27 Nov 2014 09:05:04 +1000
Message-ID: <CAAxzKbSv9+vcOVCcoqg9FDOskuZd=_GK2pmq7jk4E4eAQbqWYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Bridging multiple mesh segments across WAN
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

Hi All,

I've partially covered a large site in routers running batman-adv. The
mesh is used for mobile access to equipment on a static site copper
and fibre network around the site. A few of the routers have WAN
connections to the site network. The routers with WAN connections are
configured as gateways in batman-adv. There are gaps in the mesh;
typically there is no route between WAN-connected routers via the
mesh.

I would like to join up the separate mesh segments, via the site
network, such that a client to one segment can ping a client of
another network, having the traffic transparently tunnel via the WAN.
Has anyone looked at doing this in the past?

Thanks,
Travis.
