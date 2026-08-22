Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A58FC5B572
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 11:16:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BD4958148C
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:16:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787397376;
 b=PCONY3WgkjbbOOlGBRwRFxMA51qgaxv0c6Pmhzq/x2du4lgl/2Kl6eWBVoiiGbkSdn8YZ
 rDMTPojhLDzHV201jXJi5PBc149lF8yZi9MFVtGhaOoG7CCVXorzQUMKCG123ngNIdXd7Wc
 17gRx3tgM3jbcX7sJLC1VsElOJGWJWw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787397376; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aJqFFme5zny2M+ndpmnl6LydymRJAkASRNq66ejAgzE=;
 b=fyg+ZtEzZtpUlujyVptWu0rOsMTvnn5z1Smw7XgxKqVRZaYUIvM0DG9GR9FmIpEx7830X
 3FsZM3OUfTgKkyXEOd1r/5Sb4tii7FDFGUSpxwSgPtduCQpDSPAqKOVIYU8Plg+imJ3Pbb4
 ZeSi6ftiEPIFuRxc9DO6/c32wytMcXM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ACDA4807A9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 13:15:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787397368;
	b=e+rZfmOrPQQNmEcTMFq2OdcThvfuqH/LYCJ5KFbLhGL994WfJ2sdE06cWgbF3EXCeOAXYl
	rK4HmyFDGFU5axqM6cXypTHE8O0MbZl/RKabXCZqkk8OHNuVWvqe2r9jM0y7qmIANWXC5H
	OFU0Kvq/o35TDoHWP2ttWRNfZaEAupc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787397368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aJqFFme5zny2M+ndpmnl6LydymRJAkASRNq66ejAgzE=;
	b=kMqulwGYS7ZyM3WQN71ihgdBjZLp8c/goLzWMwKQR6IwopH2aetRGh/zpuuKN9+AkvWFV8
	Jgr0+t4M3uN0Xl1jNbZbD0ugIAg+/2E+JB07n29XOhBDJn+0wbcpP+aaeBMDIdxbulOhvy
	wu0uwDuoloc2gX6Xk8wz98vRyQtfkAI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CdvO0Fcc;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DEF5C1FD5A;
	Sat, 22 Aug 2026 11:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787397354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJqFFme5zny2M+ndpmnl6LydymRJAkASRNq66ejAgzE=;
	b=CdvO0FccrsDHcoW+djXygOmYVd/tvOIPlv0IL1jAkFMfGf0LTMoQcuKGnPV6P5aKQEcNyf
	96GJCygAWbOB6oCK9Aq7KdDICYhk2N+5tuETjvBUVSFw3+BV7kjk1pBLu5Cm6WhUv96fnE
	cL6rvUyz4GzJDwWEie+Fn/MFetpQz1U=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 3/9] batman-adv: bla: prevent CRC corruptions after
 claim
 flush
Date: Sat, 22 Aug 2026 13:15:45 +0200
Message-ID: <23219208.EfDdHjke4D@sven-desktop>
In-Reply-To: <20260821094813.201800-4-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-4-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7985708.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: CUI6OZV76KFIY7GPPMR3RZA5LVD4LUP3
X-Message-ID-Hash: CUI6OZV76KFIY7GPPMR3RZA5LVD4LUP3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CUI6OZV76KFIY7GPPMR3RZA5LVD4LUP3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart7985708.EvYhyI6sBW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:15:45 +0200
Message-ID: <23219208.EfDdHjke4D@sven-desktop>
In-Reply-To: <20260821094813.201800-4-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D3

[...]
> Discovered by: gpt-5-6-sol =C2=B7 Missed by: opus-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5
> This isn't a bug introduced by this patch, but since the patch touches
> exactly this function: is the ownership test in the loop just above the
> removed hunk sufficiently synchronized?
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_del_backbone_claims() {
> 	...
> 	spin_lock_bh(list_lock);
> 	hlist_for_each_entry_safe(claim, node_tmp, head, hash_entry) {
> 		if (claim->backbone_gw !=3D backbone_gw)
> 			continue;
>=20
> 		hlist_del_rcu(&claim->hash_entry);
> 		batadv_claim_put(claim);
> 	}
> 	spin_unlock_bh(list_lock);
> 	...
> }
>=20
> claim->backbone_gw is read here with only the claim hash bucket list_lock
> held, but the writer in batadv_bla_add_claim() only takes
> claim->backbone_lock:
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_add_claim() {
> 	...
> 	/* replace backbone_gw atomically and adjust reference counters */
> 	spin_lock_bh(&claim->backbone_lock);
> 	if (claim->backbone_gw !=3D backbone_gw) {
> 		changed =3D true;
>=20
> 		old_backbone_gw =3D claim->backbone_gw;
> 		kref_get(&backbone_gw->refcount);
> 		claim->backbone_gw =3D backbone_gw;
> 	} else {
> 	...
> }
>=20
> The two paths can run at the same time:
>=20
> CPU0 (workqueue)
> batadv_bla_periodic_work()
>   batadv_bla_purge_backbone_gw()
>     batadv_bla_del_backbone_claims()   /* reads claim->backbone_gw */
>     hlist_del_rcu(&backbone_gw->hash_entry);
>=20
> CPU1 (rx/tx softirq)
> batadv_bla_rx() / batadv_bla_tx()
>   batadv_bla_process_claim()
>     batadv_handle_claim()
>       batadv_bla_add_claim()           /* writes claim->backbone_gw */
>=20
> The same interleaving looks reachable purely from received frames, since
> batadv_handle_announce() calls batadv_bla_send_request() on a CRC mismatc=
h,
> which also calls batadv_bla_del_backbone_claims().
>=20
> If the purge observes the stale owner after a racing CLAIM frame has
> reassigned the claim to another backbone gateway, does it unlink a claim
> that is now legitimately owned by that other gateway, so the next mesh fr=
ame
> from that client MAC makes batadv_bla_rx() claim it locally and two backb=
one
> gateways forward broadcast/multicast into the bridged LAN until the
> claim/CRC request protocol resynchronizes?
>=20
> In the opposite order, if the purge observes the newly written owner and
> skips a claim that was just reassigned to the gateway being purged, the
> claim survives pointing at a backbone gw that is removed from the backbone
> hash immediately afterwards. Since batadv_bla_purge_claims() only expires
> claims owned by our own address, can such an entry linger and make
> batadv_bla_tx() keep dropping multicast frames from that client MAC until=
 a
> unicast mesh frame triggers a re-claim?
>=20
> Refcounting and the CRC XOR accounting do stay balanced here, because
> batadv_claim_release() re-reads the owner under claim->backbone_lock, so
> this looks like a claim table state consistency issue rather than memory
> corruption.=20

Minor problem, self healing and not about this patch. Not sure if Simon wan=
ts=20
to fix it.


> The code is unchanged at the end of the series
> (b32d9323b268). Would taking claim->backbone_lock around the ownership
> test, or comparing against a value read under that lock, be appropriate?

No, this is wrong. You would then complain that this patch is having a TOCT=
OU=20
problem. I will not fall for this trap.

Regards,
	Sven
--nextPart7985708.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomE4QAKCRBND3cr0xT1
y7v/AQDPKO7s5WxY8IMFpBmmglO7ByGKPEKeG7czt8xaYg5kAAEAhlcqYavv8IPK
kq/Lfs0218blq7PYob14oQZzGNsrzAc=
=MvmJ
-----END PGP SIGNATURE-----

--nextPart7985708.EvYhyI6sBW--



