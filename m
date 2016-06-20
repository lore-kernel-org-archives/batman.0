Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2016 22:14:28 +0200
Message-ID: <3881329.4jsIrYQ9vh@sven-edge>
In-Reply-To: <1466451595-6347-1-git-send-email-linus.luessing@c0d3.blue>
References: <1466451595-6347-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11282234.aZxzS1jqhF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Introduce forward packet
	creation helper
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

--nextPart11282234.aZxzS1jqhF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 20 June 2016 21:39:54 Linus L=FCssing wrote:
> This patch abstracts the forward packet creation into the new functio=
n
> batadv_forw_packet_alloc().
>=20
> The queue counting and interface reference counters are now handled
> internally within batadv_forw_packet_alloc() and its
> batadv_forw_packet_free() counterpart. This should reduce the risk of=

> having reference/queue counting bugs again and should increase
> code readibility.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
> Changelog v4:
> * Removed goto in batadv_iv_ogm_aggregate_new()
> * Removed two goto's in batadv_forw_packet_alloc()
> * Easier to read debug output code in batadv_forw_packet_alloc()
> * Renamed "out" and "packet_free" jump labels in batadv_add_bcast_pac=
ket_to_list()
>   to "err" and "err_packet_free"

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
=09Sven
--nextPart11282234.aZxzS1jqhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXaE6kAAoJEF2HCgfBJntGdrUP/jPvNwdoD6pYGnWWhMt3EJyM
mXyOVcwO2yiGCmJEUTLpR+6BkqorTk96oGn6+0uRAM4TdgP+Rz5jpQ2h/ecF+ekp
L4Gii8fufZJ85iajJtbGVwqwHoOooB9NAQIm92reTYpR66BT9GJGX8CZXIpIQH2B
Vywfs3XGJrHQTX88scCd+98Tt7BBm7VgtOXg+pNFdOZTnywOwZcNCU1vNPSP4r/v
L/ounFeArcw46gta94paogQxTLeqmQe076e8Gkjtf3za8pjbH5RYLzoL3RtM5oW1
w3GViAMdY/Z52/QjYSXe046plJ9nQS0Bfw5Tu8ITCEZ4I4Ex8Gcnx8IDaBtRbwls
H37zrDwE6JPD1O1yfqH0y1AJVpBUlL0IDdiKUZuaDWfAgCL0ubMf03tzyzUV8Mo8
nJvpVtSeFQV/gQrF5ZQ4WJwbJSkBYwFkuxG7LKuYsEtPb8HpqSp9KDt6zJMokyyy
6ExQLQxtLyMPVI8MPZvxSWPL5hSXNTOPM6YNJgPUXxNF4ZCBYUqxlGkoovevSjl3
mjepfYh6rrG6wEePsipa+ZGieasbdxYxMtC6two/ViCQ33WUZRmQiQwuPRBjDlBT
+kzULaQgM6q1U8rJ1p+5LTBZvXo8EuqfUS4ZCykfIncikMLpCkHInzP5G+kEcSji
tWUy0xLIroBW0gWXK945
=LMNx
-----END PGP SIGNATURE-----

--nextPart11282234.aZxzS1jqhF--

