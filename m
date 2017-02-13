Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Feb 2017 22:23:52 +0100
Message-ID: <3594207.H7EOxyrbqM@sven-edge>
In-Reply-To: <20170213200008.GK29718@otheros>
References: <20170213194431.24075-1-linus.luessing@c0d3.blue>
 <20170213200008.GK29718@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19568435.gBVaQ8cLbK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix transmission of
	final, 16th fragment
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
Cc: martin@hundeboll.net

--nextPart19568435.gBVaQ8cLbK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 13. Februar 2017 21:00:08 CET Linus L=FCssing wrote:
[...]
> And one more thing which seems fishy to me in this function:
>=20
> 526         /* Make room for the fragment header. */
> 527         if (batadv_skb_head_push(skb, header_size) < 0 ||
> 528             pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOM=
IC) < 0) {
> 529                 ret =3D -ENOMEM;
> 530                 goto put_primary_if;
> 531         }
> 532=20
> 533         memcpy(skb->data, &frag_header, header_size);
>=20
>=20
> For the pskb_expand_head() case, there is an skb_push(header_size) missin=
g,
> isn't it?

I am a little bit confused about your remark... and about the code.

So let's check what Martin wrote:

 * get header_size more room in our data section
 * allocate new buffer to get header_size + ETH_HLEN in front (but not part)
   of our data section

If one of these two fails then it will get in panic mode and leave the
function.

I agree that the header_size in pskb_expand_head is slightly odd and I don't
see why we would need it. My best guess would be to compensate the extra
header which "stole" some bytes from the headroom which the underlying
interface may need.

But more importantly, I don't understand why an extra skb_push(header_size)
(like you've suggested) would be necessary here. Why would you want to have=
 an
empty header_size region in the fragment between the actual header and the
fragment data?

Kind regards,
	Sven
--nextPart19568435.gBVaQ8cLbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliiI+gACgkQXYcKB8Em
e0bL6g//VAZg7QboAVuO9xLh8kxnUZcP0THJ5K4ojQxSDsO+4PvuLz2lwbhFtj0F
5Ac9NeO9CRrqeOpoCEAIuMrugUD1+zqm7Nxn4FZM/4qPc0htntMhMXbEJRJudj6E
/bL8C2L2CbCY8LA6Rar62dpoEQ1v8luurS5Y/Vc5K6VdWO0XZB+Af4qFzr//dk3s
iKECRbZRDR+mCynARpijyq/FU6Ybo8UFz6zTEtnKStErLbfi5B2UiGuizmS5A9s0
1u+t9VaQ46CTJFoSOa1EnZy0igFHdFCjk4dh+lX7jnxAKE0UkuyA3cXM78O1AaEo
/Uq30NVaLnI/w+h6nwYDrxO+Rgp2YMBhmfg2P5PK1RLKgpsy62ddO5EDHrSRZ0LO
eDW1cAfR4vBNT74QzfjlzQnIvOHTQnjM0ConEQLLfHjbDrK6pQMW7Ab7bpvvIjrN
pC/B2sx7S3gQPj2wyF/e6rT0fIGXarA0q1ZbQDj4GImQy52O/wLh0edLgbkOp0jW
nma6Dhxf5/jmBprrvKxPdDV2sfXOr1dlx/ovnzAuLzZUCVYappO03yZY0OzB0ytY
seNdcx65ZfAqUOek7L0x6UOw5iU9FeB9EOwcWOiZrisnBNIuBwVvoEfGIntdLe5b
AV5iR7Bak3c89PIZTbHPQRmQVxs8jzLBUjuouYToo2xsbbjdifM=
=+wJj
-----END PGP SIGNATURE-----

--nextPart19568435.gBVaQ8cLbK--

