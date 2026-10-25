Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3B606A31B
	for <batman@archiver.kernel.org>; Sun, 25 Oct 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=KWVS1S8A
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 553CC843B2
	for <batman@archiver.kernel.org>; Sun, 25 Oct 2026 10:49:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792921762;
 b=TsFMbJgQWtWOPZNEcT02iWnYMFHt0msE0CIh6zvA8Q8XUZegMP2qWDntdRKxxQU74RSeN
 yYgBMbSzBWT03Si766BAwRno28MVwWf7oLFMWS6fgDtwuql9mrAyprSI9vXBXMUcAA8DUsw
 haUj9gpdgFFNXliCn/aJR8BAWKhdX4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792921762; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tsK9suMRg7amiMSt6y6vzraJaaHLY+OKb0W4h7neoqk=;
 b=T9HMPP9lZw9bJKVonIVLS969IY66cSxb1s23A3A6lkJd27A4SQPNwu5DgSuGQTvzHOyUx
 XCtAz9cada5z5gH9nSCejI42+vU4ukreS/yi2duM3o0LPshPM+r2Ov6vy2blvmU0KP9ZzRO
 LVzTiJ40uuETPQPG3ByEZ1BQLWejiLE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2D264822B5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 25 Oct 2026 10:48:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792921746;
	b=FTjtGuXvZZqhJA99WgJATDC1mf5u61l6Rs2K1XPpOpTXMdsiV16aH9XPdzYV8+9QAHkVWJ
	iOdoekM5a2uRotdBzKtN7NiCfhqFDnfGm2xGsa57/UQ5VjhrzyYsnTDkiY4yYZkRO2yubA
	SdVZ28UjqNW2nc3S1lrcQSt9AEunE7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792921746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tsK9suMRg7amiMSt6y6vzraJaaHLY+OKb0W4h7neoqk=;
	b=JoNkxGik+ECGlKtJRSjVS65EyP1N4dYa7JBjWdADQzxGjJjoxLIwEjHguralQ7OAoVQy5Q
	0hGNjcLreGz88kCo2UNXnzAy4UpdSdMgSIuHWdcx/hNaXGcDk3Apz8lH0xvG4F2wTEDqdR
	g4Wm/nJAVdxNPpNpYpVb0sMA4jJVHT8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KWVS1S8A;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 463181FD16;
	Sun, 25 Oct 2026 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792921735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsK9suMRg7amiMSt6y6vzraJaaHLY+OKb0W4h7neoqk=;
	b=KWVS1S8AoixHcXy+o8uBbQHr9MpWBDkajIqBnvfvGGBfFlkMDAogsDd/m/4DfMCcCAXqY9
	RqAlrpVrNYFcqbfzDQ473okd6mn0xp4OjHA9RJx6RGgiGReSqWamWvayyOALKDnXP8g2KW
	9+xhMFmqEPTvOW/jRfFrs5EphdNt2xk=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>,
 b.a.t.m.a.n@lists.open-mesh.org
Cc: antonio@mandelbit.com
Subject: Re: [batadv,v14 0/5] batman-adv: increase DAT DHT timeout
Date: Sun, 25 Oct 2026 10:48:51 +0100
Message-ID: <5358904.31r3eYUQgx@sven-desktop>
In-Reply-To: <20261006185037.27163-1-linus.luessing@c0d3.blue>
References: <20261006185037.27163-1-linus.luessing@c0d3.blue>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4990001.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: JSOPFIKULP4GH7MV6YMK54P7EMMXPRYG
X-Message-ID-Hash: JSOPFIKULP4GH7MV6YMK54P7EMMXPRYG
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JSOPFIKULP4GH7MV6YMK54P7EMMXPRYG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart4990001.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: antonio@mandelbit.com
Subject: Re: [batadv,v14 0/5] batman-adv: increase DAT DHT timeout
Date: Sun, 25 Oct 2026 10:48:51 +0100
Message-ID: <5358904.31r3eYUQgx@sven-desktop>
In-Reply-To: <20261006185037.27163-1-linus.luessing@c0d3.blue>
References: <20261006185037.27163-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0

Hi,

please go through the lists of things reported Sashiko
(https://netdev-ai.bots.linux.dev/sashiko/ like). Either write a rebuttal t=
o=20
this mailing list or fix them (when they are valid).

  Critical: 0  High: 0  Medium: 4  Low: 5

  --- Patch [1] batman-adv: move local ARP reply code to subfunctions ---
  [Low] batman-adv: inaccurate kernel-doc for batadv_dat_arp_self_reply()
  [Low] batman-adv: DAT local ARP reply RX_BYTES counts request size with h=
eaders twice

  --- Patch [2] batman-adv: split DAT cache into DAT cache and DAT DHT ---
  [Medium] batman-adv: batadv_dat_init() leaks cache_hash when dht_hash all=
ocation fails
  [Medium] batman-adv: incoming ARP requests no longer answered from DAT ca=
che entries
  [Low] batman-adv: free-slot self-candidate makes DHT_PUT drop a non-displ=
aced remote candidate

  --- Patch [5] batman-adv: avoid superfluous DAT DHT_PUT additions to loca=
l DAT ---
  [Medium] batman-adv: batadv_dat_dht_entry_add() runs full candidate selec=
tion per insert
  [Medium] batman-adv: dat_dht_add_not_candidate counter inflated on select=
ion failure/race
  [Low] batman-adv: wire flags bitmask stored in enum batadv_subtype_flags =
variable
  [Low] batman-adv: typo 'specfic' in new counter kernel-doc


Inline Review:
=2D-- Patch [1]: batman-adv: move local ARP reply code to subfunctions ---
commit 09dfd5b76d0f3b8d56db5de7e0690d47cb2538a3
Author: Linus L=C3=BCssing <linus.luessing@c0d3.blue>

batman-adv: move local ARP reply code to subfunctions

This commit moves the local ARP reply checks and generation out of
batadv_dat_snoop_outgoing_arp_request() into a new helper,
batadv_dat_arp_self_reply(), and moves batadv_dat_arp_create_reply()
earlier in the file. It is described as preparation for reuse in the
DAT cache/DHT split, with no functional change.

> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/dist=
ributed-arp-table.c
> index 0260ed7e828b2..631bdad361782 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c

[ ... ]

> +/**
> + * batadv_dat_arp_self_reply() - (maybe) reply to a local ARP request
> + * @bat_priv: the bat priv with all the mesh interface information
> + * @ip_src: ARP request sender IP (and ARP reply target IP)
> + * @ip_dst: ARP request target IP (and ARP reply sender IP)
> + * @hw_src: Ethernet source and ARP sender MAC of ARP request
> + * @hw_dst: Ethernet destination and ARP target MAC of ARP request

[Severity: Low]
Is this description of hw_dst accurate? The only caller,
batadv_dat_snoop_outgoing_arp_request(), passes the MAC resolved from the
DAT entry:

    u64_mac =3D atomic64_read(&dat_entry->mac_addr);
    u64_to_ether_addr(u64_mac, mac);

    rep =3D batadv_dat_arp_self_reply(bat_priv, ip_src, ip_dst,
                                    hw_src, mac, vid, arp_len);

The Ethernet destination of an ARP request is normally broadcast, and its
ARP target MAC is usually zero, so neither matches what is passed here.

> + * @vid: VLAN identifier (optional, set to zero otherwise)
> + * @arp_len: ARP packet size, including ethernet frame
> + *
> + * If the ARP request target is not a local client and if BLA is
> + * enabled and we have BLA claimed this target then generate and reply
> + * with an ARP reply locally on our mesh interface.

[Severity: Low]
Does this summary match what batadv_bla_check_claim() does? That function
also returns true when bridge_loop_avoidance is disabled, when there is no
primary_if, and when nobody has claimed the address:

    if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
        return ret;

    primary_if =3D batadv_primary_if_get_selected(bat_priv);
    if (!primary_if)
        return ret;

In all of those cases a reply is still built and passed to netif_rx(). The
in-body comment ("If BLA is enabled, only send ARP replies if ...")
describes this correctly, but the kernel-doc summary contradicts it.

> + *
> + * Return: 0 if we transmitted an ARP reply, -ENOMEM if we should have b=
ut
> + * could not create an ARP reply (e.g. due to out-of-memory), -EACCSS
                                                                  ^^^^^^

[Severity: Low]
This isn't a bug, but -EACCSS looks like a typo for -EACCES, which is what
both suppression paths return.

The later batadv_dat_dht_get_self_reply() caller added in this series
relies on this contract, and the typo and the BLA wording remain unchanged
at the end of the series.

> + * otherwise (because the client is local or due to BLA suppression).
> + */

[ ... ]

> @@ -1254,6 +1316,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct b=
atadv_priv *bat_priv,
>               goto out;
> =20
>       vid =3D batadv_dat_get_vid(skb, &hdr_size);
> +     arg_len =3D skb->len + ETH_HLEN + hdr_size;

[Severity: Low]
Does this count the Ethernet and VLAN headers twice?

The caller, batadv_interface_tx(), does pskb_may_pull(skb, ETH_HLEN) and
skb_reset_mac_header(skb) but never pulls the Ethernet header, so
skb->data still points at it here. batadv_arp_get_type() relies on that:

    ethhdr =3D (struct ethhdr *)(skb->data + hdr_size);

So skb->len already includes ETH_HLEN, plus VLAN_HLEN for tagged frames,
and arp_len adds them again. This value is then passed to
batadv_dat_arp_self_reply() and accounted as BATADV_CNT_RX_BYTES for the
injected reply skb.

This problem wasn't introduced by this patch, since the parent commit used
the same skb->len + ETH_HLEN + hdr_size expression. However, the new
kernel-doc describes the parameter as "ARP packet size, including ethernet
frame", which this value does not match. It is also the size of the
request rather than of the reply created by arp_create().

The same arp_len computation is carried through the rest of the series and
is also passed to batadv_dat_dht_get_self_reply() and
batadv_dat_forward_dht_get(), so it is not fixed later on.

> =20
>       type =3D batadv_arp_get_type(bat_priv, skb, hdr_size);

[ ... ]

=2D-- Patch [2]: batman-adv: split DAT cache into DAT cache and DAT DHT ---
commit fb097bd3187273b7cdbbd2182627f3eff6e3b55b
Author: Linus L=C3=BCssing <linus.luessing@c0d3.blue>

batman-adv: split DAT cache into DAT cache and DAT DHT

This commit splits the single DAT hash table into a locally maintained DAT
cache and a separate DAT DHT table, similar to the translation table split.
It adds a self-candidate check so the local node can store DHT_PUT data and
answer DHT_GET requests locally, and adds a new BATADV_CMD_GET_DAT_DHT
netlink dump command.

> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/dist=
ributed-arp-table.c
> index 631bdad361782..7455ae496426c 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c

[ ... ]

> +static bool batadv_dat_cmp_self_candidate(struct batadv_priv *bat_priv,
> +                                       struct batadv_dat_candidate *cand=
s,
> +                                       batadv_dat_addr_t ip_key,
> +                                       batadv_dat_addr_t last_max)
> +{

[ ... ]

> +     last_cand =3D &cands[BATADV_DAT_CANDIDATES_NUM - 1];
> +
> +     /* a free slot? then it is for us */
> +     if (last_cand->type =3D=3D BATADV_DAT_CANDIDATE_NOT_FOUND) {
> +             ret =3D true;
> +             goto out;
> +     }

[Severity: Low]
This returns the same true for "filled an empty slot" as for "displaced
the last remote candidate by distance". Can callers tell those two cases
apart?

In this patch it is harmless, since batadv_dat_forward_data() still sends
to every remote candidate. But the later patch in the series, "batman-adv:
avoid superfluous DAT DHT_PUT if self-candidate", adds this to
batadv_dat_forward_dht_put():

    if (self_is_candidate) {
        for (i =3D BATADV_DAT_CANDIDATES_NUM - 1; i >=3D 0; i--) {
            if (cands[i].type !=3D BATADV_DAT_CANDIDATE_ORIG)
                continue;

            batadv_orig_node_put(cands[i].orig_node);
            cands[i].type =3D BATADV_DAT_CANDIDATE_NOT_FOUND;
            cands[i].orig_node =3D NULL;
            break;
        }
    }

With only one remote originator, batadv_choose_next_candidate() fills
cands[0] and leaves cands[1..2] as NOT_FOUND. The free slot branch here
returns true, and the loop above then clears cands[0]. No DHT_PUT is sent
at all, even though that remote node is a legitimate candidate. With two
remote originators, one of them is dropped and the entry is replicated on
two nodes instead of three.

Would it make sense for batadv_dat_cmp_self_candidate() to report whether
a remote candidate was actually displaced, so the later patch only drops a
candidate in that case?

[ ... ]

> @@ -966,37 +1246,77 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct =
batadv_priv *bat_priv,

[ ... ]

> +int batadv_dat_init(struct batadv_priv *bat_priv)
> +{
> +     int ret;
> +
> +     ret =3D batadv_dat_cache_hash_init(bat_priv);
> +     if (ret < 0)
> +             return ret;
> +
> +     ret =3D batadv_dat_dht_hash_init(bat_priv);
> +     if (ret < 0)
> +             return ret;

[Severity: Medium]
Does this leak bat_priv->dat.cache_hash when batadv_dat_dht_hash_init()
fails?

batadv_hash_new() uses GFP_ATOMIC, so the second allocation can fail after
the first one succeeded. The caller does not clean up DAT on this path:

net/batman-adv/main.c:batadv_mesh_init() {
    ...
err_dat:
        batadv_bla_free(bat_priv);
    ...
}

The unwind only frees BLA, TT, BATMAN V and originator state, and never
calls batadv_dat_free(). Before this patch DAT had a single allocation, so
nothing was left behind on failure.

The same sequence is still present at the end of the series. Should this
call batadv_dat_hash_free(&bat_priv->dat.cache_hash) before returning?

[ ... ]

> @@ -1402,9 +1771,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct b=
atadv_priv *bat_priv,
> =20
>       batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REQUE=
ST");
> =20
> -     batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
> +     batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
> =20
> -     dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
> +     dat_entry =3D batadv_dat_dht_entry_find(bat_priv, ip_dst, vid);
>       if (!dat_entry)
>               goto out;

[Severity: Medium]
Is this narrowing of the reply source intended?

Before this patch the lookup used the single table that held every snooped
mapping. Now only dht_hash entries can produce a BATADV_P_DAT_CACHE_REPLY.
Mappings that only go into cache_hash are no longer used to answer remote
requests. That includes mappings from:

  batadv_dat_snoop_incoming_dhcp_ack()
  the ip_src of incoming and outgoing ARP requests
  broadcast ARP replies (is_dht_put =3D=3D false)
  non-PUT unicast ARP replies

This lookup is reached for DHT_GET unicast packets via
batadv_recv_unicast_packet() and for broadcast ARP requests via
batadv_recv_bcast_packet().

=46or example, a DHT candidate whose local client issued ARP requests used =
to
answer DHT_GETs for that client. Now it can only do so if it also received
a DHT_PUT for that IP. Requests that used to be answered from the cache now
fall back to the mesh-wide broadcast, so ARP resolution still works but DAT
suppresses fewer floods.

The commit message describes the split as being for monitoring and
debugging and for future differing properties, and does not mention this
behavior change. The later patches in the series ("batman-adv: increase DAT
DHT timeout", "batman-adv: avoid superfluous DAT DHT_PUT if
self-candidate" and "batman-adv: avoid superfluous DAT DHT_PUT additions to
local DAT") leave this lookup unchanged and reduce DHT population further.

Should this also consult cache_hash, or should the commit message document
the change?

=2D-- Patch [5]: batman-adv: avoid superfluous DAT DHT_PUT additions to loc=
al DAT ---
commit ec02a0f413dd03663ce3423d2702fa902d3f318d
Author: Linus L=C3=BCssing <linus.luessing@c0d3.blue>

batman-adv: avoid superfluous DAT DHT_PUT additions to local DAT

This adds NO_SRC/NO_DST flags to the unicast 4addr header of DHT_PUT
messages, so a receiving node only adds the sender or the target MAC/IP
pair to its local DHT. It also adds a self-candidate check with a new
counter and new ethtool counters for received DHT_PUTs.

> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/dist=
ributed-arp-table.c
> index 0acb129cf4c5f..3c96c42153685 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c

[ ... ]

> @@ -562,6 +565,20 @@ static inline void
>  batadv_dat_dht_entry_add(struct batadv_priv *bat_priv, __be32 ip,
>                        u8 *mac_addr, unsigned short vid)
>  {
> +     /* Happens if a new node just beat us as a candidate, an old node
> +      * does not have the more specific candidate selection enhancements=
 yet
> +      * or if future protocol enhancements, which this node does not have
> +      * yet, added new/other candidate selections. For compatibility rea=
sons
> +      * do not bail out here.
> +      */
> +     if (!batadv_dat_dht_check_self_is_candidate(bat_priv, ip, vid)) {

[Severity: Medium]
Is it worth running a full candidate selection on every DHT insert here?
The result only feeds a counter and a debug message, and the entry is
added either way.

batadv_dat_dht_check_self_is_candidate() calls
batadv_dat_select_candidates(), which does:

    res =3D kmalloc_objs(*res, BATADV_DAT_CANDIDATES_NUM, GFP_ATOMIC);
    ...
    for (select =3D 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
        batadv_choose_next_candidate(bat_priv, res, select, ip_key,
                                     &last_max);

Each batadv_choose_next_candidate() round walks the whole orig_hash with
kref get/put on the orig_nodes, and batadv_dat_cmp_self_candidate() then
does a primary_if get/put.

On the RX side this runs in softirq context:

batadv_recv_unicast_packet()
  batadv_dat_snoop_incoming_arp_reply()
    batadv_dat_dht_entry_add()
      batadv_dat_dht_check_self_is_candidate()
        batadv_dat_select_candidates()

A DHT_PUT with flags =3D=3D 0 (sent by every legacy node, and by any mesh
peer that chooses to) sets both is_dht_put_src and is_dht_put_dst. That
means two allocations and 6 orig_hash walks per received packet, where
previously this was only a hash lookup and insert. There is no rate
limiting, and the cost scales with the size of the mesh.

On the TX side, batadv_dat_forward_dht_put() already computed
self_is_candidate and only calls batadv_dat_dht_entry_add() when it is
true:

    if (self_is_candidate)
        batadv_dat_dht_entry_add(bat_priv, ip, hw_addr, vid);

The callee then recomputes the same selection. So every snooped outgoing
ARP reply (batadv_dat_snoop_outgoing_arp_reply()) and DHCP ACK
(batadv_dat_put_dhcp()) does this work twice.

Could the known result be passed down from the TX caller, and the
RX-side recheck be gated (for example behind the debug log level) or
dropped?

The commit message describes only the new wire flag. It doesn't mention
this check, its cost, or the new ethtool counters (dat_put_src_rx,
dat_put_dst_rx, dat_put_noflags_rx, dat_dht_add_not_candidate). Should
those be described there as well?

> +             batadv_inc_counter(bat_priv,
> +                                BATADV_CNT_DAT_DHT_ADD_NOT_CANDIDATE);

[Severity: Medium]
Can this counter be bumped when we actually are a candidate?

batadv_dat_select_candidates() returns NULL without writing
*self_is_candidate when bat_priv->orig_hash is NULL or when the
GFP_ATOMIC allocation fails:

    if (!bat_priv->orig_hash)
        return NULL;

    res =3D kmalloc_objs(*res, BATADV_DAT_CANDIDATES_NUM, GFP_ATOMIC);
    if (!res)
        return NULL;

batadv_dat_dht_check_self_is_candidate() initialises self_is_candidate
to false and returns it unchanged. That makes a failure look the same as
a genuine "not a candidate" result. batadv_dat_cmp_self_candidate() also
yields false when batadv_primary_if_get_selected() returns NULL.

On the TX path there is also a window between the two selections.
batadv_dat_forward_dht_put() has seen self_is_candidate =3D=3D true. The
recheck in batadv_dat_dht_entry_add() then runs in separate RCU
sections. A concurrent orig_hash add or purge, or a primary_if change,
can make the second answer differ from the first.

In all of these cases the counter is incremented and "although we are
not a candidate" is logged. Memory pressure, which the RX path above can
help to cause, and benign races would both inflate
dat_dht_add_not_candidate. Would that make it unreliable as a diagnostic
for candidate selection mismatches?

> +             batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +                        "Adding %pI4 %pM (vid: %d), although we are not =
a candidate\n",
> +                        &ip, mac_addr, batadv_print_vid(vid));
> +     }
> +
>       batadv_dat_entry_add(bat_priv, bat_priv->dat.dht_hash, ip, mac_addr,
>                            vid, "dht");
>  }

[ ... ]

> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 5cf26e8b3257a..8dd4094d134bd 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -1045,8 +1045,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
>       struct batadv_orig_node *orig_node_gw =3D NULL;
>       struct batadv_orig_node *orig_node =3D NULL;
>       int hdr_size =3D sizeof(*unicast_packet);
> +     enum batadv_subtype_flags flags;

[Severity: Low]
This isn't a bug, but should flags be a u8 rather than
enum batadv_subtype_flags?

It holds the raw on-wire byte. That can be 0x03 or contain unknown future
bits, and neither is a valid enumerator. It is then passed as u8 to
batadv_dat_inc_counter(), while the send path uses int for the same
value.

>       enum batadv_subtype subtype;
> -     bool is_dht_put =3D false;
> +     bool is_dht_put_src =3D false;
> +     bool is_dht_put_dst =3D false;

[ ... ]

> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index 045727c3adc08..68b753bb32f6c 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -975,11 +975,35 @@ enum batadv_counters {
>       /** @BATADV_CNT_DAT_PUT_RX: received dht PUT traffic packet counter=
 */
>       BATADV_CNT_DAT_PUT_RX,
> =20
> +     /**
> +      * @BATADV_CNT_DAT_PUT_SRC_RX: received source-specfic dht PUT traf=
fic

[Severity: Low]
Typo: specfic -> specific.

> +      *  packet counter
> +      */
> +     BATADV_CNT_DAT_PUT_SRC_RX,
> +
> +     /**
> +      * @BATADV_CNT_DAT_PUT_DST_RX: received destination-specfic dht PUT

[Severity: Low]
Same typo here: specfic -> specific.

> +      *  traffic packet counter
> +      */
> +     BATADV_CNT_DAT_PUT_DST_RX,

[ ... ]

--nextPart4990001.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCat3QgwAKCRBND3cr0xT1
y2Q4AP9lnIsFOgQm24WGc4miBP3RCEOYCRI9U8mH6z57zHTcAgEAmnODM14GH9ea
+U97xiCMKHc4BDpOjb+HoDVZ7GJ8WQE=
=1+Jz
-----END PGP SIGNATURE-----

--nextPart4990001.LvFx2qVVIh--



