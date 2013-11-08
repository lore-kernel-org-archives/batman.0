Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
From: tjhowse <tjhowse@gmail.com>
Date: Fri, 8 Nov 2013 18:42:37 +1000
Message-ID: <CAAxzKbRQ-ZPZ8vQUu8GevK+gC-J16EZ-WDkyTcpVxqPZbYg5gw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Replacing OLSRD with batman-adv?
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Ladies and Gents,

I've built a three-node mesh network using cheap TP-Link TL-WDR3600
routers. They can do simultaneous 5.8GHz and 2.4GHz. I use the 5.8 for
the backbone links between the nodes, and 2.4 to clients. The nodes
are running OpenWRT and OLSRD.

This system mostly works well, but there are a couple of problems with
it that I'm wondering if batman-adv would solve or make easier to
solve:

1) The backbone links cannot be better protected than WEP, a
limitation of OLSRD,
2) Gateway assignment is a manual process, which must be performed on
every node in the mesh, referring to the single node connected to the
WAN,
3) The manual gateway configuration of 2) prevents peer-to-peer
communications between mesh clients,
4) Each node has its own /24 subnet. This causes problems when a
device roams from one device's jurisdiction to another if the
interface doesn't re-issue a DHCP request.

We're expanding the network, I've just bought another ten of these
routers, and I'm going to spend some time assessing if batman-adv
would be a better fit for our purposes. There will be a range of ios,
android and windows devices connecting to the mesh.

My questions are as follows:

1) Does batman-adv worth with WPA2 or better encryption?
2) Must every client to a batman-adv mesh have a daemon installed?
3) Is it possible to separate different radio interfaces for different
purposes? I.E. 5.8 for backbone, 2.4 for clients.
4) Can all nodes and clients on a mesh have an IP in the same subnet,
solving some of the roaming problems caused by bad interface settings
or drivers?

Thanks,
Travis.
