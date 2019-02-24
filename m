Return-Path: <a@unstable.cc>
References: <20190223140906.28979-1-sven@narfation.org>
 <20190223140906.28979-3-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <c22ae443-fbdb-e719-0dae-6b1851dd1c96@unstable.cc>
Date: Sun, 24 Feb 2019 18:00:42 +1000
MIME-Version: 1.0
In-Reply-To: <20190223140906.28979-3-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cpxd4NU9XITCiXPqH6jfNzyojsxHUd8Ud"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Reduce tt_global hash refcnt only
 for removed entry
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cpxd4NU9XITCiXPqH6jfNzyojsxHUd8Ud
Content-Type: multipart/mixed; boundary="1DF4YkHQhL5jp7tzOUgbewGPqOE2F9z9j";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <c22ae443-fbdb-e719-0dae-6b1851dd1c96@unstable.cc>
Subject: Re: batman-adv: Reduce tt_global hash refcnt only for removed entry
References: <20190223140906.28979-1-sven@narfation.org>
 <20190223140906.28979-3-sven@narfation.org>
In-Reply-To: <20190223140906.28979-3-sven@narfation.org>

--1DF4YkHQhL5jp7tzOUgbewGPqOE2F9z9j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/02/2019 00:09, Sven Eckelmann wrote:
> The batadv_hash_remove is a function which searches the hashtable for a=
n
> entry using a needle, a hashtable bucket selection function and a compa=
re
> function. It will lock the bucket list and delete an entry when the com=
pare
> function matches it with the needle. It returns the pointer to the
> hlist_node which matches or NULL when no entry matches the needle.
>=20
> The batadv_tt_global_free is not itself protected in anyway to avoid th=
at
> any other function is modifying the hashtable between the search for th=
e
> entry and the call to batadv_hash_remove. It can therefore happen that =
the
> entry either doesn't exist anymore or an entry was deleted which is not=
 the
> same object as the needle. In such an situation, the reference counter =
(for
> the reference stored in the hashtable) must not be reduced for the need=
le.
> Instead the reference counter of the actually removed entry has to be
> reduced.
>=20
> Otherwise the reference counter will underflow and the object might be
> freed before all its references were dropped. The kref helpers reported=

> this problem as:
>=20
>   refcount_t: underflow; use-after-free.
>=20
> Fixes: 7bad46397eff ("batman-adv: protect the local and the global tran=
s-tables with rcu")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli


--1DF4YkHQhL5jp7tzOUgbewGPqOE2F9z9j--

--Cpxd4NU9XITCiXPqH6jfNzyojsxHUd8Ud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlxyTyoACgkQ9FVsWUWD
Dm1AAhAAlG7gVM7DvZFju7rhu5G61swLkpmfx01p2XljJZi04mnKRSTVW6c0oMm2
AIksCuWnQa5ayn4M/66OVqAJbT2xeUJCk8GCzprXu7cnhWmqOWJyTLEXkH6x00W6
fC7eeVat4Li69AjcGCSfE6vk25/M3awtBFWhztMUm5+8EyODroUkJKesILjsqcdf
w53+t5GMD/Zm59a7R8mNU0j0Sy1uvwlN0CIzu+Gt41uVtNKYL9BfE7VC5NpxKwBG
bIney6TSCm2ofRbmvJLz2lWLSoB6otmsTZfrEqtizUSGse6AsVMdFqnbUzYVo7yx
7q4+nS9QSnkyqTOJbiwWCH0uAwPgMrVZVQpN8JQAbQfXydWNrVOpelDsLyNqWkNa
jvUJxdb+nsHAj2sM9PzOn5BOGWwJL4BpPEsQsf2sTXHVXFYf5cYahUYNTgmD1Vxx
NFAKQ1V8buq/ZicKLSjG0PodteVtLIEuoTZ6FlBM5C2iO+VSXe4inDQDvr35uW2n
FOXVouAIgigcQ1cfZqrLRZxBgJ91+Z3AARIKoZG1IG4dHMKLysOw7rqtywFvOolF
2Ewfh+hQzJlTPrxlZqDL/HVjKp5XaMn2WmAOxSsFzBHis5vKyqi6rdE3XEO+LEBB
9t7p1lBiQv0sDYPB6ID+VQ7x9VvWO1sqXfyKjDVipP7PZBymXzw=
=MGxE
-----END PGP SIGNATURE-----

--Cpxd4NU9XITCiXPqH6jfNzyojsxHUd8Ud--
