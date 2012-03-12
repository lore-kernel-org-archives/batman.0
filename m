Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120311215039.GA26577@pandem0nium>
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<1331417873-19354-5-git-send-email-lindner_marek@yahoo.de>
	<20120311215039.GA26577@pandem0nium>
Date: Mon, 12 Mar 2012 08:24:36 +0100
Message-ID: <CAG7VhQSgki4O-nryuRR_-3SF7n1AKBoa70zGBH9-89KTdw-vQA@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: avoid temporary routing
 loops by being strict on forwarded OGMs
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>

Hi,
I agree with this patch, actually it should solve the loop problem as it is=
 very
similar to the proposed modification in my thesis.

In this way I think it is not necessary a global window to average TQ value=
s
but only the latest value can be sufficient. Doing this can be re-implement=
ed
a mechanism to improve OGM reliability sending old TQ ant TTL (and also
sequence number) of the current best router if for example 2 OGM are missin=
g.

Regards.

2012/3/11 Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>:
> Hey there,
>
> I've tested this patch on my old ring setup which used to create temporar=
y
> routing loops, and this patch improved the situation.
>
> Feel free to add:
>
> Tested-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>
> On Sun, Mar 11, 2012 at 06:17:53AM +0800, Marek Lindner wrote:
>> batman-adv would forward OGMs from non-besthops while replacing the the =
TQ
>> and TTL values with the values from the best hop. In certain corner case=
s
>> this leads to a temporary routing loop.
>> This patch changes this behavior: Only packets from best next hops are
>> forwarded - TQ and TTL values won't be replaced anymore. However, the pr=
otocol
>> needs to rebroadcast OGMs from single hop neighbors regardless of whethe=
r or
>> not they are the best hop. To handle this case a new flag is introduced =
to
>> alert neighboring nodes about the forwarded OGM that is not from my best
>> next hop. It is to be discarded by all nodes except for the one originat=
ing
>> the OGM.
>>
>> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
>> ---
>> =A0bat_iv_ogm.c | =A0 61 ++++++++++++++++++++++++++++++-----------------=
----------
>> =A0packet.h =A0 =A0 | =A0 =A01 +
>> =A02 files changed, 33 insertions(+), 29 deletions(-)
>>
>> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
>> index 1e92e38..85617c4 100644
>> --- a/bat_iv_ogm.c
>> +++ b/bat_iv_ogm.c
>> @@ -507,11 +507,10 @@ static void bat_iv_ogm_forward(struct orig_node *o=
rig_node,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct =
ethhdr *ethhdr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct batman=
_ogm_packet *batman_ogm_packet,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool is_singl=
e_hop_neigh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool is_from_be=
st_next_hop,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hard_i=
face *if_incoming)
>> =A0{
>> =A0 =A0 =A0 struct bat_priv *bat_priv =3D netdev_priv(if_incoming->soft_=
iface);
>> - =A0 =A0 struct neigh_node *router;
>> - =A0 =A0 uint8_t in_tq, in_ttl, tq_avg =3D 0;
>> =A0 =A0 =A0 uint8_t tt_num_changes;
>>
>> =A0 =A0 =A0 if (batman_ogm_packet->header.ttl <=3D 1) {
>> @@ -519,41 +518,31 @@ static void bat_iv_ogm_forward(struct orig_node *o=
rig_node,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 router =3D orig_node_get_router(orig_node);
>> + =A0 =A0 if (!is_from_best_next_hop) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /**
>> + =A0 =A0 =A0 =A0 =A0 =A0 * Mark the forwarded packet when it is not com=
ing from our best
>> + =A0 =A0 =A0 =A0 =A0 =A0 * next hop. We still need to forward the packe=
t for our neighbor
>> + =A0 =A0 =A0 =A0 =A0 =A0 * link quality detection to work in case the p=
acket originated
>> + =A0 =A0 =A0 =A0 =A0 =A0 * from a single hop neighbor. Otherwise we can=
 simply drop the
>> + =A0 =A0 =A0 =A0 =A0 =A0 * ogm.
>> + =A0 =A0 =A0 =A0 =A0 =A0 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_single_hop_neigh)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 batman_ogm_packet->flags |=3D =
NOT_BEST_NEXT_HOP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>>
>> - =A0 =A0 in_tq =3D batman_ogm_packet->tq;
>> - =A0 =A0 in_ttl =3D batman_ogm_packet->header.ttl;
>> =A0 =A0 =A0 tt_num_changes =3D batman_ogm_packet->tt_num_changes;
>>
>> =A0 =A0 =A0 batman_ogm_packet->header.ttl--;
>> =A0 =A0 =A0 memcpy(batman_ogm_packet->prev_sender, ethhdr->h_source, ETH=
_ALEN);
>>
>> - =A0 =A0 /* rebroadcast tq of our best ranking neighbor to ensure the r=
ebroadcast
>> - =A0 =A0 =A0* of our best tq value */
>> - =A0 =A0 if (router && router->tq_avg !=3D 0) {
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* rebroadcast ogm of best ranking neighbor as=
 is */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!compare_eth(router->addr, ethhdr->h_sourc=
e)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 batman_ogm_packet->tq =3D rout=
er->tq_avg;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (router->last_ttl)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 batman_ogm_pac=
ket->header.ttl =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 router->last_ttl - 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 tq_avg =3D router->tq_avg;
>> - =A0 =A0 }
>> -
>> - =A0 =A0 if (router)
>> - =A0 =A0 =A0 =A0 =A0 =A0 neigh_node_free_ref(router);
>> -
>> =A0 =A0 =A0 /* apply hop penalty */
>> =A0 =A0 =A0 batman_ogm_packet->tq =3D hop_penalty(batman_ogm_packet->tq,=
 bat_priv);
>>
>> =A0 =A0 =A0 bat_dbg(DBG_BATMAN, bat_priv,
>> - =A0 =A0 =A0 =A0 =A0 =A0 "Forwarding packet: tq_orig: %i, tq_avg: %i, t=
q_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 in_tq, tq_avg, batman_ogm_packet->tq, in_ttl -=
 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 batman_ogm_packet->header.ttl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Forwarding packet: tq: %i, ttl: %i\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 batman_ogm_packet->tq, batman_ogm_packet->head=
er.ttl);
>>
>> =A0 =A0 =A0 batman_ogm_packet->seqno =3D htonl(batman_ogm_packet->seqno)=
;
>> =A0 =A0 =A0 batman_ogm_packet->tt_crc =3D htons(batman_ogm_packet->tt_cr=
c);
>> @@ -949,6 +938,7 @@ static void bat_iv_ogm_process(const struct ethhdr *=
ethhdr,
>> =A0 =A0 =A0 int is_my_addr =3D 0, is_my_orig =3D 0, is_my_oldorig =3D 0;
>> =A0 =A0 =A0 int is_broadcast =3D 0, is_bidirectional;
>> =A0 =A0 =A0 bool is_single_hop_neigh =3D false;
>> + =A0 =A0 bool is_from_best_next_hop =3D false;
>> =A0 =A0 =A0 int is_duplicate;
>> =A0 =A0 =A0 uint32_t if_incoming_seqno;
>>
>> @@ -1070,6 +1060,13 @@ static void bat_iv_ogm_process(const struct ethhd=
r *ethhdr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (batman_ogm_packet->flags & NOT_BEST_NEXT_HOP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_BATMAN, bat_priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Drop packet: ignoring all pac=
kets not forwarded from "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "the best next hop (sender: %p=
M)\n", ethhdr->h_source);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 orig_node =3D get_orig_node(bat_priv, batman_ogm_packet->ori=
g);
>> =A0 =A0 =A0 if (!orig_node)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> @@ -1094,6 +1091,10 @@ static void bat_iv_ogm_process(const struct ethhd=
r *ethhdr,
>> =A0 =A0 =A0 if (router)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 router_router =3D orig_node_get_router(route=
r->orig_node);
>>
>> + =A0 =A0 if ((router && router->tq_avg !=3D 0) &&
>> + =A0 =A0 =A0 =A0 (compare_eth(router->addr, ethhdr->h_source)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 is_from_best_next_hop =3D true;
>> +
>> =A0 =A0 =A0 /* avoid temporary routing loops */
>> =A0 =A0 =A0 if (router && router_router &&
>> =A0 =A0 =A0 =A0 =A0 (compare_eth(router->addr, batman_ogm_packet->prev_s=
ender)) &&
>> @@ -1144,7 +1145,8 @@ static void bat_iv_ogm_process(const struct ethhdr=
 *ethhdr,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* mark direct link on incoming interface */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_iv_ogm_forward(orig_node, ethhdr, batman=
_ogm_packet,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_sing=
le_hop_neigh, if_incoming);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_sing=
le_hop_neigh, is_from_best_next_hop,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if_inco=
ming);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_BATMAN, bat_priv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Forwarding packet: rebroadc=
ast neighbor packet with direct link flag\n");
>> @@ -1167,7 +1169,8 @@ static void bat_iv_ogm_process(const struct ethhdr=
 *ethhdr,
>> =A0 =A0 =A0 bat_dbg(DBG_BATMAN, bat_priv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Forwarding packet: rebroadcast originator p=
acket\n");
>> =A0 =A0 =A0 bat_iv_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_single_hop_neigh, if=
_incoming);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_single_hop_neigh, is=
_from_best_next_hop,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if_incoming);
>>
>> =A0out_neigh:
>> =A0 =A0 =A0 if ((orig_neigh_node) && (!is_single_hop_neigh))
>> diff --git a/packet.h b/packet.h
>> index 02b0c87..3c4c533 100644
>> --- a/packet.h
>> +++ b/packet.h
>> @@ -47,6 +47,7 @@ enum bat_subtype {
>> =A0#define COMPAT_VERSION 14
>>
>> =A0enum batman_iv_flags {
>> + =A0 =A0 NOT_BEST_NEXT_HOP =A0 =3D 1 << 3,
>> =A0 =A0 =A0 PRIMARIES_FIRST_HOP =3D 1 << 4,
>> =A0 =A0 =A0 VIS_SERVER =A0 =A0 =A0 =A0 =A0=3D 1 << 5,
>> =A0 =A0 =A0 DIRECTLINK =A0 =A0 =A0 =A0 =A0=3D 1 << 6
>> --
>> 1.7.9.1
>>
>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk9dHi8ACgkQrzg/fFk7axbJ+QCg5TaIOetOvSoTjr5vHCHr4k7M
> /6YAoKC76tkASLbl9TuYFKqLTIHXRK2s
> =3DJNhg
> -----END PGP SIGNATURE-----
>



--=20
Daniele Furlan
