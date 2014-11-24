Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 24 Nov 2014 15:56:06 +0100
Message-ID: <5961070.CapjBEeMcY@prime>
In-Reply-To: <1410068560-7829-5-git-send-email-linus.luessing@web.de>
References: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
 <1410068560-7829-5-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6537178.jutksSToHc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv9 4/4] batman-adv: Forward IGMP/MLD
	reports to selected querier (only)
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


--nextPart6537178.jutksSToHc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

On Sunday 07 September 2014 07:42:40 Linus L=C3=BCssing wrote:
> With this patch IGMP or MLD reports are only forwarded to the selecte=
d
> IGMP/MLD querier as RFC4541 suggests.
>=20
> This is necessary to avoid multicast packet loss in bridged scenarios=
:
> An IGMPv2/MLDv1 querier does not actively join the multicast group th=
e
> reports are sent to. Because of this, this leads to snooping
> bridges/switches not being able to learn of multicast listeners in th=
e
> mesh and wrongly shutting down ports for multicast traffic to the mes=
h.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  compat.h         |    7 +
>  multicast.c      |  375
> +++++++++++++++++++++++++++++++++++++++++++++++++++++- multicast.h   =
   | =20
>  8 ++
>  soft-interface.c |   11 ++
>  types.h          |    4 +
>  5 files changed, 399 insertions(+), 6 deletions(-)

As a general note: This patch adds ~400 lines for mainly processing IGM=
P/MLD=20
stuff, right? Shouldn't this kind of IP/IGMP/MLD report detection and=20=

memorizing the Querier rather go in the bridge code instead of batman-a=
dv, or=20
is there any functionality there already? IMHO the preferred position w=
ould be=20
the bridge code since its more general/used by more people on one hand,=
 and=20
does not bloat batman-adv on the other hand. :)

Could you give us some comments regarding who should do IGMP/MLD proces=
sing in=20
the kernel so we are prepared for these kind of upstream questions?

Just some small notes regarding the code below:


> [...]
> --- a/multicast.c
> +++ b/multicast.c
> [...]
> @@ -512,10 +515,247 @@ out:
>  }
>=20
>  /**
> + * batadv_mcast_is_valid_igmp -=E2=80=AFcheck for an IGMP packet
> + * @skb: the IPv4 packet to check
> + *
> + * Checks whether a given IPv4 packet is a valid IGMP packet and if =
so
> + * sets the skb transport header accordingly.
> + *
> + * The caller needs to ensure the correct setup of the skb network h=
eader.
> + * This call might reallocate skb data.
> + */
> +static bool batadv_mcast_is_valid_igmp(struct sk_buff *skb)
> +{
> +=09struct iphdr *iphdr;
> +=09unsigned int len =3D skb_network_offset(skb) + sizeof(*iphdr);
> +
> +=09if (!pskb_may_pull(skb, len))
> +=09=09return false;
> +
> +=09iphdr =3D ip_hdr(skb);
> +
> +=09if (iphdr->ihl < 5 || iphdr->version !=3D 4)
> +=09=09return false;
> +
> +=09if (ntohs(iphdr->tot_len) < ip_hdrlen(skb))
> +=09=09return false;
> +
> +=09len +=3D ip_hdrlen(skb) - sizeof(*iphdr);
> +=09skb_set_transport_header(skb, len);
> +
> +=09if (iphdr->protocol !=3D IPPROTO_IGMP)
> +=09=09return false;
> +
> +=09/* TODO:=E2=80=AFverify checksums */
> +
> +=09if (!pskb_may_pull(skb, len + sizeof(struct igmphdr)))
> +=09=09return false;
> +
> +=09/* RFC2236+RFC3376 (IGMPv2+IGMPv3) require the multicast link lay=
er
> +=09 * all-systems destination addresses (224.0.0.1) for general quer=
ies
> +=09 */
> +=09if (igmp_hdr(skb)->type =3D=3D IGMP_HOST_MEMBERSHIP_QUERY &&
> +=09    !igmp_hdr(skb)->group &&
> +=09    ip_hdr(skb)->daddr !=3D htonl(INADDR_ALLHOSTS_GROUP))
> +=09=09return false;
> +
> +=09return true;
> +}
> +
> +/**
> + * batadv_mcast_is_report_ipv4 -=E2=80=AFcheck for IGMP reports (and=
 queries)
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the ethernet frame destined for the mesh
> + * @orig: if IGMP report:=E2=80=AFto be set to the querier to forwar=
d the skb to
> + *
> + * Checks whether the given frame is an IGMP report and if so sets t=
he
> + * orig pointer to the originator of the selected IGMP querier if on=
e
> exists + * and returns true. Otherwise returns false.
> + *
> + * If the packet is a general IGMP query instead then we delete the
> memorized, + * foreign IGMP querier (if one exists): We became the se=
lected
> querier and + * therefore do not need to forward reports into the mes=
h.
> + *
> + * This call might reallocate skb data.
> + */
> +static bool batadv_mcast_is_report_ipv4(struct batadv_priv *bat_priv=
,
> +=09=09=09=09=09struct sk_buff *skb,
> +=09=09=09=09=09struct batadv_orig_node **orig)
> +{
> +=09struct batadv_mcast_querier_state *querier;
> +=09struct batadv_orig_node *orig_node;
> +
> +=09if (!batadv_mcast_is_valid_igmp(skb))
> +=09=09return false;
> +
> +=09querier =3D &bat_priv->mcast.querier_ipv4;
> +
> +=09switch (igmp_hdr(skb)->type) {
> +=09case IGMP_HOST_MEMBERSHIP_REPORT:
> +=09case IGMPV2_HOST_MEMBERSHIP_REPORT:
> +=09case IGMPV3_HOST_MEMBERSHIP_REPORT:
> +=09=09rcu_read_lock();
> +=09=09orig_node =3D rcu_dereference(querier->orig);
> +=09=09if (orig_node && atomic_inc_not_zero(&orig_node->refcount)) {
> +=09=09=09/* TODO: include multicast routers via MRD (RFC4286) */
> +=09=09=09batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +=09=09=09=09   "Redirecting IGMP Report to %pM\n",
> +=09=09=09=09   orig_node->orig);
> +=09=09=09*orig =3D orig_node;
> +=09=09}
> +=09=09rcu_read_unlock();
> +
> +=09=09return true;
> +=09case IGMP_HOST_MEMBERSHIP_QUERY:
> +=09=09/* RFC4541, section 2.1.1.1.b) says:
> +=09=09 * ignore general queries from 0.0.0.0
> +=09=09 */
> +=09=09if (!ip_hdr(skb)->saddr || igmp_hdr(skb)->group)
> +=09=09=09break;

Why do we break here if group !=3D 0? This looks wrong, maybe you meant=
 && or=20
group !=3D 0?

> [...]
> diff --git a/soft-interface.c b/soft-interface.c
> index d4d892c..0f5fb30 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -183,6 +183,7 @@ static int batadv_interface_tx(struct sk_buff *sk=
b,
>  =09if (atomic_read(&bat_priv->mesh_state) !=3D BATADV_MESH_ACTIVE)
>  =09=09goto dropped;
>=20
> +=09skb_set_network_header(skb, ETH_HLEN);
>  =09soft_iface->trans_start =3D jiffies;
>  =09vid =3D batadv_get_vid(skb, 0);
>  =09ethhdr =3D eth_hdr(skb);
> @@ -397,7 +398,9 @@ void batadv_interface_rx(struct net_device *soft_=
iface,
>  =09/* skb->dev & skb->pkt_type are set here */
>  =09if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
>  =09=09goto dropped;
> +
>  =09skb->protocol =3D eth_type_trans(skb, soft_iface);
> +=09skb_reset_network_header(skb);

Why do we need that header stuff here? And there is an extra newline to=
o ... If=20
you need that for the multicast stuff better move it there, otherwise i=
t is set=20
for every packet ...

Cheers,
   Simon
--nextPart6537178.jutksSToHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlRzRwYACgkQrzg/fFk7axYCoQCgx6XBTPiJ0JExnB8jH2EVtBWo
Rj4An17LRUuY5f3N3i7EVLiodCebOMbi
=THYC
-----END PGP SIGNATURE-----

--nextPart6537178.jutksSToHc--

