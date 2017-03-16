Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 16 Mar 2017 14:54:38 +0100
Message-ID: <1593560.U0KQ5s47cQ@bentobox>
In-Reply-To: <20170316133429.3923-3-sw@simonwunderlich.de>
References: <20170316133429.3923-1-sw@simonwunderlich.de>
 <20170316133429.3923-3-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6478866.HEWfkx5gMg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv8 2/5] batman-adv: prevent duplication of
	ARP replies when DAT is used
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc

--nextPart6478866.HEWfkx5gMg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 16. M=E4rz 2017 14:34:26 CET Simon Wunderlich wrote:
> +       /* If BLA is enabled, only forward ARP replies if we have claimed=
 the
> +        * source of the ARP reply or if no one else of the same backbone=
 has
> +        * already claimed that client. This prevents that different gate=
ways
> +        * to the same backbone all forward the ARP reply leading to mult=
iple
> +        * replies in the backbone.
> +        */
> +       if (!batadv_bla_is_my_claim(bat_priv, hw_src, vid)) {
> +               batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +                          "Device %pM claimed by another backbone gw. Dr=
op ARP reply.\n",
> +                          hw_src);
> +               dropped =3D true;
> +               goto out;
> +       }
> +

Thanks for the rebasing. But there is no function
"batadv_bla_is_my_claim". It was called batadv_bla_check_claim in patch 1.

And please also add a space between "PATCH" and "v8". This is how
"git format-patch -v8" would have created it. And patchwork can handle it a
little bit better when "PATCH" is a well separated word.

Kind regards,
	Sven
--nextPart6478866.HEWfkx5gMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAljKmR4ACgkQXYcKB8Em
e0ZDvxAAsNcSdRTJhatEWzFiHBKr+t0S2lqepDOEEE7DM2isiqKsNSbenNfZRHXL
1YzfM952bfl5U3VUL8bpfVlk/5Iu49lxNX4rEOferRXOIsu/m+6V883SkQw6xbdq
7Xm4AZOdYqSdyWw5Fa6j7uXO03gCgIbpA1qTJr3jPWgyR+QlZnrHJ8InAUEov5Lt
kdhvHdKJgUPdpVNVfXrRLYUyeWFdyQNBhldVNnyQ5UDTOgptoz27RsakzeB7KuWE
QIRcCgz/05ewiKhcO/zA4XKo9B55BtL7ceWtDYFO5TejKqlTud0zPBoZ34Hsnjo9
Ri8mNdKhoU8Fe1qmMl4hifpPtf4nSHtnOFvjB0DI53neqbNjaAXzK0GrdtFcga22
HxAdPBm70cxQRVWAPYe8MTV31hUvm2lmBo9ALTOiwWdzGAbZ0EJTQSsNPqpXMMXd
9LoG4ACMahinpMvIbIybzMF4LfA29FQ6vN1BQm62WGxWNVGDDy5dpASjR3uP9tpL
pSOTQYDyftFLyQJg3p/dpEFZPVbL6/Q+aphSf6fQZYfRSeqf/uGul0kPYtcxhtqG
y/98HimGUvqn8jMlDdxjeOXRXBRdnogq1Lz/5fvfByvOEHoZzo3b0yFVQcBvBp0a
szxWmuhcCziWADtKRNkCTgXpwp3se6YwScWIj0q8MWn0L1sJtZw=
=0kVA
-----END PGP SIGNATURE-----

--nextPart6478866.HEWfkx5gMg--

