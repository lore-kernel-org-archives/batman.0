Return-Path: <antonio@meshcoding.com>
Message-ID: <5502CF6D.3030408@meshcoding.com>
Date: Fri, 13 Mar 2015 12:52:13 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <OFC7CC1C02.68EA7DC9-ONC1257E07.00275710-C1257E07.002916EB@phoenixcontact.com>
In-Reply-To: <OFC7CC1C02.68EA7DC9-ONC1257E07.00275710-C1257E07.002916EB@phoenixcontact.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="klgOHOrQV7oo0c5TQNAnhri51n1MsQAf5"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--klgOHOrQV7oo0c5TQNAnhri51n1MsQAf5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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
> packets causing ARP storms in a setup with enabled DAT and BLA. My setu=
p=20
> consists of 6 mesh nodes of which 3 are connected to the same backbone =

> network. I connected a PC to the backbone which has an open ssh connect=
ion=20
> to one ot the mesh nodes not connected to the backbone network directly=
=2E=20
> Using arp -d to delete the ARP cache of the Windows PC forces the PC to=
=20
> send an ARP request to the mesh node used for the ssh session. I can th=
en=20
> see multiple copies of that ARP request in the backbone in a wireshark =

> recording and also multiple ARP replies from the mesh node.=20
> Sometimes also BLA gratuitous ARP telegrams seem to be looping, but it'=
s=20
> easier to force this behaviour with regular ARPs (via arp -d on a PC). =

> Non-ARP telegrams don't seem to be affected and except the waste of=20
> bandwith in the mesh and backbone I don't have problems with normal=20
> network communication in the mesh.
>=20
> I could provide the mentioned wireshark recordings made in the backbone=
=20
> network with a switch using port mirroring if someone explains how to=20
> provide such a file to the mailing list (I guess simple attachments are=
=20
> not allowed?).
>=20
> If I disable DAT, everything looks fine again, i.e. no duplicated ARP=20
> telegrams anymore (except for a few ARP replies from the mesh node whic=
h=20
> are received twice, which could be a race for claiming the device?)..
>=20
> Regards,
> Andreas
>=20
>=20
> ..................................................................
> PHOENIX CONTACT ELECTRONICS GmbH
>=20
> Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyr=
mont
> USt-Id-Nr.: DE811742156
> Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Roland Bent, Dr. Martin He=
ubeck
> ___________________________________________________________________
> Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BCtz=
te Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-=
Mail irrt=C3=BCmlich erhalten haben, informieren Sie bitte sofort den Abs=
ender und vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche an=
derweitige Verwendung sowie die unbefugte Weitergabe dieser Mail ist nich=
t gestattet.
> -----------------------------------------------------------------------=
-----------------------------
> This e-mail may contain confidential and/or privileged information. If =
you are not the intended recipient (or have received this e-mail in error=
) please notify the sender immediately and destroy this e-mail. Any unaut=
horized copying, disclosure, distribution or other use of the material or=
 parts thereof is strictly forbidden.
> ___________________________________________________________________
>=20

--=20
Antonio Quartulli


--klgOHOrQV7oo0c5TQNAnhri51n1MsQAf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVAs9wAAoJEJgn97Bh2u9eemIP/3G1BQiURgZTAZTAQqA2c5q1
lGMkJI9Xe5E+5z3v1uVo0Bo5dgOShpDOQpbTn0bz2wbpi5p2S8YWNoGBRQn0Ope3
E31R1mytQXFfxop7XYRysH8CldIIsoEKaP7mhIsw72y8YCVNJBrF+rMxhMd26Dx1
YqSsFhnS8YAeeEDzb2g03ImBOknc2Hil25Dko8VmQngx4ygbKGeB3hJTGxsnfTwh
H9g3+/B7JgOyn0GnqRJjgIaVDaVNC5iGT+VFJ3B2V/oSIqTg2GiVnayiUV29H0WP
zwKK9FoLu2PZ1ujCm4bzFqLInuMy+aYq72nNEL88YRgd5vM3Ti+OQEfpMvZuACJW
1j0J5geJgQ01zJGbn8gZb5x2jKW4Kda6B1Ka1/u/GGDl11nOB1t3qy+3wNp9D3dB
zJj10LZWwHYbf0gWSBwh61HwSyQzcXseci+GcGs21LiWRaBPZD1fonUxq7CEvapU
5PF0ieeJPffyAXklHl46YpG/BlmWbbmQKFXOd0InVbtcCAk2Cbq2ceZ2infdiZox
AQq0xgVrkZfU+kLRZt5iXL40sTNeEHUJEJIvoK5XY7+g/HKpPXzaIZPrzUt/bSXn
3x0OkXTqq8MG4uhySz1qqYOdQ3y3oFZmN46iCWhgUs5je0qrgSioWZ6wOfbiqdJY
5otiL/knlSehm9hwHp9m
=6qat
-----END PGP SIGNATURE-----

--klgOHOrQV7oo0c5TQNAnhri51n1MsQAf5--
