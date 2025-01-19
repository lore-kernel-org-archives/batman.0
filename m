Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B10C02187
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 05:05:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CDAFF83E3C
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 06:05:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737263157;
 b=pQdZI2v3caJ5A+cKJVbnKFV4eCEFU31LQPSmgpiPBU9sonHOo1N74JfiRl/hM8XN2lsyG
 0Y1dGQTKCP+dSecsBakVwk8ufwob6VW2iphO5mUekEoisklOJ8xQXA9GuR5b48jGE3BrbZl
 P5RrmDkQ48+cZPXkLm8hxP/OGJ01aY8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737263157; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Q8NeeeTgiSmbB0ozuckjie4iJ6NoXU9/WfadnvSGnnE=;
 b=pR4Latq3PIi4UIy5FtpR5qbQXLNMp1JX9XaZ6MKnQMQHp+AmfLVOJj+l9DjHDYBP5EunP
 YN0bAE7m3le9urQCH2GlkGDThzUmsa+nuu+xFf22EUrJ6tkILtHMNo/wxGULIUa49Yvgncw
 Xug+oOmosnyYXENdrAFXn0CvR5Y16t0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 343D981071
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 19 Jan 2025 06:05:49 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737263149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8NeeeTgiSmbB0ozuckjie4iJ6NoXU9/WfadnvSGnnE=;
	b=w/hIlhYhVErW7GuNj67JO2Jrwr0pBaLBUgy7Y4mWphWY/awXGr7V9gaGjU+9M3bqbulfUT
	CEIgqkmIoi8e4nn3ZWBwDATZ95S83Fbs4fe5FHljNGNp6fhKZL2iYYxloq4b3m4bZp+FA7
	vCBfDOhyGpwW/QsacnoSrTJzIvB3hIA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737263149; a=rsa-sha256;
	cv=none;
	b=l/ncxbIOkKxe9Ux9mjlpJtCmO3Y6eOViu47OlKb5tpRj4Yuip5cVWJAkhqmp1/DjCKPMDk
	CQ9HYoL1ybR2UXNAYXlTHOjUynCbrH+aOpP8QxtC+V6or8WTuhqKQ+0/fwHjW8S8T2aspo
	b3VD1eYnlRaWQZYCIdFu+zfvQxc4AiY=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C96954C376;
	Sun, 19 Jan 2025 06:05:46 +0100 (CET)
Date: Sun, 19 Jan 2025 06:05:45 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Marek Lindner <marek.lindner@mailbox.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	=?utf-8?B?UmVuw6k=?= Treffer <treffer@measite.de>,
	Andrew Strohman <andrew@andrewstrohman.com>
Subject: Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link
 metric
Message-ID: <Z4yIKYsFvLyGpmjt@sellars>
References: <20250118003528.6843-1-linus.luessing@c0d3.blue>
 <CAA8ajJnqXBuUmBzAHVjyEchD2CU9E7SmqJXXvy0V7QAQF9536A@mail.gmail.com>
 <6131569.pqZb4hCDXM@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6131569.pqZb4hCDXM@rousseau>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: RRGHDFSGTKMROUVFMVQWZKSDQVNBAW6E
X-Message-ID-Hash: RRGHDFSGTKMROUVFMVQWZKSDQVNBAW6E
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RRGHDFSGTKMROUVFMVQWZKSDQVNBAW6E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat, Jan 18, 2025 at 05:59:56AM +0100, Marek Lindner wrote:
> FYI, expected throughput and also 802.11 throughput estimation are taking 
> congestion into account.

Are they? At least in minstrel_ht_get_tp_avg() I don't see it:
https://elixir.bootlin.com/linux/v6.12.6/source/net/mac80211/rc80211_minstrel_ht.c#L500

And minstrel_ht_get_expected_throughput() uses
minstrel_ht_get_tp_avg():
https://elixir.bootlin.com/linux/v6.12.6/source/net/mac80211/rc80211_minstrel_ht.c#L1987

Seems to me like it uses the transmission duration of the chosen
WLAN bitrate, multiplies it with the average transmission success
probability on this rate there. And then also factors in aggregation and
cuts off the thing between 10%-90% of chosen rate.

(Also, for a rate control algorithm I think factoring in congestion
would only make sense if the RC algo were also factoring in the size
of the packet to transmit? That is smaller packets have a higher
tolerance to channel congestion. But in the debgufs rc_stats table
I don't see any column per packet size (ranges) either.
I think Minstrel assumes that congestion does not make a difference for
which rate to choose for the sake of simplicity?)
