Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0104606A31B
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=VALFiym6
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 30E708417B
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 13:36:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793104568;
 b=po0dykpW22MfkLDMGH4sr92HrGp2Bsn5zinzTd4mW9rqYFVzyhSJ0DjFTn6H9GNWRw5yh
 pIhXsjUNJlJdtkjzdZUyqPh0qOk5LlxTabyLoxWe1lFsyZULkPAyF6KjEbdYbOTjrgmZNwK
 dp5ufVVRQt23XS+fgbpokIBU/NDJ4Vs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793104568; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=K+i0Ir8NB1/YA/OFJN2Vo6ahQORxDCkTkkHvWg7tAU0=;
 b=mYV7z3oLXgnXy2jl/tOjZlQPDrXp7GMHSbwa5bfa1zssWJBFnZs3R5jk3U19kMvKOHWm8
 v8oAz2mAuTqFxgwKfu6bnIcD0iWbLVGCLQF0O7y+OdiEEQ4lvi4saBBSkltieZhO+mDMrjP
 HUdC7EveghOlNPAzHNE1bME8Ax6JjtQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2149F81233
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 13:35:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793104553;
	b=EZ+/B+GwbaXjclb63fxbL3fr3vi8tIvBRNRFtRmYXkuPQGBp+XQjZQUTPOAmNW0C+O9P0x
	0z0wLZcKBgdeRbpc5fOYBz3i+qfuaMnUJYMbGSoOwFU/2cSeZYM8Pr5WQXLZWbIILDxFwd
	R9q4LvmWcJH7+K9ZwGZ2C0qiuRKQSgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793104553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K+i0Ir8NB1/YA/OFJN2Vo6ahQORxDCkTkkHvWg7tAU0=;
	b=EUieN2sUHVTxcCsECRO7bSNHJfObBYtvQkv4azmTxy7rx86hK9FlOTx45Zlxy5jT48CEjG
	yDRlqAc+xpX+lZyQSmnOL49CBCHo1QQaR4C0H8+puHuCkXF6f2NiBYBLMtx73cbqcIB3wx
	Np+moja/eA9kVFWHzzjDLon3+AGL9Yw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VALFiym6;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4D1BC20581;
	Tue, 27 Oct 2026 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793104541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+i0Ir8NB1/YA/OFJN2Vo6ahQORxDCkTkkHvWg7tAU0=;
	b=VALFiym6jC5QNhPgDk4uS8ZY59hMZJ7Y3BaVeeQLQ+tqQ+aFB/nJ7xK6D9+QPm2+BiZzty
	zC+PDPCI02H57dC5vhI07HwiQEDnlVqGftt/cQPdln0yCyDk32s3GYGrlbO57Nu0mMJuMt
	HJ+Xvgohx9RfqAQ6kEDMD8S7W3hFRZk=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net 10/10] batman-adv: tt: limit local table to single
 TVLV
 response size
Date: Tue, 27 Oct 2026 13:35:33 +0100
Message-ID: <2934231.BEx9A2HvPv@ripper>
In-Reply-To: <179309132480.3134.3568656714789779480@kernel.org>
References: <20261026085309.1074911-11-sw@simonwunderlich.de>
 <179309132480.3134.3568656714789779480@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15872503.tv2OnDr8pf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 42ASKDJ7DGUMNOJWYFIOTEBKQ2GLBM26
X-Message-ID-Hash: 42ASKDJ7DGUMNOJWYFIOTEBKQ2GLBM26
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/42ASKDJ7DGUMNOJWYFIOTEBKQ2GLBM26/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart15872503.tv2OnDr8pf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 27 Oct 2026 13:35:33 +0100
Message-ID: <2934231.BEx9A2HvPv@ripper>
In-Reply-To: <179309132480.3134.3568656714789779480@kernel.org>
MIME-Version: 1.0

On Tuesday, 27 October 2026 09:55:24 CET netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> 
> Does this Fixes: tag point at the commit that introduced the problem?
> 
> 85fb027f611b removed a check from batadv_tt_local_create() that already
> limited the table by packet_size_max only:
> 
> -       /* Ignore the client if we cannot send it in a full table response. 
*/
> -       table_size = batadv_tt_local_table_transmit_size(bat_priv);
> -       table_size += batadv_tt_len(1);
> -       packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> -       if (table_size > packet_size_max) {
> 
> That older check had no cap at the 16-bit tvlv_len either. So the missing
> limit seems to predate 85fb027f611b.
> 
> Blame on the parent of 85fb027f611b points at defa87f5ce75fe
> ("batman-adv: tt: extract allocation of new local entries"). That commit
> only moved this code, so the check is older still. The original commit
> was not identified.
> 
> Kernels without 85fb027f611b can still let the local table grow past what
> one unicast TVLV full table response can carry. This happens with
> fragmentation disabled and a hard interface MTU above
> sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX. In that case,
> batadv_tt_prepare_tvlv_local_data() hits its check_add_overflow() path and
> returns 0, so no response is sent.
> 
> With the current tag, stable tooling would only pick this fix for trees
> that contain 85fb027f611b. Could the tag name the commit that first added
> the packet_size_max-only check? Or could the commit message say that
> older trees are affected too?
> 

The code only does it job partially after this commit. All of the previous 
commits would need a big revamp of the TT code - which is not backport-able 
via stable.

The really relevant part is in batadv_tt_local_reserve() and this was only 
introduced with this specific commit. And only for this commit, Sashiko 
pointed this out.

Regards,
	Sven
--nextPart15872503.tv2OnDr8pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauCalQAKCRBND3cr0xT1
y8TcAQDjHcUwP2NnzQWPSyWeev4w3Dn2s9iUlhfIyglDNphWaQEApfjfe4DbHT5L
NYy4eR55gRf5HWQ8hcEEXHkCgWA/rwc=
=XFF3
-----END PGP SIGNATURE-----

--nextPart15872503.tv2OnDr8pf--



