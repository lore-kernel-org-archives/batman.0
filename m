Return-Path: <antonio@meshcoding.com>
Message-ID: <52D84A0B.5050700@meshcoding.com>
Date: Thu, 16 Jan 2014 22:07:23 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1389832761-7914-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1389832761-7914-1-git-send-email-linus.luessing@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KG527AFsFLqtM2u8GBvnXeiogUu3nU7HX"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use eth_hdr() instead of
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
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KG527AFsFLqtM2u8GBvnXeiogUu3nU7HX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus!

On 16/01/14 01:39, Linus L=C3=BCssing wrote:
> +	if ((struct ethhdr *)skb->data !=3D eth_hdr(skb)) {
> +		pr_warn("Upper device did not set the ethernet header pointer correc=
tly - adjusting\n");
> +		skb_reset_mac_header(skb);
> +	}

I think that if we really want to properly set the mac_header we should
just do it and forget about the if and about the warning.

It's a really "stupid" operation and in the end we have many spots in
the kernel where the pointers are just set without adding too much
overhead like messages or other things...


Cheers,


--=20
Antonio Quartulli


--KG527AFsFLqtM2u8GBvnXeiogUu3nU7HX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS2EoOAAoJEEKTMo6mOh1VraYP/1Y7z2S40Pvi00ckIHIZDUnA
WCIMuLOwJUhYUu1fH0F1mIxHMy8TWNYVzywCjXQuDS6/mki6AprpOAfmTgZzoqKz
EmfWu1SjW/q1CsPlbSuuQEumavUw0Xusz6LwCHy2fiOnp42vZtH96EWro0q28JX2
A/20dJcPHSUvSpqXXCUTS28gseHFEAxC2Z7hjypnYTYzolPtZWoS+nkizOG3imRq
oH0To0sS9PIg38YgoLfS6X8KeBk1gJSnmJo9n4EAPR6aCOj30RbIKSsyLuwbT4/h
N0BMnotgcy6kPbvx0Z4SeIv0MMckmSNfBswCmIqwBKprE8JjBO/ZlPMcEilym1R4
aWE9FzdoZhpFa+1s3R5Dg9pV+UOiuYN+Ps66/HhtVssc1QWjGMUnrUDTyKF4LuoU
c3K7/JVNLaVOGB1/oRtqpxjS7q5zJ5EjCJ97zN2Nb8EOdKuVrhbEaFeS2WG1sR7e
PbvYh8jI13JrYyZn1sY5EeDrlZdijLsthfq7CrXQfpU3haZUhN3fkqpdLF7KvlwH
inXNyxi+xpY70qv3EKpACd3R4uGRfiSAXToDp47rRE4ngbVqdrbP/0oPZqE/6nSH
F+K02frqQ8FDLYsLVHS2YaA1Jzr+6D5mDn17WYVCnp+bBxRgpJArV3XpHg6Nj5x6
r07rD7pyrd9QyfYz9t+J
=JqGJ
-----END PGP SIGNATURE-----

--KG527AFsFLqtM2u8GBvnXeiogUu3nU7HX--
