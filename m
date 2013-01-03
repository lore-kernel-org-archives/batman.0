Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
Date: Thu, 3 Jan 2013 15:16:32 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <5ACA4F0A-BD9A-4CE5-AAF6-1F259DAA2B55@stephan.homeunix.net>
Subject: [B.A.T.M.A.N.] Packet-Loss-Peaks in a Freifunk-Network
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
Cc: =?iso-8859-1?Q?Bonn_und_Umgebung_Allgemeine_Mailingliste_zum_Fre?= =?iso-8859-1?Q?ifunk_K=F6ln?= <freifunk-bonn@lists.bonn.freifunk.net>

Hello folks,

we spent some effort in measuring the stability on our freifunk-network.=20=

The networt itself consists of two networks.
- Tinc-VPN, batman-adv 2011.2.0
- fastd-VPN, batman-adv 2012.4.0

The fastd-network has two gateways (kif and fastd3) and two nodes. Each =
node is connected to both gateways. (Example output of batctl o see =
below)

Please take a look at:=20
=
http://kbu.freifunk.net/index.php?title=3DStatistik#Ping_innerhalb_des_Fre=
ifunknetz
While the first chart shows the stability of a node connected directly =
via tincy, the later ones use fastd.

- Chart 2 shows kif -> node1
- Chart 3 shows fastd3 -> node1
- Chart 4 shows kif -> node2

We noticed a few, unusual things:
-> regardless of the link tested (kif or fastd3) and regardless of the =
node (node1, node2) small interruptions (loss-peaks) are appearing.
-> These peaks appear almost synchronous, a few "noise" comes from =
different vpn-links and node-wan-uplinks.
-> Since all links are wired, radio-noise won't have an impact
-> The losses appear in batman-adv 2011.2.0 as well as in batman-adv =
2012.4.0.
Thus I suspect that batman-adv is triggering theses interruptions.=20

Have you notice same problems in past? Is there a way to fix these =
outages?

Thanks,
Keep smiling
yanosz

# batctl o
[B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/b2:48:7a:cb:2d:59 =
(bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   =
Potential nexthops ...
             vpn3    0.130s   (255)              vpn3 [  mesh-vpn]:      =
         kif (198)              vpn3 (255)
              kif    0.280s   (255)               kif [  mesh-vpn]:      =
        vpn3 (  0)               kif (255)
            node1    2.700s   (225)               kif [  mesh-vpn]:      =
         kif (225)              vpn3 (225)
            node2    3.110s   (223)               kif [  mesh-vpn]:      =
         kif (223)              vpn3 (225)

