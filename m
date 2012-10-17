Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 15:32:35 +0200
Message-ID: <10983703.1hvxGlDkkL@bentobox>
In-Reply-To: <1350473910-27496-1-git-send-email-linus.luessing@web.de>
References: <1350473910-27496-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2262514.bnrsm7mbKX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix broadcast packet CRC
	calculation
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


--nextPart2262514.bnrsm7mbKX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 17 October 2012 13:38:30 Linus L=FCssing wrote:
> So far the crc16 checksum for a batman-adv broadcast data packet, rec=
eived
> on a batman-adv hard interface, was calculated over zero bytes of its=

> content leading to many incoming broadcast data packets wrongly being=

> dropped.
>=20
> This patch fixes this issue by calculating the crc16 over the actual,=

> complete broadcast payload.
>=20
> The issue is a regrission introduced by
> e5cf86d30a9b32feccb6b866a3f23b0e0483a3b0.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
> It led to about 60-80% broadcast packet loss to a direct neighbor
> with a ping6 with a 1s interval in our scenario, but about no
> packet loss with an interval smaller than 0.2s.
>=20
> Also see: https://projects.universe-factory.net/issues/65 (German)
>=20
>  bridge_loop_avoidance.c |    8 ++++----
>  routing.c               |    8 +++++++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index 6705d35..e7b5777 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -1205,8 +1205,8 @@ int batadv_bla_init(struct batadv_priv *bat_pri=
v)
>  /**
>   * batadv_bla_check_bcast_duplist
>   * @bat_priv: the bat priv with all the soft interface information
> - * @bcast_packet: originator mac address
> - * @hdr_size: maximum length of the frame
> + * @bcast_packet: encapsulated broadcast frame plus batman header
> + * @bcast_packet_len: length of encapsulated broadcast frame plus ba=
tman
> header *
>   * check if it is on our broadcast list. Another gateway might
>   * have sent the same packet because it is connected to the same bac=
kbone,
> @@ -1219,14 +1219,14 @@ int batadv_bla_init(struct batadv_priv *bat_p=
riv)
>   */
>  int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
>  =09=09=09=09   struct batadv_bcast_packet *bcast_packet,
> -=09=09=09=09   int hdr_size)
> +=09=09=09=09   int bcast_packet_len)
>  {
>  =09int i, length, curr;
>  =09uint8_t *content;
>  =09uint16_t crc;
>  =09struct batadv_bcast_duplist_entry *entry;
>=20
> -=09length =3D hdr_size - sizeof(*bcast_packet);
> +=09length =3D bcast_packet_len - sizeof(*bcast_packet);
>  =09content =3D (uint8_t *)bcast_packet;
>  =09content +=3D sizeof(*bcast_packet);
>=20
> diff --git a/routing.c b/routing.c
> index bc2b88b..f861b7c 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -1136,8 +1136,14 @@ int batadv_recv_bcast_packet(struct sk_buff *s=
kb,
>=20
>  =09spin_unlock_bh(&orig_node->bcast_seqno_lock);
>=20
> +=09/* keep skb linear for crc calculation */
> +=09if (skb_linearize(skb) < 0)
> +=09=09goto out;


Please don't ues linearize here. Try to fix the crc calculation using=20=

skb_walk_frags (see for example net/netfilter/nf_nat_proto_sctp.c ).

And Simon owes you a beer for this debugging ;)

Kind regards,
=09Sven
--nextPart2262514.bnrsm7mbKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQfrNzAAoJEF2HCgfBJntGdt8P/R+ra0IYiHixZPIxHEhGqfPo
xIIXu4yARNaoCzu9RF0wUu4UQ2zWtgz+tJN6saMztd0J8BQWWKjQYkkL/Rtiy6sF
Lk04TaoAy4h/kl1q8IU90izAX7yBHoVsF7dOQmg+CmF8WUD9uDSjB/qsoFZxzJvZ
qxLWjIXIq6o2Kr9CXvL2US3nNQ9jlCuMRbxkxFjSaoTTmvRpEBpF0gHM6phE+una
WzdbtI8CkyeBGr8Z0l2UbBhzsQU8YBLfg89FZ4hVv2pc10+IUFp9Nk24wdL5pMLE
gB6fQsB2Uwa2OBRi+U3R/ty2y3ZANrVNEW3+ILzet8VFlSf2deY124pf+eKXpGau
CIbhOCKChgCiB4DeXYyB6oHbeErL6S5ZtO1W+vpOou/w9c8/NNn4SBxKxGTf1Ccg
2NJjgs+t/WR5cI1T5OFXSwORUwSUVB4qHtn6kl7hv8WU6fVvO39KoL6TMTYtiw8g
0e05xatQnEffMf/zNmA6Qa+2Qn8N6qCjDRu4nXbRJmhc3FzhvDruigGGQ0vOc/oo
UImFeoEIe489l4OcM3D3fo4MagMyK37Tm/XyvcheJiCEcWvm7cFfCjF870iIl398
SIQ447RqrGU5B6zZ+2eWeYyXsWGVzStMigCKwqgqb1HbnYyzimyxEq+o0rkm5XnW
/GS/hPAZz9tpVHjooIOw
=aRoq
-----END PGP SIGNATURE-----

--nextPart2262514.bnrsm7mbKX--

