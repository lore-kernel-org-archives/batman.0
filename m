Return-Path: <a@unstable.cc>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-5-git-send-email-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <5693CF38.7090908@unstable.cc>
Date: Mon, 11 Jan 2016 23:50:16 +0800
MIME-Version: 1.0
In-Reply-To: <1451992006-13191-5-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9N3VtnKM6mdtknhjbsjbI758vWMJggm8J"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 05/31] batman-adv: Drop immediate
 orig_node free function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9N3VtnKM6mdtknhjbsjbI758vWMJggm8J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/01/16 19:06, Sven Eckelmann wrote:
> =20
> +/**
> + * batadv_tt_orig_list_entry_release - release tt orig entry from list=
s and
> + *  queue for free after rcu grace period
> + * @orig_entry: tt orig entry to be free'd
> + */
> +static void
> +batadv_tt_orig_list_entry_release(struct batadv_tt_orig_list_entry *or=
ig_entry)
> +{
> +	batadv_orig_node_free_ref(orig_entry->orig_node);
> +	kfree_rcu(orig_entry, rcu);
> +}

I really like this approach big time :) Scheduling the rcu calls one
after the other instead of nesting them (or even worse using the _now()
function) seems really clean and - of course - not buggy.

thanks for these patches Sven!

Cheers,

--=20
Antonio Quartulli


--9N3VtnKM6mdtknhjbsjbI758vWMJggm8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk887AAoJENpFlCjNi1MRf74P/iFfn/ZvZMsSE1amN5dz0gt8
ZQk907JhsfDGcjwb1UzUowxlM4tpJfiIsfhnGBpXDcE1VwqfV3FxN/pUyHPYQfdY
Est85cNwCRTEXXPk13g+pm28/hQwQGU6Cl3CH3TpKA7rYtBDs0XXLzrI34v0xuAc
cso48GN17ltTUG4at9KqC27tE9m+le4obLLtZbw3hbuxyIj2AaGDeIU4+1Yd27zK
1l0MB6VF9bkUV2Kb3x8rvW4cqoI0XQFDl9PwUlpJ5bUvZVVsGvPUSzqsz9NegC2F
VCfNs7Fqra5a+EMD2RwNrW418CI4T8CQ4GSyNKAmSfVuCyKqXGVhHCciq8teN9Pe
6hUceaowpMn4g6TdBpl1tgDhkNfsB3+DpsUfaBXjavaOnSaG571Fj38/lmljhHCI
UTLIwRJMslmlS9Y4zb3adYSTOkEx4NJ4gNFdMmCc22pvgbIDdxNt+YVL+8+mGSsH
KOT/nfciKv2mceC2WFFfYck8/nE8djpceMu00ht2i7F1hn+Xsezyv9goUvt8NbFO
+FL6/tiyXKlNrM9FDaI2qcfP9xFpxuXdvISA0SFITzAi9Utv0N7M98wEQm9fxJtu
Yzkrp3FtJw1ygI6cc2EvAACA46EkCiVwrQzV2zTdERRmLiTxn9QQItFffdKZO/jO
1hm1TOobsS5EL9NeApsL
=ILMv
-----END PGP SIGNATURE-----

--9N3VtnKM6mdtknhjbsjbI758vWMJggm8J--
