Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
Message-ID: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
Date: Fri, 10 Jun 2016 13:10:58 +0200
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH v5 0/6] Optimizations for setups running dat
	and bla
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

This patchset introduces optimizations for batman-adv in setups having seve=
ral
gateways into a common (switched) Ethernet backbone network especially if d=
at
is additionally enabled.

Using the current implementation with bla and dat enabled, several problems
can be observed in a real setup:
1. Multiplication of ARP replies from dat enabled gateways and dat enabled
mesh nodes leading to an "ARP reply storm" in the common backbone network.
2. In rare corner cases bla does not fully prevent looping of unicast frames
in the direction Backbone --> mesh --> backbone and looping of multicast
frames in the direction mesh --> backbone --> mesh.
The latter can lead to temporary confusion in the switched backbone resulti=
ng
in packet loss and communication timeouts.

The observed problems are solved by introduction of additional rules for the
dat handling, bla packet forwarding and bla claiming/unclaiming of clients.

v5:
 - changed function name to batadv_bla_check_claim
 - put added include file in alphabetical order
 - added check to exclude ip address 0.0.0.0 from snooping

v4:
 - removed unnecessary include in soft-interface.c
 - solved issue with double-use and refcounting of pointers in routing.c

v3:

 - rebased patchset
 - moved snooping of ip addresses for dat speed up into separate function
 - removed "patch of a patch"
 - removed automatic claiming during check of a claim
 - fixed issues of the patchset not being compiled due to chosen batman
=09options

Kind regards,
Andreas

Andreas Pape (6):
  batman-adv: prevent multiple ARP replies sent by gateways if dat
    enbled
  batman-adv: speed up dat by snooping received ip traffic
  batman-adv: prevent duplication of ARP replies when DAT is used
  batman-adv: drop unicast packets from other backbone gw
  batman-adv: changed debug messages for easier bla debugging
  batman-adv: handle race condition for claims between gateways

 net/batman-adv/bridge_loop_avoidance.c |   87 ++++++++++++++++++++++++---
 net/batman-adv/bridge_loop_avoidance.h |   11 ++++
 net/batman-adv/distributed-arp-table.c |  102 ++++++++++++++++++++++++++++=
++++
 net/batman-adv/distributed-arp-table.h |    9 +++-
 net/batman-adv/routing.c               |   25 +++++++-
 net/batman-adv/soft-interface.c        |    3 +
 6 files changed, 225 insertions(+), 12 deletions(-)



..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BCtzte I=
nformationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail i=
rrt=C3=BCmlich erhalten haben, informieren Sie bitte sofort den Absender un=
d vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige=
 Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
