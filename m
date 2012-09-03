Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 03 Sep 2012 23:11:39 +0200
Message-ID: <2787714.Hq4L2aOJPu@sven-laptop.home.narfation.org>
In-Reply-To: <1346703631-17948-1-git-send-email-linus.luessing@web.de>
References: <1346703631-17948-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1551424.JcmMsukbgC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: make batadv_test_bit()
	return 0 or 1 only
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1551424.JcmMsukbgC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday 03 September 2012 22:20:31 Linus L=C3=BCssing wrote:
> On some architectures test_bit() can return other values than 0 or 1:=

>=20
> With a generic x86 OpenWrt image in a kvm setup (batadv_)test_bit()
> frequently returns -1 for me, leading to batadv_iv_ogm_update_seqnos(=
)
> wrongly signaling a protected seqno window.
>=20
> This patch tries to fix this issue by making batadv_test_bit() return=
 0
> or 1 only.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Weird, I couldn't find the code that would cause a -1 here (but I just =
checked=20
recent kernel versions). Most of them already added the "!=3D 0" in the=
 function=20
itself. And the both version of the variable_test_bit seem to return 0 =
and -1=20
(at least my quick interpretation of the asm listings).

But you see it and therefore I would guess it is a real problem. Btw. t=
his=20
regression was introduced in a9f07211f65782d8f587ed3259ac8055b098cd24 (=
so it=20
was in v2012.2.0 and 0079d2cef1514422668c7beedd61bfde5aa2c146 was part =
of=20
linux 3.5)

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks

> ---
>  bitarray.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/bitarray.h b/bitarray.h
> index a081ce1..cebaae7 100644
> --- a/bitarray.h
> +++ b/bitarray.h
> @@ -20,8 +20,8 @@
>  #ifndef _NET_BATMAN_ADV_BITARRAY_H_
>  #define _NET_BATMAN_ADV_BITARRAY_H_
>=20
> -/* returns true if the corresponding bit in the given seq_bits indic=
ates
> true - * and curr_seqno is within range of last_seqno
> +/* Returns 1 if the corresponding bit in the given seq_bits indicate=
s true
> + * and curr_seqno is within range of last_seqno. Otherwise returns 0=
.
>   */
>  static inline int batadv_test_bit(const unsigned long *seq_bits,
>  =09=09=09=09  uint32_t last_seqno, uint32_t curr_seqno)
> @@ -32,7 +32,7 @@ static inline int batadv_test_bit(const unsigned lo=
ng
> *seq_bits, if (diff < 0 || diff >=3D BATADV_TQ_LOCAL_WINDOW_SIZE)
>  =09=09return 0;
>  =09else
> -=09=09return  test_bit(diff, seq_bits);
> +=09=09return test_bit(diff, seq_bits) !=3D 0;
>  }
>=20
>  /* turn corresponding bit on, so we can remember that we got the pac=
ket */
--nextPart1551424.JcmMsukbgC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQRR0LAAoJEF2HCgfBJntG3cAP+gLdO+JjwhhbpP5N9huAfHOL
k5OVsIVsdTQfnSuUrJILElQVgkPnlvCHvKYmwRxdCEZjNDlF+B865qL6NozHDUCh
U44mhvSL1pcGh7UhRsfXKL0rq4VzpgYdvgSXG+KP2zJ+DUPHfG+d/z1ZxCYgIZP9
N0dPZx63LMtvaX5JhqtwEA0TgZ5UJhidUqc+Z/2BLA2UiyZhZbM8tOSNJCy/Ifkk
ExaecTdXm9WU5lNBvtzox6COTiwc4tQKIWVM2RBhYJ+LbRrXeWRS0Xm0GRtgY/Ns
LgEyd2pixxckFip7uesoq1fC6T9vn0Z2qGsyZHvOc3Lv4JElzozLGjw60rJHF5Mj
piBkLodio9/jQ+T2RwcBJTaUymZ+lLtLtNQNu/JtysB7okpKMzN4s4tefwpOlZKM
urdyOP9zPyK1AAYrdlMWGyc3cjf59cHCOQq6nuqWjtVMaGXmMFpCWZoEoHaO6mFk
RFzcsdPYh0JtZbVoozQuP9Kowi3oQX1lJHvA9rZDSXTC3WhxBatC25AhOs9492gA
z3cN/pVrwiL1YCYh7Xz9kc+bKxBQ/kVBubCuOZc3plKkCU6NUFZ3eSzTbYuVPG31
zXq9ucDtPGloOHYl0tm+gCrRJTjnVs3DdnWINn2Dp42JyXPbfnEL5NAG/wbZNeqh
JqbpeozgrHB6xtmHJqaB
=vrJW
-----END PGP SIGNATURE-----

--nextPart1551424.JcmMsukbgC--

