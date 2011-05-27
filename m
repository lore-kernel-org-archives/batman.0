Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 May 2011 00:20:21 +0200
References: <1306534222-11710-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1306534222-11710-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2818278.ApBKrEdhuB";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105280020.26937.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move the ttl field to the
	third position of unicast_* packets
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

--nextPart2818278.ApBKrEdhuB
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 May 2011 00:10:22 Antonio Quartulli wrote:
> Move the ttl field to the third position of unicast_packet and
> unicast_frag_packet. In this way it possible to give them a better shape
> for later usage
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
[..]
>  struct unicast_frag_packet {
>  	uint8_t  packet_type;
>  	uint8_t  version;  /* batman version field */
> -	uint8_t  dest[6];
>  	uint8_t  ttl;
> +	uint8_t  align;
> +	uint8_t  dest[6];
>  	uint8_t  flags;
> +	uint8_t  align;
>  	uint8_t  orig[6];
>  	uint16_t seqno;
>  } __packed;

Wait a second - are there two "align" in a single struct. Sry, have to Nack=
=20
that one :)

Kind regards,
	Sven

--nextPart2818278.ApBKrEdhuB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN4COpAAoJEF2HCgfBJntG9QQP/jGxdx2TL5pd9OKh/cykbFvT
EkZtLkt3opXgGPI08YVKblMiDdRL9Dm/k1douowK/j9lE9Ys1qHbxGDYlFT0EiqF
kD263M4nLqZOY3POSSh0bhdjEhQs1n0cb8BFGiR1VyM5fS4OE3n925mP14UH+g32
0QIQ6ZduK70qKaS6pp5j/IySTfsTCDJ9QzEHcj+R5CCJvkcDg57J/bU23wxthYzI
wTHpwcDmWpF93/KEh0MBK752SEiw9ny9JVCMo4pDGeN+ywI0QI1k2+6yy//ThIgF
OGFYAYtf5LCo+TyfVKnQF0Lqwy36dBKVh7k2h9Wne+jg/fRkTiR2b1OEW1KY/hLk
Wnd2riPCG7QCPF2cUtVWNduIabzDb2vM/vRYbPZ2C2d62vFLOnfDVNItT1zzmIQO
e9OonfKyN0VvQyoeUI6dK1PICNFMP1s+/Ly7QqssS7XsnYVVvtIa8bBIvk7iHCsh
Fs2u2PwWBQ2XRPTzfyK+kYovvrqctg9k6g3+5/BCBmyIj6f4HLAM4JoPuVPh5xG0
3oQK2O2NUJfDcAqsmi+B1CQl6O4qnPyMFaJu/a4rSZBJxzzyV7KsIIlLtcWxiPqe
zauTKuwYmL9tTxuxFGC9rJ8qaNRFpt29qbeo7XumSizKE6jWl8ZPSnA4J9ZuPoc0
QQf7ntgEehx/nI7ICitK
=7lU7
-----END PGP SIGNATURE-----

--nextPart2818278.ApBKrEdhuB--
