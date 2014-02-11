Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA5D35.6020809@meshcoding.com>
Date: Tue, 11 Feb 2014 18:26:13 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sG8Tu3JhGlVk6DSkjsNLux4ucL8KeCuK4"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix potential
 orig_node reference leak
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
To: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sG8Tu3JhGlVk6DSkjsNLux4ucL8KeCuK4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/02/14 16:45, Simon Wunderlich wrote:
> Since batadv_orig_node_new() sets the refcount to two, assuming that
> the calling function will use a reference for putting the orig_node int=
o
> a hash or similar, both references must be freed if initialization of
> the orig_node fails. Otherwise that object may be leaked in that error
> case.
>=20
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  bat_iv_ogm.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 6f4fcdc..6000337 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -256,6 +256,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv=
, const uint8_t *addr)
>  free_bcast_own:
>  	kfree(orig_node->bat_iv.bcast_own);
>  free_orig_node:
> +	/* free twice, as batadv_orig_node_new set refcount to 2 */
> +	batadv_orig_node_free_ref(orig_node);
>  	batadv_orig_node_free_ref(orig_node);

Coudln't we just invoke kfree(orig_node) here ? I think that if we hit
this point it is because the node has not added to the hash and
therefore it i snot used in any other context. This way we avoid the
double free_ref() and we don't trgger the whole RCU mechanism.

Or am I missing something?

Cheers,

--=20
Antonio Quartulli


--sG8Tu3JhGlVk6DSkjsNLux4ucL8KeCuK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+l05AAoJEEKTMo6mOh1VOyQQAIM2W8wVMm+fEvvLdo5ZVazc
qWiusb96ec/J0OwNXX7C1aCsEZu9QIlLX3fUQ7SxNhLDN5zW0n8+09vl2rK+y3FW
RCkyjRrBY79Ww4O5qhKxj/TfBmvJRHvVZvUmbOU0gtrm5HrEMqtqJlL0KzX8a/GN
425Rh7LFUjF6+WqVhkwE3GQ8kViTuFUs7gh2arjrRUAw0iNi41tNILBvOgK6VFl7
4JIUqXLQ+FhGCVsHiJhJK1KxCAVfG+ivwCo4Y1Ivp+bkgKZZjdUdL+KA5sevgqNw
dn6l1S5wlTw7CPFqAPd3Pjgo0KQguIRx6svQSH2KO7QmAGIPvli0UDvWnz91V5ot
ibO/h/44K8KgmI/8sYdo+jW5QNE4KwGWCFkyzB2zKSSTgdm/ZFgC8PBlp+h5qgMK
Ua2SEQSa1wplLjlFPPcOG4iiPE/pS4io13wMVB4nPnfb9OakHBDT+mHXbbRglw8D
8w28Lw01Zif5FfURv1Xyh05rV5Jx0FAyFrsO0pivMAaG88y718sAmTd5xN1CXZPs
mOu+ogDFGI/5ey9Cf6nTrR0vQAUgFlbw5PKibDWByMLMrARf+liTKo8WR742StvO
/yHB/2uDyo4RwptI+ji6fCxdje48sWf5FSWs5mxs9MtTSr0FXmpq949nT4CKtI/B
D7C/1EiLzdeEQ3W+0Xkj
=teGs
-----END PGP SIGNATURE-----

--sG8Tu3JhGlVk6DSkjsNLux4ucL8KeCuK4--
