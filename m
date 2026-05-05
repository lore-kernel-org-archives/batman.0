Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70528FF885A
	for <batman-adv@archiver.kernel.org>; Tue,  5 May 2026 04:50:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 95B16858B9
	for <batman-adv@archiver.kernel.org>; Tue, 05 May 2026 06:50:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777956635;
 b=DFncfHRNcwbHXefmQfkHJY5AgRZv7+c7xerJFDnozICi+oC5M+yNBRctjUnT+bvVQe9Vo
 t7N4aZoJshaIgJy0YjZLkuYnSE4SEwjxneF/CtOrlHLPAPCIjET4gGd4xcjur4/hkEsSnXc
 lNTksqpFMwyPcXZdVTlHbSWMRnFXBVU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777956635; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Lq6R9rd8X8jTXmZ6W1O/me6//zs6LOkcxvOUChwvpvw=;
 b=cgIUhyabUB1qdETw9b9qUMsBbqqkmtLBeyeKdQ4BOA8AvRrc3AriwM7ZeqkN1CL4bkQVk
 3Wctmhym8al0+FxRbSBfQ/BlZHb0hUPCCsRVpxDDKkf6kAvy/U4TCTJrGvxjppUqyzsPfgI
 O6Va7UgTZov6JKnrOTJ2UpnqbSBhJp8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 63E5984A90
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 05 May 2026 06:46:24 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777956385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Lq6R9rd8X8jTXmZ6W1O/me6//zs6LOkcxvOUChwvpvw=;
	b=hzKUeoeQwC/QCUaOUk4AQaEddceFjElmvs+ToU9MDCyOsZNbn0M01SDiR0VQ8fXGA/S5RV
	c5ddkhUE3KaRjGopb15VsK0NOvTIIf1DoF7/x9khjAX+1BmAx12cAaA2qHPcMixSpWgntO
	H3qT28hWCrfzfCTdP6y5CdLjCdwQzJE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YzV3P21e;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777956385;
	b=z3QEpT8IH0kMTmogWValO9iEaRMXXZ7F0K5LNkZbvdZBu6DBW6wQ1VC7IlMF4fkYDfLEb6
	9dK5DNYda2UdenR9UNq+21yNz2jvq+PRVieVZGtueiLl07qWJF8uSZp/vcPSIS+Y0XPDFQ
	pujZFruzpz22MNX6Blilv1EuzxReGWE=
Received: by dvalin.narfation.org (Postfix) id B2E581FF78;
	Tue, 05 May 2026 04:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777956384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq6R9rd8X8jTXmZ6W1O/me6//zs6LOkcxvOUChwvpvw=;
	b=YzV3P21eoDduZjvYFi0AM/ra7GXV2nL0o9zDwbJ3Kf5/T7DyxoTghKEAsmG6i/YBr0okZA
	Mez7utpOKU+kOVcERyy6N506CIzLvD5n4euF8FkHFy78T1arp0V++P3Xcu3sOxkqDb+1R7
	2ayjrGbRh+CBLVXFdagVe2eh3/uH0m8=
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 stable@kernel.org
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 06:46:11 +0200
Message-ID: <5990011.DvuYhMxLoT@sven-l14>
In-Reply-To: <20260504171051.2b3e47ef@kernel.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
 <20260504171051.2b3e47ef@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6264035.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: MO3UYVQCGYBAJMGSMGZLTAXE35HALIUI
X-Message-ID-Hash: MO3UYVQCGYBAJMGSMGZLTAXE35HALIUI
X-Mailman-Approved-At: Tue, 05 May 2026 06:50:29 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MO3UYVQCGYBAJMGSMGZLTAXE35HALIUI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6264035.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 06:46:11 +0200
Message-ID: <5990011.DvuYhMxLoT@sven-l14>
In-Reply-To: <20260504171051.2b3e47ef@kernel.org>
MIME-Version: 1.0

On Tuesday, 5 May 2026 02:10:51 CEST Jakub Kicinski wrote:
> On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:
> > While reviewing the fixes submitted to batman-adv in the recent weeks,
> > further problems in similar or adjecent code was identified. This was either
> > noticed in the manual review or reported by sashiko.dev.
> 
> Are you CCing netdev to get this reviewed by Sashiko?
> Please don't..
> We delegate code to sub-sub-systems to lower the patch volume :(
> 

Because of `b4 prep --auto-to-cc`. Will now manually remove you.

Regards,
	Sven

--nextPart6264035.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafl2FAAKCRBND3cr0xT1
y7meAP46UTEv5pX9jnioel/mvqL1JOLHs7Mw9LA1N0MojSw4rAD+ImjhYl7DEAgI
5WdexqiK2V/tFuzPyqNBbcYevZJK7wc=
=U/YX
-----END PGP SIGNATURE-----

--nextPart6264035.lOV4Wx5bFT--



