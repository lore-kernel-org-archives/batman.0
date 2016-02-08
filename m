Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
Date: Mon, 8 Feb 2016 12:35:35 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Looping unicast packets when using BLA
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

Hello

I have a problem in my mesh setup which is quite similiar to Bug#216 of
the bug tracker.
I'm using batman-adv 2014.4.0 in a BLA setup consisting of 3 Mesh Nodes
(A, B, C) connected to the same backone network via a common switch and a
mesh node D connected to an end device E. I ping that single mesh node D
and the connected end device E from a PC which is connected to the same
switch as the three Nodes A to C. BLA is compiled and enabled.

From=20time to time I see looping unicast packets in my backbone network.
This unicast looping starts directly after one of the nodes A to C claimed
the mac address of my PC. The looping telegram is then the ping request
sent by the PC. I have a wireshark recording made in my backbone via port
mirroring of one of the switch ports where a mesh node is connected to
which shows this behaviour.

I am not sure if I understood bla correctly but isn't it nonsense that a
bla backbone gateway claims MAC addresses from its own backbone (i.e. the
one it is directly connected to via its ethernet port)?

A simple change in batadv_bla_rx seems to solve this problem: add an
additional check before claiming a new mac address: if this address is
already known from the tt local table (via command batadv_is_my_client)
don't claim it.

This seems to solve my problem as far as I have tested so far. Any
thoughts about that?

Best regards,
Andreas



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
