Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098C6C5B572
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 11:56:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67FF5810D1
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:56:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787399808;
 b=G6jebShoPHTDoElODDKYZYRA07alXRq2T6ZGHjDs4pM3JVZMxPHF8OlLdB5CNoptw+7QB
 SVnt5GH+Mv3hGu40a7ixromjERd0FmqhU0bavqthdxKd1dgIWPmqTWkx+diyQWQewP6rPDo
 chNSgBrplGXxYVj+kJykxuC2C11T3Fw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787399808; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YkrHjrxPJU2+2QsZs39qamgqA/1b0zrZYk1nxsr4q7w=;
 b=CAbRl+rIswFQjb4QqralkBGLlrDJJEIu6hfDiCC6zxbAW5oFmHvpNkj/UhYTTVR0xPo/Z
 WlPUBw1ZkYecSfgyj8tUHnDDA1hXrJ8JxwgMJUuymotJbcIMwDfbKNMeCRoiORDOdtP9iYu
 qDuHBk7AxpNQnkwvVL9pqW4Ck0nPbDw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BFCF9814FE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 13:56:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787399800;
	b=0ntlY9GYfQfEcIjAF535DN486ZTphwRM+vVYSX+Fdylf24es/JhmFtIp/uqAJLeAOmircY
	6ANFOZfPpqFOgM3vRKVik69OCcngpFKDTThTTURVA5kYaw5cak/l2Jfh6NYeQZlglPxs5d
	ANVVVTYq9e6/r8IQyc6Z1wOejFn1IcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787399800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YkrHjrxPJU2+2QsZs39qamgqA/1b0zrZYk1nxsr4q7w=;
	b=N7GT16vqMUjDLkO2fyItSz9Q0TFruIB1o89KyV80ytUXi5WfYIN0BtuXtzRSSRQyMrhKhR
	xaiFRBJgm9qNDgXrzw/QXt+5BDPZ7WQbN0BPXlGX7NoIyqGjVGqIPTPyxJgCxk7ZK0Z4L0
	v5xzzIeVsMWGD68QRGGN8l2lzd4OXqY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QtB2CuQj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8C843200FB;
	Sat, 22 Aug 2026 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787399784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkrHjrxPJU2+2QsZs39qamgqA/1b0zrZYk1nxsr4q7w=;
	b=QtB2CuQjIFfssKD6hyWFZQdJmT6KlCW4CEalHrAn1uEZGRXGS917+dg5Lmxp1tjbKP09xo
	3S/T5m8mQKl0dyZiUXi9Woyt+g2aX+1tp4HlmuzwJ7k2C580dIBJ4SLjZcLOBd+K2PGB7X
	XhfrlWuZH+hoZMCEARq3f+N8g5JUcQ4=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 9/9] batman-adv: bla: fix freeing of claims on meshif
 deletion
Date: Sat, 22 Aug 2026 13:56:13 +0200
Message-ID: <2492208.NG923GbCHz@sven-desktop>
In-Reply-To: <20260821094813.201800-10-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-10-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart893706146.0ifERbkFSE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: LH5QX5CWNOXK7EBXLPAWGX22FKSRABFQ
X-Message-ID-Hash: LH5QX5CWNOXK7EBXLPAWGX22FKSRABFQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LH5QX5CWNOXK7EBXLPAWGX22FKSRABFQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart893706146.0ifERbkFSE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:56:13 +0200
Message-ID: <2492208.NG923GbCHz@sven-desktop>
In-Reply-To: <20260821094813.201800-10-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D9

[...]
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
>=20
> This isn't a regression introduced by this patch, but since the commit
> message names the missing rehashing as the reason for the change, is there
> a plan to address the underlying problem in
> batadv_bla_update_orig_address()?

See https://www.open-mesh.org/issues/452

[...]
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
>=20
> Also pre-existing rather than caused by this patch: the 6 byte
> ether_addr_copy() into backbone_gw->orig is not a single atomic store, and
> batadv_bla_purge_claims() reads that same field under rcu_read_lock() and
> forwards the pointer straight into batadv_handle_unclaim():
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_purge_claims() {
> 	...
> 			batadv_handle_unclaim(bat_priv, primary_if,
> 					      backbone_gw->orig,
> 					      claim->addr, claim->vid);
> 	...
> }
>=20
> After this patch the batadv_compare_eth(backbone_addr,
> primary_if->net_dev->dev_addr) test is the only remaining decision in
> batadv_handle_unclaim(), because the claim is now removed unconditionally.
> Can a reader that observes a mix of the old and new MAC bytes here wrongly
> skip, or wrongly inject, the local UNCLAIM frame while the claim is delet=
ed
> either way?

Will definitely not change the patch because of this unrelated finding (whi=
ch=20
seems to be self-healing). Documented for Simon at=20
https://www.open-mesh.org/issues/469

Regards,
	Sven
--nextPart893706146.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomOXQAKCRBND3cr0xT1
yww/AP92Z4vUW62S/ucm+Ddse7NTAyiBbQr06N84OSjUqSfsLwD/Y2BBFwxC1dzr
H2ONzWMF3P2rHHJaVidIgmjszrJlXgY=
=IEGh
-----END PGP SIGNATURE-----

--nextPart893706146.0ifERbkFSE--



