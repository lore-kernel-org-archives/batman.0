Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10B0D3B7F6
	for <batman@archiver.kernel.org>; Mon, 25 Nov 2024 09:44:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1141683F91
	for <batman@archiver.kernel.org>; Mon, 25 Nov 2024 10:44:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732527860;
 b=EfQR21AZOyPqqDOaP50DyLCBEr+TDyYQDRUTCOFNWyaMW/Yzasfikg77KEqSWwbQJzPiN
 J6b0dp2xB7DtvEYc9pKnhcikFqyIDfWKci46dgXF1FHZ/WwyqZriBYk/pK1S0IAjsuomPvC
 K7y2Wj+CK35WR8AwVONqRbyAjMCIYWc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732527860; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=d95URdRo88NGMQx5/gu33rmEAw++vnah3t0erBwGxAs=;
 b=Zmc1GU0dgswYFmqrukWW7WcaDYrFkh2DUz3VPwoSi7YaZ/jklP9giBRwvXB4f4XZSiOtf
 crYGxNLvTN6zwRX27o52nr9l+uUlPjx2EA+Skemf2X3sUYcaGht5Xct3920EsUBMdXApKcI
 h4VTBM4peV/jhMBilzJCLdNVk3yIius=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0C363815E9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 25 Nov 2024 10:44:02 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732527843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=d95URdRo88NGMQx5/gu33rmEAw++vnah3t0erBwGxAs=;
	b=oZ9QHne1uIcQj3fzPkOfuCQ3Hbd/QCncljtpJRxjTdLzsUZb0Vc1gsyIWplV8sq4WABp/c
	OSRZZuasMKjL+BVK+4SjvGFlOQuWcdI5Tb/JauZRvi+rJ+68LkPpCIFmGVtkfi3DYK53Xg
	q+qY3nTZYuQknFHWi3F/5hDclpVMcnA=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732527843; a=rsa-sha256;
	cv=none;
	b=Ps7uhYXCdq+U+TwzZjm53U4Q9XEi0TlfjYWayZ4fUugxC4Jvycdp5MVtcYksPem6dBIASg
	QTao2zT87lCaVzlBVCNdBZ8MhurC+BV2RBZKNb3QKpNcCSk7fZhfVqtPn5sqE7CPzOOBno
	6Gly1m5UlIiuxaPKUDjNb2IsS7cdM/I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=gypztrf8;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=ROJ4TT4e;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.uxh2mnf3lnunm66=uec6spnpwoup=918m2grxg1dmr8@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.uxh2mnf3lnunm66=uec6spnpwoup=918m2grxg1dmr8@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732528742; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=d95URdRo88NGMQx5/gu33rmEAw++vnah3t0erBwGxAs=; b=gypztrf8jYCTXA4LyKdvSfnkm5
	0V1xxL2OA0xSrBDXMWJGCd6UirfdVGpV97Gm6Za6c4e9bZnf82r6ex0S8OUyugZJcw8Q4BPqMwDh4
	b3HlAADBAzBxry3773WyDkfH2LBCGZBUuubrMBhDEuYMCm1cCNalm1miswuHeveGKIXNFiteTqfRo
	0xBOBhbj1B/xnTpAZcqvY6C3VAXwRjVqnwg9yR7CAInnsbZDLhSNr+Q6LKzb7v1ecSuqmwoeP8GKw
	PRLLwJVLmC3v9nMnNm3SnOQAAHjk/5uLW9cBnWptugWfzlT39WtBzUXdvGmsY0vXBzt/L0X9uGILE
	Q5j89Y3A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732527842; h=from : subject
 : to : message-id : date;
 bh=d95URdRo88NGMQx5/gu33rmEAw++vnah3t0erBwGxAs=;
 b=ROJ4TT4eFM5Uo9tbXErQAA01cEJMXnMnhWOCi5GekiPUqXzgjqWGteT4k4yIJD8z3HhAd
 WEMCL5z67WIq1K9Fdb4FV7BTHJfHZdtv9uPhkFLbDKXL6Dz0j8jJIagdNsdnR3qj3i3bQD5
 s7QcV/G6tBeB9Vxn2ZGeqgeMW4NgH3A7XWum7xndDjYMgi7eFPKq5ZbCGzjJP/uJShlcraH
 MuEXDkdZdFC0TGv3ZVWdS8mUTkSnPDcv0joUcRguoRiH7GJY8kAnQNyGAAeBO3V0vqLUtQI
 EQ2qMk3v17hC1A8nwWHPKD2hlT1tB6vXRV6Pk3rmDFovq7DlsnRNnLt8JJRA==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tFVdP-TRjxGa-PE; Mon, 25 Nov 2024 09:43:59 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tFVdP-FnQW0hPydQM-m3TA; Mon, 25 Nov 2024 09:43:59 +0000
Date: Mon, 25 Nov 2024 10:42:43 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Subject: Re: [PATCH v4 5/5] batman-adv: Don't keep redundant TT change events
Message-ID: <Z0RGk0NnW3Jicj5q@pilgrim>
References: <cover.1732290614.git.repk@triplefau.lt>
 <3ffeca62cb1808f3d5fd3d1e0937c1e812cf16c2.1732290614.git.repk@triplefau.lt>
 <115531263.nniJfEyVGO@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115531263.nniJfEyVGO@sven-l14>
X-Smtpcorp-Track: g-hymJi0QP1u.E47LSL5puxry.CYgwig8XDrA
Feedback-ID: 510616m:510616apGKSTK:510616soogN4eGaJ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: 6CVES6RUPT7GXGXZ2FVBF24XWLOY3ZZA
X-Message-ID-Hash: 6CVES6RUPT7GXGXZ2FVBF24XWLOY3ZZA
X-MailFrom: 
 bT.uxh2mnf3lnunm66=uec6spnpwoup=918m2grxg1dmr8@em510616.triplefau.lt
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6CVES6RUPT7GXGXZ2FVBF24XWLOY3ZZA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Nov 24, 2024 at 11:00:40AM +0100, Sven Eckelmann wrote:
> On Friday, 22 November 2024 16:52:52 CET Remi Pommarel wrote:
> > -               del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
> > 
> 
> This line must not be dropped. Just checked my PoC change and it seems like I 
> already dropped it. I thought I've spotted and fixed this before. But most 
> likely, I've just changed it in the editor and then forgot to copy it back to 
> the mail client.

Outch, sorry for not having noticed that. I am a bit surprised that gcc
does not complain.

> 
> It is also called "Co-Developed-by: " and needs a SoB directly after that 
> (which I didn't give at that specific point - but now did in batadv/net-next).

Actually according to checkpatch the preferred tag seems to be
"Co-developed-by", which was still not what I used. Also I have mixed
feeling about this tag, I have been asked before to add the
Co-developped-by tag but I don't really feel confortable giving
Signed-off-by in other people name....

Don't know if you noticed, but I also messed up indentation at line
505, my bad.

> 
> I have now changed this directly the batadv/net-next branch. But in case there 
> needs to be a v6, please also change this locally on your end.
> 
> We will still wait for Antonio before I consider it really as accepted (and 
> then try to send it to the netdev maintainers).

Thanks.

Regards,

-- 
Remi
