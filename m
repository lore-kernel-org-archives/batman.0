Return-Path: <ordex@autistici.org>
Date: Fri, 19 Apr 2013 10:26:51 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130419082651.GA13226@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] batman-adv merge-conflict
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

here are the instructions to resolve the conflicts you will get while mergi=
ng
net into net-next.


In net/batman-adv/routing.c

++<<<<<<< HEAD
 +static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
++=3D=3D=3D=3D=3D=3D=3D
+ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
+ 				       struct sk_buff *skb, int hdr_size)
++>>>>>>> maint

Resolves as:
/**
 * batadv_check_unicast_packet - Check for malformed unicast packets
 * @skb: packet to check
 * @hdr_size: size of header to pull
 *
 * Check for short header and bad addresses in given packet. Returns negati=
ve
 * value when check fails and 0 otherwise. The negative value depends on the
 * reason: -ENODATA for bad header, -EBADR for broadcast destination or sou=
rce,
 * and -EREMOTE for non-local (other host) destination.
 */
static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
				       struct sk_buff *skb, int hdr_size)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

++<<<<<<< HEAD
 +	if (!batadv_is_my_mac(ethhdr->h_dest))
 +		return -EREMOTE;
++=3D=3D=3D=3D=3D=3D=3D
+ 	if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest))
+ 		return -1;
++>>>>>>> maint

Resolves as:
if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest))
	return -EREMOTE;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

++<<<<<<< HEAD
 +	/* function returns -EREMOTE for promiscuous packets */
 +	check =3D batadv_check_unicast_packet(skb, hdr_size);
 +
 +	/* Even though the packet is not for us, we might save it to use for
 +	 * decoding a later received coded packet
 +	 */
 +	if (check =3D=3D -EREMOTE)
 +		batadv_nc_skb_store_sniffed_unicast(bat_priv, skb);
 +
 +	if (check < 0)
++=3D=3D=3D=3D=3D=3D=3D
+ 	if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
++>>>>>>> maint

Resolves as:
/* function returns -EREMOTE for promiscuous packets */
check =3D batadv_check_unicast_packet(bat_priv, skb, hdr_size);

/* Even though the packet is not for us, we might save it to use for
 * decoding a later received coded packet
 */
if (check =3D=3D -EREMOTE)
	batadv_nc_skb_store_sniffed_unicast(bat_priv, skb);

if (check < 0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D


I'm now going to send a pull request to fix some compile issues generated b=
y the
merge.


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRcP/LAAoJEADl0hg6qKeO5eUP/1LMY0o23vEs5FjDWPdcetKs
+2LMiso2Hu8NqGYKmWw73MFHyUrMgFOLA9MWF8hzSw4SlDqDUhuJb6hjMpOAMsy+
h3jTnyt0vHqWln3SNElicDB6hal98eoRhcFWX1gnsOnMsqfquVIcw0ahQdOowa4W
NUYZcREfC4/QXKJ0jNgIc8iBu89WmEiGxldJrv5L4QIWYwqxO4pR88mpR3sYze+E
lsHU/vKmab3z0uDHadBvA4wKguTsHEU32x9lHmP+EgEhthaz2ROX0LbaNLYBlQ7r
A5ABv17wcIkv/GIbW5OrGwW8ON/8qFrwPOwO7A8R48jUD+S8C7uHHAgTHijugq7v
3h66X1GlcsNwgp9Hf/2VC9O14Uf0klxW6l5Z7UTTH/fw5cTCr11RcmJIWxyiFKmy
zMJiVf0IUommSuALMjzyqT1qntB55utQATbQwIwCMYImvg5NY+/KM3Rh/KYUHD+y
1m90yYRkm9Uoy28K8PXYxVkwHdxVw+pnxsngyxfw/A4HcUfpNInBcMYs1h5PPC4G
ewBlBu3pxO31eYaYaX95E/wXArxCm5kuM4EdCqQbb0R5Ckk1qMXb7AUhqB1hlRGN
legcouy4qr3O7zJ7p07ydzdsn4oj1N6Q1LghHiIGfNFTLf1YNV/HdYhBFYsOuzi7
Rp8hTP76/yNRrrZUTL6O
=2HgT
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
