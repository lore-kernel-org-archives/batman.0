Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E52C001B0
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 15:57:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 966AD831C4
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 17:57:33 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692028653;
 b=kZPlu3qemr4OLxVS3NwhRMzdB5I6zGl3y6y8/iCbiIxgULmX2nVvXEU8IhfMVm4xfva4t
 8LNY9ZNwbGpBNHjypAyn7mqnu2HlV91/XqCltjM03whv6tuxn6emCqYGG0lTRf1yRgpwMcD
 +D+SCTG6JiwG7wWGzqBqwsVgUS2NECc=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692028653; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UfPoVZAIKIoxNzmHLbgkmpLilJjLfe0hhsXC1pRIA3g=;
 b=rEQOn3VujMHsMICuFuX4rsHTPNpAXjiaVpSxJukqSC6MZudkdFkxczvAMBjOoD4Lb4ii1
 Mz/mDh+FQ8QaLeJT7ccknPCxIDml4mKZTSTP0GmOzA1HeM+HctbmDFwRACqVIKnU/QI5l6M
 GnhUtHf49kGs4B4bWTvOLfaPz/eV/gc=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9434980423
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Aug 2023 17:56:57 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692028617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UfPoVZAIKIoxNzmHLbgkmpLilJjLfe0hhsXC1pRIA3g=;
	b=rC7pN6I+RThr0KyDsUR+A/gahD2M4hoerypvfLsxNvEKgRv7pzVHCZ7V+Hw+zA0FSonnMJ
	O4QSZQyXBpJd7oaU4m+rRhhHfY5wv4LIiQlfwgZOnJy/NcMfHa/yLJ8RHu9EGWz7qeXMfC
	v36Y3/iRCCb0I5YZjaD8k5IKwsMqG64=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=lQslGEu2;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692028617; a=rsa-sha256;
	cv=pass;
	b=m71plLtKqk7lHzcvb9BxypBW62fLY8+AR6T2qI/9KNlT9+A7dqoaU8oWiBtTRLOjyI2c/0
	IpvCH2o29WI+CoPhW8Yffoxlqmv+YETEa58c9V8GvQ9wWYm9v+GaaTH+pwgZ7clOBA17KL
	E1rqZMFEnktzOdiWLlPZHAi65h8rsNc=
Received: from prime.localnet
 (p200300c5970e8AD8a82608f38C359cbd.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:8ad8:a826:8f3:8c35:9cbd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id AEBBBFB5B0;
	Mon, 14 Aug 2023 17:56:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692028616;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfPoVZAIKIoxNzmHLbgkmpLilJjLfe0hhsXC1pRIA3g=;
	b=lQslGEu2EB2zuBD4H5p4JVe+yGTgPxeelWm99fUqv7e4741Emrl67VaT2PCzHAJJmjZb8C
	ZYgGqMOMq5Ir35apxlpGmYaq026n1oGCGgNrdt0mDbeYIwy2CslmtzVK4V53od2IOKVUzX
	V/n067qDHj6giPBMbuvaF6Rw8d2aJp9O0fMnMzGARDNWbFVBlDBhb1aRGWuSehwnMMwtAl
	SltX3VINhQvw9JqkclyDGvqLOjpqPb/Ct+G/s5F9XE3KnBJad/V2pAFwXzHiwLmhbRj1Xv
	ahgHrcG3H/dbcwyycewe6LzrXTvbIO8EvumRDXDNA9noq1ZoObdsgJaqGYPXwg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 3/3] batman-adv: mcast: shrink tracker packet after scrubbing
Date: Mon, 14 Aug 2023 17:56:56 +0200
Message-ID: <1930229.QkHrqEjB74@prime>
In-Reply-To: <20230720043556.12163-4-linus.luessing@c0d3.blue>
References: 
 <20230720043556.12163-1-linus.luessing@c0d3.blue>
 <20230720043556.12163-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4683452.8F6SAcFxjW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692028617;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfPoVZAIKIoxNzmHLbgkmpLilJjLfe0hhsXC1pRIA3g=;
	b=yqlbfGS2IqJpQvrTf4bqYG/x/6+dIySfgkG4b/iuGwrXfkBfaMhEXw2gZiw5HeyoQxReoc
	UZv+3hsHmspxcnh3LUa+CZ5TWnO7SymZW4Qrdo3aAthRx3f6vwjWjkNgDPrxzPLMhme/rH
	tutLG0uqwX3rt2b+mLCEwfoEUSGeaTy/tDAl2FvU+F+kFUcEJKJ2KmxiGJvApjKOnzf/Ub
	gFPlocERzSJjELcszwtIbPayky12Z3fuBWrQkIyq5S07lL2hJCUCOIJ18+NOxlx7Z5Hpxl
	gs2vitJ7toA5ypNK0ED19vwFa1b8diSQViqWWIz1CcFuYCXOOMAv7iTEhPKZgw==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692028617; a=rsa-sha256;
	cv=none;
	b=l2AKx/PK/5UaJZnBgM6KxyLnyvQYqGt9rnled2PyaTj323W7itJwn/jFKd0/YZSqEeUXNIviDiVzKID91FPtD1fik2SGsg/orBFl0XVLjMPxPt29cn/PCH/yZzcAbCzPpyldaa8i8vPYPIcVPaIKn7QPvysAljnVMv9dSpQXZiBjykzT7NrB9CDdb8ODXdpKXPvboGBCv83TsR25QNr1Ep5/EFnKRQ3+2jkL3v+OgdFCB366Tbej1gIS2is8PZApcQFhKNciLRGSYV0YVRXJ8V4NakP2p4E58PT31wXF6NtrajJ1uRl63/VrZB+HqyUYAtFiTt2tvujdiqFioVWvMg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: D6RZ5OTQFPNVL5N5O4YRZSFAVUOQSF2I
X-Message-ID-Hash: D6RZ5OTQFPNVL5N5O4YRZSFAVUOQSF2I
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D6RZ5OTQFPNVL5N5O4YRZSFAVUOQSF2I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4683452.8F6SAcFxjW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 14 Aug 2023 17:56:56 +0200
Message-ID: <1930229.QkHrqEjB74@prime>
In-Reply-To: <20230720043556.12163-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Thursday, July 20, 2023 6:35:55 AM CEST Linus L=FCssing wrote:
> Remove all zero MAC address entries (00:00:00:00:00:00) from a multicast
> packet's tracker TVLV before transmitting it and update all headers
> accordingly. This way, instead of keeping the multicast packet at a
> constant size throughout its journey through the mesh, it will become
> more lightweight, smaller with every interested receiver on the way and
> on each splitting intersection. Which can save some valuable bandwidth.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast_forw.c | 195 ++++++++++++++++++++++++++++++++
>  1 file changed, 195 insertions(+)
>=20
> diff --git a/net/batman-adv/multicast_forw.c
> b/net/batman-adv/multicast_forw.c index d0f75a63de2a..d7b1aabd4b72 100644
> --- a/net/batman-adv/multicast_forw.c
> +++ b/net/batman-adv/multicast_forw.c
> @@ -712,6 +712,200 @@ batadv_mcast_forw_scrub_dests(struct batadv_priv
> *bat_priv, }
>  }
>=20
> +/**
> + * batadv_mcast_forw_shrink_pack_dests() - pack destinations of a tracker
> TVLV + * @skb: the batman-adv multicast packet to compact destinations in=
 +
> *
> + * Compacts the originator destination MAC addresses in the multicast
> tracker + * TVLV of the given multicast packet. This is done by moving all
> non-zero + * MAC addresses in direction of the skb head and all zero MAC
> addresses in skb + * tail direction, within the multicast tracker TVLV.
> + *
> + * Return: The number of consecutive zero MAC address destinations which
> are + * now at the end of the multicast tracker TVLV.
> + */
> +static int batadv_mcast_forw_shrink_pack_dests(struct sk_buff *skb)
> +{
> +	struct batadv_tvlv_mcast_tracker *mcast_tracker;
> +	u16 num_dests_slot, num_dests_filler;
> +	unsigned char *skb_net_hdr;
> +	u8 *slot, *filler;
> +
> +	skb_net_hdr =3D skb_network_header(skb);
> +	mcast_tracker =3D (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
> +	num_dests_slot =3D ntohs(mcast_tracker->num_dests);
> +
> +	slot =3D (u8 *)mcast_tracker + sizeof(*mcast_tracker);
> +
> +	if (!num_dests_slot)
> +		return 0;
> +
> +	num_dests_filler =3D num_dests_slot - 1;
> +	filler =3D slot + ETH_ALEN;
> +
> +	batadv_mcast_forw_tracker_for_each_dest(slot, num_dests_slot) {
> +		/* find an empty slot */
> +		if (!is_zero_ether_addr(slot))
> +			continue;
> +
> +		/* keep filler ahead of slot */
> +		if (filler <=3D slot) {
> +			num_dests_filler =3D num_dests_slot - 1;
> +			filler =3D slot + ETH_ALEN;
> +		}
> +
> +		/* find a candidate to fill the empty slot */
> +		batadv_mcast_forw_tracker_for_each_dest(filler,
> +							num_dests_filler) {
> +			if (is_zero_ether_addr(filler))
> +				continue;
> +
> +			ether_addr_copy(slot, filler);
> +			eth_zero_addr(filler);
> +			goto cont_next_slot;

goto is redundant, just continue
> +		}
> +
> +		/* could not find a filler, we can stop
> +		 * - and must not advance the slot pointer!
> +		 */
> +		if (!num_dests_filler)
> +			break;
> +

This label can then be removed as well.

I'm wondering why we need to keep all those pointers and do the pointer mag=
ic in the first place? can't we just make two nested functions like this:

for (all entries)
    if zero-entry:
    for (all entries)
         if non-zero-entry
              swap()

(I find this current function very hard to read)

Cheers,
      Simon
--nextPart4683452.8F6SAcFxjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmTaTsgACgkQoSvjmEKS
nqH8/xAAnPjreWHNolnLclsaXxEPRIAHGI+ZQrDZeINqIivQ8YoA1HCHtNeskoJ2
ZbWIAD/Q7otUZmGho1OJhmZ3jtc5PuUn8gGfzlQomTe9TlBOvMvt4ZIhB9heGBHb
tLqr70G/JFNZJf9omi6uFPuhz81W/7XhJ468wltS2feQPuQKGkusKUtRNixxj77S
zHmSk2HTpj55mHLs/qx/iD4FiDoTe1UkmNisiHkJrB7qOGpKtzrUqCFDfJNO1qub
QJR+WzkmthLgXeaZLdrGHRVr52xIQLDe2dJ35VXX9HLJgn2pX9Kzcwihy1Njo5Q1
UtpALsoQcVl0/I4C084Dz7UpwEhrmGMhkFCJ4sg/Jc81CstDc2bxpHvikjzX/19L
3wpgBimdOYVZiAOyWRtpSgPyAOgdcv3ihSCiHRu1oYxhJ+5zvDb0XSm5aCKi5wrZ
4VCase3t9cTMDNPZ2TQyesTIRHdfebK0wWuEY1v5vLRrtSyufKMPMEcxSaGoFQQM
tWcWzWZdXN3py1v8VRbmBO0314j6bQayQn2g+pkps8PVC6eqOHOZQ19n3G0R6hMd
A0g96CNT/R3n33XU0D0b/PfKwtUW05QA6KeFtGbUWFF+HHpYi6xZSThXowy4++mz
u9LwE8KydR9ZvlbeyXG3017qmkrUHZnFZh1wRVBQi8OIITyqroo=
=Osq4
-----END PGP SIGNATURE-----

--nextPart4683452.8F6SAcFxjW--



