Return-Path: <luca.pretto@gmail.com>
From: Luca Pretto <luca.pretto@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 3 Aug 2012 11:08:37 +0200
Message-Id: <BB2F02D2-9B93-465E-BB7D-FA13492511BF@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: [B.A.T.M.A.N.] Batman-adv and routed subnets
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

Hi folks,

I really need a bit of your help! I've already spent a week on this and =
I can't succeed! :(

I'm going to install a small mesh (12 nodes, initially) covering my city =
and linking some friends of mine.
At the moment the equipment (Ubiquiti) is already installed, structured =
as AP-STA (PSK2) in one large LAN (all connections bridged L2) with one =
central dhcp/firewall serving the 192.168.9.0/24 subnet (now that's all =
inside this net only).

I would like to migrate the topology to a routed network, where the =
wireless mesh nodes have IPs allocated inside 10.9.0.0/16, and below =
each one of these nodes there will be a local LAN with reserved subnet =
(IP offered by OpenWRT through dnsmasq). I've done some experiment with =
OLSRd and I got a working system that way, but I'd REALLY LOVE to use =
batman-adv instead.
Some of the networks already have internet connectivity, that will be =
shared through the mesh to whom needs it.

10.9.11.1 <----> 192.168.11.0/24 --> 192.168.11.1 (internet gateway)
    ||
    ||
10.9.12.1 <----> 192.168.12.0/24
    ||
    ||
10.9.13.1 <----> 192.168.13.0/24 --> 192.168.13.1 (internet gateway)
    ||
    ||
10.9.14.1 <----> 192.168.14.0/24
    ||
    ||
10.9.xx.1 <----> 192.168.xx.0/24

Batman-adv will take care of the routing inside the wireless mesh (links =
" || " in the diagram).
Anyway, I need that any host on the 192.168.xx.0/24 subnets will be able =
to talk to each other.

How can this be done with batman-adv?

And then, in your opinion, would be better to stay on BackFire ath9k =
Open IBSS or is the Attitude Adjustment ath9k RSN IBSS (PtMP) stable =
enough?

Many many thanks in advance for your time.

Sincerely,
Luca=
