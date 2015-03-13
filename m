Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <5502CF6D.3030408@meshcoding.com>
References: <OFC7CC1C02.68EA7DC9-ONC1257E07.00275710-C1257E07.002916EB@phoenixcontact.com>
 <5502CF6D.3030408@meshcoding.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFF07BA093.8D744C20-ONC1257E07.004BE977-C1257E07.00503089@phoenixcontact.com>
Date: Fri, 13 Mar 2015 15:35:53 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] DAT broken in 2014.4.0?
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

Hello Antonio,

my mesh nodes use a wlan interface in adhoc mode as the only hard_if in=20
bat0. bat0 is bridged to a Linux bridge br0 together with the Ethernet=20
interface eth0. The wlan interface ath0 is not part of that bridge. The=20
only interface having an ip address assigned is the bridge br0.

As mentioned I use 6 mesh nodes of that described setup of which 3 are=20
only accessible via the mesh (eth0 interface not connected to any other=20
Ethernet device) and 3 devices are connected with their eth Interfaces to=20
the same Ethernet switch. The Windows PC is also connected to that same=20
switch.

I am using batman-adv 2014.4.0 in combination with a fairly old Linux=20
kernel 2.6.32.26 on an embedded device. If I enable BLA and DAT and send a=
=20
ping from the Windows PC to one of the mesh nodes which is not connected=20
to the Ethernet backbone, I see a multiplication of the ARP request sent=20
by the PC and even a higher amount of corresponding ARP replies in the=20
backbone network of which I am not sure, how much of them are really sent=20
by the mesh node being the original destination for the ARP request.=20
Furthermore I get lots of "bat0: received packet with own address as=20
source address" and some "eth0: received ...." kernel log messages in that=
=20
case as soon as the PC sends the first broadcast ARP request (after the=20
mentioned arp -d command).=20

If I disable DAT on all of my 6 devices the ARP telegrams being visible in=
=20
the backbone network look normal to me. There is only one broadcast ARP=20
request from the PC and only one ARP reply.

In the meantime I enabled dat debug messages on one of my gateways between=
=20
the ethernet backbone and the mesh. After clearing the ARP cache of the PC=
=20
by the arp -d command, I see the following output of batctl l

Parsing outgoing ARP REQUEST
ARP MSG : [src: <mac of the PC> - 192.168.0.50 dst: 00:00:00:00:00:00 -=20
192.168.0.101]
Entry updated 192.168.0.50 <mac of the PC>
ARP request replied locally
ARP Request for 192.168.0.101: fallback prevented
Parsing incoming ARP REPLY
ARP MSG: [src: <mac of the mesh node> - 192.168.0.101 dst: <mac of the PC>=
=20
- 192.168.0.50]
* encapsulated within a UNICAST packet
Entry updated: 192.168.0.101 <mac of the mesh node>
Entry updated: 192.168.0.50 <mac of the PC>

followed by a flood of additional messages of similiar kind. From this=20
logging and from what I understood so far about bla and dat from=20
open-mesh.org and a short look into the source code I conclude, that the=20
gateway knew already the mac the PC was looking for ("ARP request replied=20
locally") and did not forward it as a broadcast into the mesh.=20
Nevertheless the gateway received an ARP reply from the mesh. I guess the=20
original ARP request broadcast was forwarded at least by one of the=20
remaining two backbone gateways into the mesh and a reply was sent by=20
someone else (another mesh node with enabled dat or the mesh node being=20
searched for).

This leads me to the question if using dat and a bla setup in combination=20
is considered by design and if this should work or if dat is only=20
reasonable to be used when a backbone network has a single gateway into=20
the mesh (as depicted in the dat wiki on open-mesh.org) only.=20

Thanks for the support and regards,
Andreas



Von:    Antonio Quartulli <antonio@meshcoding.com>
An:     The list for a Better Approach To Mobile Ad-hoc Networking=20
<b.a.t.m.a.n@lists.open-mesh.org>,=20
Datum:  13.03.2015 13:22
Betreff:        Re: [B.A.T.M.A.N.] DAT broken in 2014.4.0?
Gesendet von:   "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>



Hi Andreas,

so far we don't have any known DAT regression in 2014.4.0.

Could you please provide a more detailed description about your setup
including how the nodes have their bridges configured and what
interfaces have been added to batman-adv?

Thanks!

On 13/03/15 08:28, Andreas Pape wrote:
> Is there a known issue conerning the DAT functionality in batman-adv=20
> 2014.4.0?
>=20
> I have got a problem with looping ARP packets / multiplication of ARP=20
> packets causing ARP storms in a setup with enabled DAT and BLA. My setup=
=20

> consists of 6 mesh nodes of which 3 are connected to the same backbone=20
> network. I connected a PC to the backbone which has an open ssh=20
connection=20
> to one ot the mesh nodes not connected to the backbone network directly.=
=20

> Using arp -d to delete the ARP cache of the Windows PC forces the PC to=20
> send an ARP request to the mesh node used for the ssh session. I can=20
then=20
> see multiple copies of that ARP request in the backbone in a wireshark=20
> recording and also multiple ARP replies from the mesh node.=20
> Sometimes also BLA gratuitous ARP telegrams seem to be looping, but it's=
=20

> easier to force this behaviour with regular ARPs (via arp -d on a PC).=20
> Non-ARP telegrams don't seem to be affected and except the waste of=20
> bandwith in the mesh and backbone I don't have problems with normal=20
> network communication in the mesh.
>=20
> I could provide the mentioned wireshark recordings made in the backbone=20
> network with a switch using port mirroring if someone explains how to=20
> provide such a file to the mailing list (I guess simple attachments are=20
> not allowed?).
>=20
> If I disable DAT, everything looks fine again, i.e. no duplicated ARP=20
> telegrams anymore (except for a few ARP replies from the mesh node which=
=20

> are received twice, which could be a race for claiming the device?)..
>=20
> Regards,
> Andreas
>=20
>=20
> ..................................................................
> PHOENIX CONTACT ELECTRONICS GmbH
>=20
> Sitz der Gesellschaft / registered office of the company: 31812 Bad=20
Pyrmont
> USt-Id-Nr.: DE811742156
> Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
> ___________________________________________________________________
> Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte=20
Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail=
=20
irrt=FCmlich erhalten haben, informieren Sie bitte sofort den Absender und=
=20
vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige=20
Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
>=20
---------------------------------------------------------------------------=
-------------------------
> This e-mail may contain confidential and/or privileged information. If=20
you are not the intended recipient (or have received this e-mail in error)=
=20
please notify the sender immediately and destroy this e-mail. Any=20
unauthorized copying, disclosure, distribution or other use of the=20
material or parts thereof is strictly forbidden.
> ___________________________________________________________________
>=20

--=20
Antonio Quartulli

[Anhang "signature.asc" gel=F6scht von Andreas Pape/Phoenix Contact]=20



..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte Informa=
tionen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=FC=
mlich erhalten haben, informieren Sie bitte sofort den Absender und vernich=
ten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige Verwendu=
ng sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
