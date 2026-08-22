Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2856C5B572
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 10:52:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B71308148C
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 12:52:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787395975;
 b=zQ9xKBHdw7/AVYYBNmnd4iV9FIluQPwzN48dDiYLVAuGZaYAb+RbMscMjenb3jwIRgG9y
 6jceu7L/esRyJeulW5Kf4oEo3gnHtjYxW46/yRL+t8f1mJ02ktSDGDPN/bi5dDW3QblIpU+
 UWwGJuq7k56ZMikjuejK3O+Z8LM0KAQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787395975; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+A9ZO54T8rgnZj0kI1FqPmdnRVqmVtuZBXPeZ734HvM=;
 b=N6zFTMEtfWZwCk9LxdvWID7Ha35V0eFtGRiEMI47N26JvDksBOMLyeKMowSYPyUGOraMe
 DTI5YXSF/xN8vCm+ztFQQFLqIBSH+hHx4pWfgPz+juQg7Tzoo6BlK0Rc/8/DE9gEMRXXr22
 SXyGav1tDyEGrfhyfokBbXCp8WxlDUU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 932F5807F0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 12:52:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787395967;
	b=jdFHzQfwjt07YPFze+o/EBurhbdvIdNtuBEi6w4E+XV1JxUYt6GHoUlLtrcRl4fL17Ij6L
	cJ9TMmupr8VODvSfstiWB1hyITb4ECyfA3Kg+a0+aWRbpqnlYohoErI004HZXiPQnd4zxm
	LXddwfujJJS1XVpiosfylLofmL5L9bs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787395967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+A9ZO54T8rgnZj0kI1FqPmdnRVqmVtuZBXPeZ734HvM=;
	b=SISWsT+ceZ4ES+rL0V4EYLjbBHDt0f+kR+FsQLVzwVXhrE5xEKsMQQpJwKqmNl3BKsagEg
	zKolLWj+rZfoWASbh+ZycU+pxYHz1c0yJsW/wUj9dkjs6fqk5lghV1hESaMalRggtNrqJ0
	Y4/+DmdhD7l61QcP85VcSBdoyImmSDE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oF1RaNNu;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E8ABC1FD5A;
	Sat, 22 Aug 2026 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787395952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+A9ZO54T8rgnZj0kI1FqPmdnRVqmVtuZBXPeZ734HvM=;
	b=oF1RaNNun07Hg8VSm0t9AS/rH5mQiJWCnhcDHS7wH6yTT7/Ls+k2mK8IjCrjXzz5K/G3l0
	iB8S0ZPlXyFRbDbYLmgnatUovVTPsUNZ1C+e4wjIVPtmWIeF/iklcWmkv/2cqpy+R4UWVO
	oGVjSP+hu/fEWSNTOy18QPkpWPAJn7Q=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Zhiling Zou <zhilinz@nebusec.ai>,
 stable@vger.kernel.org, Vega <vega@nebusec.ai>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 1/9] batman-adv: fix stale receive device on merged
 fragments
Date: Sat, 22 Aug 2026 12:52:24 +0200
Message-ID: <6299903.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <20260821094813.201800-2-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5127734.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: FTC4BCCCJT2YVFERWNOFJBK2G5BWC62L
X-Message-ID-Hash: FTC4BCCCJT2YVFERWNOFJBK2G5BWC62L
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FTC4BCCCJT2YVFERWNOFJBK2G5BWC62L/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5127734.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 12:52:24 +0200
Message-ID: <6299903.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <20260821094813.201800-2-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1-sw%40simonwunderlich.de?part=1

> --- Patch [1]: [PATCH net 1/9] batman-adv: fix stale receive device on merged fragments ---
[...]
> On the receive side, batadv_bla_rx() is called from batadv_interface_rx()
> only after skb->dev has already been replaced:
> 
> net/batman-adv/mesh-interface.c:batadv_interface_rx() {
> 	...
> 	/* skb->dev & skb->pkt_type are set here */
> 	skb->protocol = eth_type_trans(skb, mesh_iface);
> 	...
> 	if (batadv_bla_rx(bat_priv, skb, vid, packet_type))
> 	...
> }
> 
> and batadv_bla_rx() does not call batadv_bla_process_claim() at all.
> 
> That leaves batadv_arp_get_type() in
> net/batman-adv/distributed-arp-table.c as the only consumer that can see
> the stale receive device of a merged fragment:
> 
> 	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN +
> 				    arp_hdr_len(skb->dev))))
> 
> reached via batadv_dat_snoop_incoming_arp_request()/_reply() from
> batadv_recv_unicast_packet()/batadv_recv_bcast_packet(), and only when
> CONFIG_BATMAN_ADV_DAT is built and bat_priv->distributed_arp_table is
> enabled.
> 
> Since this carries Cc: stable, would it be worth restating the affected
> path as DAT only, and mentioning that reaching it depends on DAT being
> compiled in and enabled?

No

Kind regards,
	Sven
--nextPart5127734.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaol/aAAKCRBND3cr0xT1
y2djAQC6Wcf+fKhb5XLEoQF748sDkzw3gj9qR81Mv7zdNacwmQEAn86vSlxpETyb
Q1tMEOwhO8ckdU3MvbSB74WU/JWNQwM=
=Cj/H
-----END PGP SIGNATURE-----

--nextPart5127734.31r3eYUQgx--



