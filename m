Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 20 Aug 2010 17:38:35 +0200
References: <4C6B80D2.9040906@web.de> <4C6E8B79.7040801@web.de>
	<201008201644.58520.sven.eckelmann@gmx.de>
In-Reply-To: <201008201644.58520.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2286825.NyTECGqZVx";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008201738.37057.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Tim <Timbo2001@web.de>, b.a.t.m.a.n@lists.open-mesh.net

--nextPart2286825.NyTECGqZVx
Content-Type: multipart/mixed;
  boundary="Boundary-01=_8FqbMGlilAv0YYh"
Content-Transfer-Encoding: 7bit


--Boundary-01=_8FqbMGlilAv0YYh
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sven Eckelmann wrote:
> I haven't wrote that code... so it may take a little bit until I feel in
> the right mood to hunt it real down.

Ok, could you please try the attached patch? Just add it to the other patch=
es=20
(you can omit 03-... after a successful test. But it may reveal interesting=
=20
information if that wasn't the actual problem). Don't forget to cleanup you=
r=20
openwrt build environment.

Best regards,
	Sven

--Boundary-01=_8FqbMGlilAv0YYh
Content-Type: text/x-patch;
  charset="UTF-8";
  name="04-mac_packet_buff_check.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="04-mac_packet_buff_check.patch"

diff --git a/hard-interface.c b/hard-interface.c
index 60e8a56..65a4a54 100644
=2D-- a/hard-interface.c
+++ b/hard-interface.c
@@ -129,6 +129,9 @@ static bool hardif_is_iface_up(struct batman_if *batman=
_if)
=20
 static void update_mac_addresses(struct batman_if *batman_if)
 {
+	if (!batman_if || !batman_if->packet_buff)
+		return;
+
 	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
=20
 	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
@@ -339,6 +342,7 @@ static struct batman_if *hardif_add_interface(struct ne=
t_device *net_dev)
 	batman_if->if_num =3D -1;
 	batman_if->net_dev =3D net_dev;
 	batman_if->if_status =3D IF_NOT_IN_USE;
+	batman_if->packet_buff =3D NULL;
 	INIT_LIST_HEAD(&batman_if->list);
=20
 	check_known_mac_addr(batman_if->net_dev->dev_addr);

--Boundary-01=_8FqbMGlilAv0YYh--

--nextPart2286825.NyTECGqZVx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMbqF8AAoJEF2HCgfBJntGn7EQANK2FhsWR2SCm6ilLfWyKpXj
hMRcthNH8dDW2bW3wwCsWm+42DTcwd2JzPs/kf9ksTczdvd2++lnMBX2H1dSe9MG
ZCn98gLnzpTft+Wzp1w7GR5ShZzSmQw7bMSt6TMAxAB70dF7it21+DLCQrcNYWQL
0BzHVq8nyiLSnr75r7T3w7xNLtTjy1tmk4/SOd7vYErA3RLrJRJStRdNtQ8JpD1u
NTyd+NZ8uHTTRFDYW22xTfCjwVPLuy2ySkb5K7tX6L0YXj6+4Q6y2ELdogRGsZoL
fXFFd+rGxG5W54heeD3+llR5ZB7/ju32t4FMQKCts9fObV8aEusKRXILcvzVf8pP
Wx+R8HfZlKydmj7C9P19Dz09KTM6ACECao+08F//kurZ7B23s9+6etN4jQoLxztX
3NBTvLlRKowpRxsHNWuj4e/VM9ew2Pu8gFFDxcSdDgih41OnYrlegS+jYDgrd1Jy
gWAsgY7sh2HxaWkmP1RBQLg+qzISvgn/r42pLpzKzgPP6akfRZBUOfTDjF+QLZ18
G/eGqjDtosjXw6WmPYjavPAHVZysiN51Mcwh2denpfIHUYUf4I8XIFC/Pps+mU6L
aA0oepW3NXUPnXnH8B3qL+BXu/iUWwcU5IGh/DzH1IbS39nxkPsQPn3lxwOdOq5b
1qOpReetyjSXN0inrXEW
=RGjb
-----END PGP SIGNATURE-----

--nextPart2286825.NyTECGqZVx--
