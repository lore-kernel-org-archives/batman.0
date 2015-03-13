Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFC7CC1C02.68EA7DC9-ONC1257E07.00275710-C1257E07.002916EB@phoenixcontact.com>
Date: Fri, 13 Mar 2015 08:28:48 +0100
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable
Subject: [B.A.T.M.A.N.] DAT broken in 2014.4.0?
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

Is there a known issue conerning the DAT functionality in batman-adv=20
2014.4.0?

I have got a problem with looping ARP packets / multiplication of ARP=20
packets causing ARP storms in a setup with enabled DAT and BLA. My setup=20
consists of 6 mesh nodes of which 3 are connected to the same backbone=20
network. I connected a PC to the backbone which has an open ssh connection=
=20
to one ot the mesh nodes not connected to the backbone network directly.=20
Using arp -d to delete the ARP cache of the Windows PC forces the PC to=20
send an ARP request to the mesh node used for the ssh session. I can then=20
see multiple copies of that ARP request in the backbone in a wireshark=20
recording and also multiple ARP replies from the mesh node.=20
Sometimes also BLA gratuitous ARP telegrams seem to be looping, but it's=20
easier to force this behaviour with regular ARPs (via arp -d on a PC).=20
Non-ARP telegrams don't seem to be affected and except the waste of=20
bandwith in the mesh and backbone I don't have problems with normal=20
network communication in the mesh.

I could provide the mentioned wireshark recordings made in the backbone=20
network with a switch using port mirroring if someone explains how to=20
provide such a file to the mailing list (I guess simple attachments are=20
not allowed?).

If I disable DAT, everything looks fine again, i.e. no duplicated ARP=20
telegrams anymore (except for a few ARP replies from the mesh node which=20
are received twice, which could be a race for claiming the device?)..

Regards,
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
