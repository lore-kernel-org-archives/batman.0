Return-Path: <antonio@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <1440170118-10876-2-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55DC386D.70109@meshcoding.com>
Date: Tue, 25 Aug 2015 11:42:05 +0200
MIME-Version: 1.0
In-Reply-To: <1440170118-10876-2-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="44Rc6wItS2JNiQM927xf6CB0UDL2lrPPf"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 1/4] batman-adv: fix speedy join
 for DAT cache replies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--44Rc6wItS2JNiQM927xf6CB0UDL2lrPPf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/08/15 17:15, Simon Wunderlich wrote:
> +			/* Cache replies should not be considered for speedy
> +			 * join, since the clients do not actually reside at
> +			 * the originator.
> +			 */
> +			if (subtype !=3D BATADV_P_DAT_CACHE_REPLY) {

Tha patch looks good but this should really be:

			if (subtype =3D=3D BATADV_P_DATA) {

because speedy join is supposed to work with any payload packet.

Cheers,

> +				orig_addr =3D unicast_4addr_packet->src;
> +				orig_node =3D batadv_orig_hash_find(bat_priv,
> +								  orig_addr);
> +			}
>  		}
> =20
>  		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
>=20

--=20
Antonio Quartulli


--44Rc6wItS2JNiQM927xf6CB0UDL2lrPPf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3DhxAAoJEOb/4TMchkvf8S0P/2zn3iRfrCfXhvYCL8vq3GR7
vrRvzOi7ECaBKSOPLjYMQjq/5swhGXW5m9fzJejSFmu2c+xdek1LEGOpDB5fa5y7
j0OrnTilYocL8MUYkm0OuNyyv0mFDYbDwYuR1ECoqtSHTzhhIGhwg+wzFeCXD2Td
zY4vqbeyKD8VGSNAXFMoRq20lpi6gP/eLY/8TKJYWzPjYbXWW4vlic68LIhpFKzV
owwvhN2tVQb4QdQd5bEJPdhHgMEsI2ztOiDGJTlp4ZmdLPp72AuBY8Z/IF5Ejn1t
RC7bcJWBCRzm5EdI4AynUCUcTPvfDtEKhMjh0dQTFMYExFu6gAnfliWpwbn+tX+r
HgWmLqbIN/tO8mnt4QeIIvIaePYWHMb9tc3o//+CEc6IXmdpn6bEVf0bVqyeuHAi
Nz1p70r6fGnK6t9QVgCTfq2wLeclgBLiQhphwrYFNmoOCOqDydYnfxLYUuF1rE2J
0qopUtjOwZwwl/PkNsihnq2JAw7+6ExzIO/NPgT955D+/rMo5U96EPvdg4JMqJWR
Hbmk24u7TBrahhG8yui6JicW4kkKbPQy5NsN85kMO+pxvxVEjFUxtICiXzObEv4n
PAX5yPhTVeuhwmYuP3NSABXDorts4uwLgFwpUAwKPTS689+q8NsSe0sSMTH8ERym
ubd5QYfcveVIfXMXmdyC
=qzpW
-----END PGP SIGNATURE-----

--44Rc6wItS2JNiQM927xf6CB0UDL2lrPPf--
