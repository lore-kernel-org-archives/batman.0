Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7E7C02187
	for <batman-adv@archiver.kernel.org>; Sat, 18 Jan 2025 08:24:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4DEE983FAB
	for <batman-adv@archiver.kernel.org>; Sat, 18 Jan 2025 09:24:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737188683;
 b=lcshH5jN/vcIXuLNioaFP8lZ2oNK3WGY9IJm7a2nv8VLNNtI0ubKTQlBjJhKqg4mM6xvr
 GXBcCW0kVpg5fsMtzChlXfk/oojMDX7tavQkmE9S5/C3FTEkmnIjL/C62Pl4LmZk9YNFa3f
 hmKLiPGfTCR6tTtL3VPrJ4xT31dO9DA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737188683; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=G3IZklEtXMEZQwNwoU/r/BCbLk50+R8M3xF9uAtaFv4=;
 b=NOrcAy26+CuVcd/2vrrr46SLbA021g6pZdhIJqJZ2pimSTUpuIFnqBUqYBKVjdqgRx6zq
 1gpoYHdsWbjoUqCuOhVcs0KoZY23fimN/TSrUj9A/zAsc9MVM6IrMcZXd7n+LNG5kbqi3nb
 +K1TbvwxkMEHh65U/UHXPWZO2HNld2Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=mailbox.org
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AE29681AF8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 18 Jan 2025 06:00:05 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737176405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=G3IZklEtXMEZQwNwoU/r/BCbLk50+R8M3xF9uAtaFv4=;
	b=SHxI0x3D8dRdnqqm+3hwM2qb2zoLyghyQjrbxYeVkdanzlzcE3j9c37WhVSoflGfuki+B+
	CMGrmOK4SCMgczyNUYOaoOMMZQPqk+EVDFlGUpUUmrIEWuePPNUF2MEil8ZDI20XB6zGmg
	foPn26GbKhZ9oByPLLBoTTOigzgnp6Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=cMbsEm2Q;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 80.241.56.171 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org;
	dmarc=pass (policy=reject) header.from=mailbox.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737176405; a=rsa-sha256;
	cv=none;
	b=3xSvg6qupYlYC/wvv+h8fdjSmarF4pZr8XQfggrcnYxDkn7uCywko0NDo2zkuwJ3ud2tKx
	mpbZEj+mcbdV8+7pVkg8b7x12FeChJj6zpoxYchGl6lUl/MRvuoy/vIF3DEQTkmUC8Z3+y
	lTDeKTwbO8RJmRJptEodCjFvbTARtTM=
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZktW086sz9sxW;
	Sat, 18 Jan 2025 06:00:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1737176403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3IZklEtXMEZQwNwoU/r/BCbLk50+R8M3xF9uAtaFv4=;
	b=cMbsEm2Qrn5/2u3JOszAqho5S6bM6waIEUBbVKysFvKFaiElO9Ptg1oN6GtnfXK9xp/A3Q
	uejZ1huTHULh31dezDwVCUgBQ2Y6XoSRbT58SCj05WbzQkQ3kNZ+XkJvveGDEG/jSoO9bN
	hhIrGyHtDoXs1xcczIUdGe3btbYdCu+FZYO7kHf46fi5t5fuhgNRJhdtY07kl5eX6L/gU2
	M4gNPx5IyeV8yQEY8teq97N820vRBgHAsE3t/HeSt1MdDNM9GuYnTUE4F4lr17mLg2UOot
	115NwphduXPuxBAH9XqanA7pu1vdz1OifoO/ZLN/jNNtnyJh3UfxKKvm+FWA4Q==
From: Marek Lindner <marek.lindner@mailbox.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
 b.a.t.m.a.n@lists.open-mesh.org,
 =?ISO-8859-1?Q?Ren=E9?= Treffer <treffer@measite.de>
Cc: Andrew Strohman <andrew@andrewstrohman.com>
Subject: 
 Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link metric
Date: Sat, 18 Jan 2025 05:59:56 +0100
Message-ID: <6131569.pqZb4hCDXM@rousseau>
In-Reply-To: 
 <CAA8ajJnqXBuUmBzAHVjyEchD2CU9E7SmqJXXvy0V7QAQF9536A@mail.gmail.com>
References: 
 <20250118003528.6843-1-linus.luessing@c0d3.blue>
 <CAA8ajJnqXBuUmBzAHVjyEchD2CU9E7SmqJXXvy0V7QAQF9536A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-MBO-RS-META: gcw453dn1n55g8fr5trftn51g5k3nhb7
X-MBO-RS-ID: 2366fc65270b90d0023
X-MailFrom: marek.lindner@mailbox.org
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: PDCMTYNTNLJEPOVO5I2VVCIN3X65MJJW
X-Message-ID-Hash: PDCMTYNTNLJEPOVO5I2VVCIN3X65MJJW
X-Mailman-Approved-At: Sat, 18 Jan 2025 09:24:35 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PDCMTYNTNLJEPOVO5I2VVCIN3X65MJJW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Saturday, 18 January 2025 03:00:07 CET Andrew Strohman wrote:
> The second problem I have, seems to be that sta_get_expected_throughput()
> returns a bandwidth which is an over-estimate. For example, it
> estimates 150Mb/s. But really, I'm only getting 25Mb/s, or less on the
> link. I *think*
> the expected bandwidth delivered by minstrel is not considering the
> fact that the
> radio cannot tx as often as it would like due to contention. The return
> value seems to reflect that fact that we tx to the sta at a high rate,
> but doesn't reflect the fact that it's hard to get an opportunity to tx.

It is important to point out that batman-adv is not trying to get an 
'accurate' knowledge of the throughput. The throughput metric is an estimate 
and the important aspect is that the method of estimating the throughput is 
consistent across all radios on the same AP. This is necessary to make the 
estimated throughput values comparable. At the end of the day, the routing 
algorithm has to make an informed decision about which route is better, not 
getting the most accurate throughput measurement.

Please also keep in mind that the accuracy of any 'measured' throughput value 
over WiFi is temporary (in real world setups). If you measured 5 minutes later 
you might get a different throughput value due to interference, traffic from 
other mesh participants, the weather, etc.

FYI, expected throughput and also 802.11 throughput estimation are taking 
congestion into account. If you believe this isn't sufficient to get an accurate 
read of the situation, can you please expand on your findings? Note that the 
data rate fallback (tx rate / 3) is the exception to this rule.


> HWMP doesn't need to consider this, because it only supports one radio. 

Where do you see the difference to expected throughput? Expected throughput and 
data rate also is per radio and neighbor. 


> I found that adding a 2.4ghz radio to my bat interface has caused 
> instability and poor performance compared to just running batman with the
> 5ghz radio only.

With batman-adv throughput metric the 5GHz radio should be preferred due to 
the higher throughput of the radio. Can you please share details about your 
setup and highlight why you believe 2.4GHz is chosen over 5GHz.

Cheers,
Marek



