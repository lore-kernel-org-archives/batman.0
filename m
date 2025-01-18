Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9313C02185
	for <batman@archiver.kernel.org>; Sat, 18 Jan 2025 08:25:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 126EC842E4
	for <batman@archiver.kernel.org>; Sat, 18 Jan 2025 09:25:30 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737188730;
 b=0qkZiVX/XqsV1uW/Zfyypc6SWfqQK39f+9vCYA9rIK/cmZPKlsIvXqmR0XP92Uk1OKT3x
 1DiNy1fvTgoCk5VXkH+l5h/DlPVjDxx+XnnOtAPK/6+7pObFu1OCwSWCH9/K/v9uu9I3sII
 Y5zfpG7Z3SP0+dKt+n+biD5BA4v6lLo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737188730; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GAw7W4ojRbl4GcrlOhx0WfOpwKrNAZMKKGVvpvBJWdA=;
 b=D4KcFQNPHcBKX7DQdksis4pUyAx3IfeM5Sv2z4I7fl5pNsJ575eFl1jC02LIOsXlGr7d9
 pLqqn5obO3+RNMSGRMzDkec5ZOvV4Yshm381ry0SzcmxYcnvWQp+/CS/eEbHJPHDIf0iOpG
 sg3nh8++OOm9mbnThrSyVWUCrR++XzM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=mailbox.org
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4616F81707
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 18 Jan 2025 06:08:11 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737176891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GAw7W4ojRbl4GcrlOhx0WfOpwKrNAZMKKGVvpvBJWdA=;
	b=LuNTFyaaXAhulJPPtsu4ns+DHqEOLSKoXo+kYW/8nVCHLEY6/lcRXY+D+imqrQIckv3CcY
	e1VITc60G1Q8XYPL/3JmRYy/5gaD7G0txwL+WWEhyA4+0Ipctq2y5LbMm5EC/mh71M+UUe
	+nn5NzY5Ijl57UyStEePezRS/napI0s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TxiM8elc;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 80.241.56.152 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org;
	dmarc=pass (policy=reject) header.from=mailbox.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737176891; a=rsa-sha256;
	cv=none;
	b=dWygxUvFgFbM914y3XavCM3N/ZDu6zCqkFo9epBLZnVp+u5z32SlqxdQuXEzw5jM2dnE1p
	fkCYGZi8oA6M8nBbAUru94JSEAqR4v7aZC2l/g1k/rj1r5XDZ9BGAFv+STK8bZQ0CyycIn
	zaz5GHKbSri8uYAUFGh837VCr4Jt2NY=
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZl3s0gJRz9svX
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 18 Jan 2025 06:08:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1737176889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAw7W4ojRbl4GcrlOhx0WfOpwKrNAZMKKGVvpvBJWdA=;
	b=TxiM8elcDUpC6du+FUpdsNV/AepRwRlbdynV5wECxSwMHjFYpnzTXRyAu3M+R5rm0KQoKn
	zI94ArM7Kwc9uBTpRGMBHOHitvwmgy1pXvZhGZ9iFiv+Xia6lD4/dDVHhTuKH0zOzYon2T
	zJq44VUNTGq3g9EhCRP03Igq0r4n0Liw/7PshWCt4Fi2lk+4LOTx49cqblD88vzEbWleLV
	a1M6h/i3afAbE1j28C2EkeA1oCX525rU/kPFyVqni7S2dofEBuqe2A56W8bBPn/awiIaXr
	HgNNGq1JBYWEGNM06Kq74VoWLEmyikkedqzeWVhZK4Pe20p0vFgMChH3BlpUTw==
From: Marek Lindner <marek.lindner@mailbox.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link metric
Date: Sat, 18 Jan 2025 06:08:05 +0100
Message-ID: <5954293.xXo6FtjLZv@rousseau>
In-Reply-To: <20250118003528.6843-1-linus.luessing@c0d3.blue>
References: <20250118003528.6843-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-MBO-RS-ID: 646667e9b2db55e7031
X-MBO-RS-META: 7fzmmuyrx4jcyqubgeqad8o4k9ngzrxp
X-MailFrom: marek.lindner@mailbox.org
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: EFLVD234UQ5QFXFFYRD6255XTIMSWRSW
X-Message-ID-Hash: EFLVD234UQ5QFXFFYRD6255XTIMSWRSW
X-Mailman-Approved-At: Sat, 18 Jan 2025 09:24:35 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EFLVD234UQ5QFXFFYRD6255XTIMSWRSW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Saturday, 18 January 2025 01:35:27 CET Linus L=FCssing wrote:
> When no expected throughput is available then HWMP keeps track of the
> average packet delivery error rate and average phy rate to calculate its
> own expected throughput value.

Is this also the case when 11s mesh forwarding is disabled?


> So the 11s airtime link metric should be a slightly better estimate than
> the expected throughput provided by Minstrel. And should be significantly
> better than our raw PHY rate divided by 3 guestimate fallback.

Have you tested the airtime metric in real world setups or what leads you t=
o=20
conclude that 11s airtime link metric is better than expected throughput?

Generally speaking, I like the idea of adding another link metric source.


> +static u32 batadv_v_elp_get_throughput_from_11s(u32 airtime)
> +{
> +       const int tu_to_airtime_unit =3D 100;
> +       const int test_frame_len =3D 8192;
> +       const int tu_to_us =3D 1024;
>
> +       return test_frame_len * 100 * tu_to_airtime_unit / (airtime *=20
tu_to_us);

Are these values constant across all platforms and drivers?

Maybe there should be a function call to an 11s function doing the conversi=
on=20
and handling all cases (instead of doing this in the batman-adv code)?


>         struct station_info sinfo;
>  -       u32 throughput;
> +       u32 throughput, airtime;

The Reverse Christmas Tree style should be accounted for.

Cheers,
Marek



