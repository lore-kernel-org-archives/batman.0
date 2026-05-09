Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BC4CD3447
	for <batman@archiver.kernel.org>; Sat,  9 May 2026 18:52:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB5F285B13
	for <batman@archiver.kernel.org>; Sat, 09 May 2026 20:52:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778352777;
 b=OTZ7CYwoxoXIq8v8mMmIUmnAEPQax90ttqupQEG2j0mPtRmyi0PrwIlKok4ayovoliWSx
 5++XgSbK3q9Md87YrGayKfjmuV7h7XTte3N6dsnAQK90/yW46+4M48auONAD7o3I2Thm5im
 GFUV93ubc2K90neaWDQXq259OmTKW0k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778352777; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=z/ruzjO2dAp5Qhc8D/RklsPkL7EIdY0uHbRyRHUl0n0=;
 b=cbIZBCTCJjVIMYynl/s/AJdyCLCvQTBkCA+/9j1qLu0J+fE4f7RhFXdHA1WnuA7s/2Wmt
 kvygDewq0FaD+fMrboPXJyRs8nQbn8wz0r+uoIPUkQ51961V2vjIcUL1ruQTmdb/1bEO7oY
 Ih5jlUnyaiT4rhCz/zvafeMZIVmrUWc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BB206855BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 09 May 2026 20:52:20 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778352751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=z/ruzjO2dAp5Qhc8D/RklsPkL7EIdY0uHbRyRHUl0n0=;
	b=JXW30MvMJLDv9S9dbVXfwH8ohX5dgF5gK3a4MuXKASLVkwFf7XHH6C6hMDFch79vxHPtXh
	tlBneN9vFbWNnWXtRsaYbAY9tkfQaoFfKabuWn74Mh6s2/YoBfnyw85Epy1M5aeFeJalZO
	yHjQ6ut1dFRhJDOxHmE6BinrAm4vSQ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=LyoAhjHK;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778352751;
	b=VVxo/w7Abp5tbgb3FdpukWhJd05uJcb1Pxr//vFsx7BBfLni1SfEQv7cXJ3p33uxJgzSIM
	wfCnUW88HSZtCrbHmf1uvvT8Prkz7fWaTmtZp190NCyI3LTXI5obGasa9feJik3Ug+6aZB
	VSAAmCDARbPk13imFfc00HQCDNE4nKQ=
Received: by dvalin.narfation.org (Postfix) id 5D223200D8;
	Sat, 09 May 2026 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778352739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z/ruzjO2dAp5Qhc8D/RklsPkL7EIdY0uHbRyRHUl0n0=;
	b=LyoAhjHKR4P5zbiFNnm90Kg9nefP/hFGfXE+J+dI29I1xeFggwI8UXTenbFY0pn6OShqKD
	2kneufAntsmYMCRQSkdrgA/bozGXSMgewTaMs4ehRpUwA3nFCfoduR0kIfngQDp0lr1Fs/
	kOLD9eUd29H/18AiTw0Mr4HKOwp+5VA=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Jiexun Wang <wangjiexun2025@gmail.com>,
 stable@kernel.org, Yuan Tan <yuantan098@gmail.com>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 3/8] batman-adv: stop tp_meter sessions during mesh
 teardown
Date: Sat, 09 May 2026 20:52:06 +0200
Message-ID: <118589593.nniJfEyVGO@sven-desktop>
In-Reply-To: <20260508154314.12817-4-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
 <20260508154314.12817-4-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2580528.jE0xQCEvom";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 5WYY6U7SFGTZYFCI6PPK2MDVMHX2VZYP
X-Message-ID-Hash: 5WYY6U7SFGTZYFCI6PPK2MDVMHX2VZYP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5WYY6U7SFGTZYFCI6PPK2MDVMHX2VZYP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2580528.jE0xQCEvom
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 09 May 2026 20:52:06 +0200
Message-ID: <118589593.nniJfEyVGO@sven-desktop>
In-Reply-To: <20260508154314.12817-4-sw@simonwunderlich.de>
MIME-Version: 1.0

On Friday, 8 May 2026 17:43:09 CEST Simon Wunderlich wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> TP meter sessions remain linked on bat_priv->tp_list after the netlink
> request has already finished. When the mesh interface is removed,
> batadv_mesh_free() currently tears down the mesh without first draining
> these sessions.
> 
> A running sender thread or a late incoming tp_meter packet can then keep
> processing against a mesh instance which is already shutting down.
> Synchronize tp_meter with the mesh lifetime by stopping all active
> sessions from batadv_mesh_free() and waiting for sender threads to exit
> before teardown continues.

Regarding the review under 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260508154314.12817-1-sw%40simonwunderlich.de

The fix for this existing problem is planned for the second net PR - splitted 
due to the amount of patches. Besides this split, was not included in this one 
because I am waiting for the author to submit the v2 with my change request 
(to also fix the second occurrence of the invalid `atomic_dec_and_test`): 
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com/

Regards,
	Sven
--nextPart2580528.jE0xQCEvom
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaf+CVgAKCRBND3cr0xT1
y72WAQDFVBUWAp8X7PrjoHI5CYUliUxo+U68UkaetrdQ2NlviwEAjXrfUF7sl2fU
8m2gEvsXHESwepGe/I1fVjZGMipanQ0=
=MKqp
-----END PGP SIGNATURE-----

--nextPart2580528.jE0xQCEvom--



