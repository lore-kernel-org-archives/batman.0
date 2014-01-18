Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 18 Jan 2014 15:07:22 +0800
Message-ID: <3247874.1xp1UKXXkF@diderot>
In-Reply-To: <1390013833-9364-1-git-send-email-linus.luessing@web.de>
References: <1390013833-9364-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1612983.5aMyVsBzVd";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: use eth_hdr() instead of
	skb->data in interface_tx path
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


--nextPart1612983.5aMyVsBzVd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 18 January 2014 03:57:13 Linus L=FCssing wrote:
> Using eth_hdr() instead of skb->data avoids some ugly type casts.
>=20
> I wasn't able to reproduce the skb ether header pointer mismatch
> mentioned in batadv_bla_tx() on a 3.11 kernel with a vlan on top of
> bat0 and therefore removed the according skb_reset_mac_header()
> call, too. In fact, it looks like it became obsolete with the followi=
ng
> commit, included since 3.9:
>=20
> "net: reset mac header in dev_start_xmit()" (6d1ccff627)

Maybe this falls into nitpicking but it sounds like 2 entirely differen=
t things=20
for which you could send 2 patches (twice the fame!) ?

Cheers,
Marek

--nextPart1612983.5aMyVsBzVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS2igyAAoJEFNVTo/uthzA+3wH/i07xGgnCLRzYQygWAeHGxgX
vWXpCbCi/6aKnIWqhg2ZsGkIQqa6NcJgASlr6Aenom0yMtiRCjsGlwr0TCo14miW
803Hvb+XikUqj+1OMKVTpD0XbHlpTnoXalfDHiw3n3sWS0K8OIaNZ1Xaw6ZWAS4r
34MKzlkbgzhMh40692VLQayquU02Qm5Sm7ai+GCgMZbYFMQ6l1hyIYuDsGSkUKpT
w1aaTSMVU5/U7OeAwY6+hMtlMTbJPDFQqchd7An47yjkPpI0a2jj/Q7d7AhnV38I
2RCPksTiduqN9itkWJsIxWvick0yT64mGiZIVTWOYExn+y4fqGJwSBZzP9exLm4=
=Otv+
-----END PGP SIGNATURE-----

--nextPart1612983.5aMyVsBzVd--

