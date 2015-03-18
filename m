Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <OFF07BA093.8D744C20-ONC1257E07.004BE977-C1257E07.00503089@phoenixcontact.com>
References: <OFC7CC1C02.68EA7DC9-ONC1257E07.00275710-C1257E07.002916EB@phoenixcontact.com>
 <5502CF6D.3030408@meshcoding.com>
 <OFF07BA093.8D744C20-ONC1257E07.004BE977-C1257E07.00503089@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF67DD2D01.84CED6E1-ONC1257E0C.0039329E-C1257E0C.003B181B@phoenixcontact.com>
Date: Wed, 18 Mar 2015 11:45:27 +0100
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

In the meantime I digged a little deeper into this. DAT as such works but=20
has some side effects on the backbone network in a setup like mine with=20
several mesh nodes connected to the same backbone network and bla enabled.=
=20
I see two main issues:

1. The original broadcast ARP request sent by the PC is looping back into=20
the backbone network. As far as I have figured out this comes from the=20
encapsulation of the original ARP broadcast into a BATADV_UNICAST_4ADDR=20
frame, which is not handled by the bla code responsible for preventing=20
looping broadcasts as for bla this is a unicast frame.
2. All ARP replies are forwarded into the backbone by all possible=20
gateways. If a gateway gets responses of up to 3 remote dat candidates,=20
the total number of seen arp replies becomes 3 times the number of=20
gateways used.

I am not sure, if this is specific to the old kernel version I used, but I=
=20
tried to overcome the two mentioned points with the following measures:
1. drop BATADV_UNICAST_4ADDR DHT_GET frames received from another gateway=20
as long as we cannot answer the forwarded arp request.
2. make sure, that only a gateway which has claimed the src mac of an arp=20
reply forwards this reply to the backbone network
3. drop received arp replies as soon as we have a local dat entry for the=20
src mac of the arp reply. In this case it is most likely that the device=20
has already sent a reply.

With these measures I see a "clean" arp request / reply behaviour in the=20
backbone network. As a further improvement I added the snooping of all=20
incoming IP traffic on the mesh soft interface. I use the src mac and src=20
IP to update the local dat cache. I wanted to achieve as low arp=20
request/reply and connected broadcast traffic in the mesh as possible.

If there is interest I could send a patch file to the mailing list with=20
the changes based on the batman-adv git master. But I warn you in front: I=
=20
am not a very skilled kernel programmer nor do I have any experience in=20
using git ;-)=20

Regards,
Andreas

"B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb am=20
13.03.2015 15:35:53:

> Von: Andreas Pape <APape@phoenixcontact.com>
> An: The list for a Better Approach To Mobile Ad-hoc Networking=20
> <b.a.t.m.a.n@lists.open-mesh.org>,=20
> Datum: 13.03.2015 15:57
> Betreff: Re: [B.A.T.M.A.N.] DAT broken in 2014.4.0?
> Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>=20
> Hello Antonio,
>=20
> my mesh nodes use a wlan interface in adhoc mode as the only hard_if in=20
> bat0. bat0 is bridged to a Linux bridge br0 together with the Ethernet=20
> interface eth0. The wlan interface ath0 is not part of that bridge. The=20
> only interface having an ip address assigned is the bridge br0.
>=20
> As mentioned I use 6 mesh nodes of that described setup of which 3 are=20
> only accessible via the mesh (eth0 interface not connected to any other=20
> Ethernet device) and 3 devices are connected with their eth Interfaces=20
to=20
> the same Ethernet switch. The Windows PC is also connected to that same=20
> switch.
>=20
> I am using batman-adv 2014.4.0 in combination with a fairly old Linux=20
> kernel 2.6.32.26 on an embedded device. If I enable BLA and DAT and send=
=20
a=20
> ping from the Windows PC to one of the mesh nodes which is not connected=
=20

> to the Ethernet backbone, I see a multiplication of the ARP request sent=
=20

> by the PC and even a higher amount of corresponding ARP replies in the=20
> backbone network of which I am not sure, how much of them are really=20
sent=20
> by the mesh node being the original destination for the ARP request.=20
> Furthermore I get lots of "bat0: received packet with own address as=20
> source address" and some "eth0: received ...." kernel log messages in=20
that=20
> case as soon as the PC sends the first broadcast ARP request (after the=20
> mentioned arp -d command).=20
>=20
> If I disable DAT on all of my 6 devices the ARP telegrams being visible=20
in=20
> the backbone network look normal to me. There is only one broadcast ARP=20
> request from the PC and only one ARP reply.
>=20
> In the meantime I enabled dat debug messages on one of my gateways=20
between=20
> the ethernet backbone and the mesh. After clearing the ARP cache of the=20
PC=20
> by the arp -d command, I see the following output of batctl l
>=20
> Parsing outgoing ARP REQUEST
> ARP MSG : [src: <mac of the PC> - 192.168.0.50 dst: 00:00:00:00:00:00 -=20
> 192.168.0.101]
> Entry updated 192.168.0.50 <mac of the PC>
> ARP request replied locally
> ARP Request for 192.168.0.101: fallback prevented
> Parsing incoming ARP REPLY
> ARP MSG: [src: <mac of the mesh node> - 192.168.0.101 dst: <mac of the=20
PC>=20
> - 192.168.0.50]
> * encapsulated within a UNICAST packet
> Entry updated: 192.168.0.101 <mac of the mesh node>
> Entry updated: 192.168.0.50 <mac of the PC>
>=20
> followed by a flood of additional messages of similiar kind. From this=20
> logging and from what I understood so far about bla and dat from=20
> open-mesh.org and a short look into the source code I conclude, that the=
=20

> gateway knew already the mac the PC was looking for ("ARP request=20
replied=20
> locally") and did not forward it as a broadcast into the mesh.=20
> Nevertheless the gateway received an ARP reply from the mesh. I guess=20
the=20
> original ARP request broadcast was forwarded at least by one of the=20
> remaining two backbone gateways into the mesh and a reply was sent by=20
> someone else (another mesh node with enabled dat or the mesh node being=20
> searched for).
>=20
> This leads me to the question if using dat and a bla setup in=20
combination=20
> is considered by design and if this should work or if dat is only=20
> reasonable to be used when a backbone network has a single gateway into=20
> the mesh (as depicted in the dat wiki on open-mesh.org) only.=20
>=20
> Thanks for the support and regards,
> Andreas
>=20
>=20
>=20
> Von:    Antonio Quartulli <antonio@meshcoding.com>
> An:     The list for a Better Approach To Mobile Ad-hoc Networking=20
> <b.a.t.m.a.n@lists.open-mesh.org>,=20
> Datum:  13.03.2015 13:22
> Betreff:        Re: [B.A.T.M.A.N.] DAT broken in 2014.4.0?
> Gesendet von:   "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>=20
>=20
>=20
> Hi Andreas,
>=20
> so far we don't have any known DAT regression in 2014.4.0.
>=20
> Could you please provide a more detailed description about your setup
> including how the nodes have their bridges configured and what
> interfaces have been added to batman-adv?
>=20
> Thanks!
>=20
> On 13/03/15 08:28, Andreas Pape wrote:
> > Is there a known issue conerning the DAT functionality in batman-adv=20
> > 2014.4.0?
> >=20
> > I have got a problem with looping ARP packets / multiplication of ARP=20
> > packets causing ARP storms in a setup with enabled DAT and BLA. My=20
setup=20
>=20
> > consists of 6 mesh nodes of which 3 are connected to the same backbone=
=20

> > network. I connected a PC to the backbone which has an open ssh=20
> connection=20
> > to one ot the mesh nodes not connected to the backbone network=20
directly.=20
>=20
> > Using arp -d to delete the ARP cache of the Windows PC forces the PC=20
to=20
> > send an ARP request to the mesh node used for the ssh session. I can=20
> then=20
> > see multiple copies of that ARP request in the backbone in a wireshark=
=20

> > recording and also multiple ARP replies from the mesh node.=20
> > Sometimes also BLA gratuitous ARP telegrams seem to be looping, but=20
it's=20
>=20
> > easier to force this behaviour with regular ARPs (via arp -d on a PC).=
=20

> > Non-ARP telegrams don't seem to be affected and except the waste of=20
> > bandwith in the mesh and backbone I don't have problems with normal=20
> > network communication in the mesh.
> >=20
> > I could provide the mentioned wireshark recordings made in the=20
backbone=20
> > network with a switch using port mirroring if someone explains how to=20
> > provide such a file to the mailing list (I guess simple attachments=20
are=20
> > not allowed?).
> >=20
> > If I disable DAT, everything looks fine again, i.e. no duplicated ARP=20
> > telegrams anymore (except for a few ARP replies from the mesh node=20
which=20
>=20
> > are received twice, which could be a race for claiming the device?)..
> >=20
> > Regards,
> > Andreas
> >=20
> >=20
> > ..................................................................
> > PHOENIX CONTACT ELECTRONICS GmbH
> >=20
> > Sitz der Gesellschaft / registered office of the company: 31812 Bad=20
> Pyrmont
> > USt-Id-Nr.: DE811742156
> > Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> > Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
> > ___________________________________________________________________
> > Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte=20
> Informationen. Wenn Sie nicht der richtige Adressat sind oder diese=20
E-Mail=20
> irrt=FCmlich erhalten haben, informieren Sie bitte sofort den Absender un=
d=20

> vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche=20
anderweitige=20
> Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht=20
gestattet.
> >=20
>=20
---------------------------------------------------------------------------=
-------------------------
> > This e-mail may contain confidential and/or privileged information. If=
=20

> you are not the intended recipient (or have received this e-mail in=20
error)=20
> please notify the sender immediately and destroy this e-mail. Any=20
> unauthorized copying, disclosure, distribution or other use of the=20
> material or parts thereof is strictly forbidden.
> > ___________________________________________________________________
> >=20
>=20
> --=20
> Antonio Quartulli
>=20
> [Anhang "signature.asc" gel=F6scht von Andreas Pape/Phoenix Contact]=20
>=20
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
> Informationen. Wenn Sie nicht der richtige Adressat sind oder diese=20
> E-Mail irrt=FCmlich erhalten haben, informieren Sie bitte sofort den=20
> Absender und vernichten Sie diese Mail. Das unerlaubte Kopieren,=20
> jegliche anderweitige Verwendung sowie die unbefugte Weitergabe=20
> dieser Mail ist nicht gestattet.
>=20
---------------------------------------------------------------------------=
-------------------------
> This e-mail may contain confidential and/or privileged information.=20
> If you are not the intended recipient (or have received this e-mail=20
> in error) please notify the sender immediately and destroy this e-
> mail. Any unauthorized copying, disclosure, distribution or other=20
> use of the material or parts thereof is strictly forbidden.
> ___________________________________________________________________



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
