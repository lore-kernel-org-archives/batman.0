Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 19 May 2011 21:40:55 +0200
References: <1305730043-3666-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1305730043-3666-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2795898.sThI3iUcUQ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105192141.11078.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: a multiline comment should
	precede the variable it is describing
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2795898.sThI3iUcUQ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> This comment has been wrongly put after the variable it refers to and was
> also bad indented
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>=20
>  types.h |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/types.h b/types.h
> index fab70e8..65b3222 100644
> --- a/types.h
> +++ b/types.h
> @@ -246,10 +246,10 @@ struct frag_packet_list_entry {
>  };
>=20
>  struct vis_info {
> -	unsigned long       first_seen;
> -	struct list_head    recv_list;
> -			    /* list of server-neighbors we received a vis-packet
> -			     * from.  we should not reply to them. */
> +	unsigned long first_seen;
> +	/* list of server-neighbors we received a vis-packet
> +	 * from.  we should not reply to them. */
> +	struct list_head recv_list;
>  	struct list_head send_list;
>  	struct kref refcount;
>  	struct hlist_node hash_entry;

Acked-by: Sven Eckelmann <sven@narfation.org>

--nextPart2795898.sThI3iUcUQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN1XJUAAoJEF2HCgfBJntG0YsP/09YyMTUlUWgse/p6v2KQVXX
DAflyLDH9rpM1HyUMz3XMIv+ZurMVxtuiCHgW7whYpcf3WQAhO41y5uIrk+fQgEj
nP7A6m7EJFR5zlGJNfzkPvqizkuaitO96Y1JE0HyUlthS4GX5HYR4/cF2IVvD8Vl
Ujf5CLa6XbQrl4lca4jzoK7zlUgCeLmlOcMJkZVfOQEMl9BkMu9eP0rklLiFf/lh
e6vfDDU5g11z85UIm45AqCEeutbA1gg1ognF4dYm/xSxC7cr6L3sXw8p7jLAY/I5
OV7KMwPaO6oVZqLuapWYCgOrehgzlKBg2ZRP/T3K97npnUgIJoRVYwpx3TR2W0ag
aYhs3ioK/1gAkBPuKRnKLG7qKTCJZ/OF6IGDqEH70tvgLLhkku0zpv53Ftd/62fe
z+zZcJQK7L39TC+5dd+IQdnxgkCBpPJeKcExPA4lDMdgv0vD2Zq3CDI6+P4B2zTv
d9jS0KbD9satIXSPkKkPOV2zPQyvYJUmuHXWy4/Md+PZl/UcYLq5rHh/eMY4KFHE
xhCbgarraanWJKIxbMCira898Smg0tThHbg1NQM5K4hwTQNnC1QygCR2zAPdAUUj
J7kkgRgCLpqqdXY6Y/SutKSCAMu4ucVNN+pJVdBCh/YX6XbRtxGqBv8QGCvqPCms
ezH+iA2M8cM9WjsuGEcX
=XX9B
-----END PGP SIGNATURE-----

--nextPart2795898.sThI3iUcUQ--
