Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Aug 2012 16:43:37 +0200
Message-ID: <3916161.gilKzHejHU@sven-desktop.home.narfation.org>
In-Reply-To: <1344606392-27130-1-git-send-email-martin@hundeboll.net>
References: <1344606392-27130-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1468630.3NjUqLhgb8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused hlist macros
	in compat.h
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


--nextPart1468630.3NjUqLhgb8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday 10 August 2012 15:46:32 Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  compat.h | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/compat.h b/compat.h
> index 13253dd..8ac22a8 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -67,14 +67,6 @@
>=20
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
>=20
> -#define hlist_first_rcu(head) (*((struct hlist_node **)(&(head)->fir=
st)))
> -#define hlist_next_rcu(node) (*((struct hlist_node **)(&(node)->next=
)))
> -
> -#define __hlist_for_each_rcu(pos, head) \
> -=09for (pos =3D rcu_dereference(hlist_first_rcu(head)); \
> -=09     pos && ({ prefetch(pos->next); 1; }); \
> -=09     pos =3D rcu_dereference(hlist_next_rcu(pos)))
> -
>  #define rcu_dereference_protected(p, c) (p)
>=20
>  #endif /* < KERNEL_VERSION(2, 6, 34) */

Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
=09Sven
--nextPart1468630.3NjUqLhgb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQJ8EZAAoJEF2HCgfBJntGpogP/AmgtTB5UuZenoIl/rYycZuI
Y+8FPjc0QyLEjsdwFSfqr7Bm7wFhbExPSLB2nlz8QoRQ0N7W5ObgHdB13DGFbU8N
bAqXM23Eg5XOezLfWsfQBF97AQ/Hboosgja6Vz0ygMg/Vp2t+WMQAXHjQ5BAoLLG
XtwcKqq3SW0IKgAzUFx8jYrD/XTtbpK+5artDdHrK2e2FX/79HatnExtwo3ri2HV
pvi5t0AQ/3YmqEMULP9QFUPV1mFD6/PyzbyxaRmBopusXi3IM7zBHE9eb1oqYZ+j
kShxIy5Wi7DQBKd++y1FZJeUwNTsJXwTDG1F6RN+59dZoSjJ6rjzqQNNa6fhnzXm
VjVoENGg6otS8A99uqrQD7GKUWv13aKx4H0kjH4cYvyFGDfSrmoelhnzINjnjIo4
AZ7mSJiCOCMXwjAQBT6j/hg01GUeKYK7G8QFBrnMkjJsiqbqGnjUL9qRhkzi8LBD
9igQdI1PULHUIoyqWP7Rsd4bE/DKC3OE+BC6v7VLVmGuKCOL9ntYEbGlyFx3uGPu
4MNsUbuBwzLpK/ywD4W4DpzkMFyvcgC5hlt8lmKlHgF9kL/PQvo/S/bwWn3SMVje
Ix1LFhyuOyH0kl48iA5vIvTnEpB9ETS5BralXdnU3sEGsX/wOEm5sFsInETmyZAy
brZU9nfDSxHvUTUNt6Xb
=hI5R
-----END PGP SIGNATURE-----

--nextPart1468630.3NjUqLhgb8--

