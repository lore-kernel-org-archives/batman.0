Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC887CDB465
	for <batman@archiver.kernel.org>; Mon, 16 Oct 2023 14:25:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0EE5582EF4
	for <batman@archiver.kernel.org>; Mon, 16 Oct 2023 16:25:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1697466301;
 b=aaLNDqpvwKHs9ETM7zBC6Wx7nB6ryAUyOt4kZzdC30llJZ0TPHogmPZwwd98yuv5CeULr
 qvaSvbz/Cz6eax6/c16KDkW4di3zeP3l2o947TM4NQJlGMuQ31R6cmIiamUnwAZ12HCTJSW
 /BFikeWlvqzDY1y4Txb84A9FthsungY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1697466301; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gN1VypSqcdv9EkwiIq7lXfJheXJg/aKtALIyGCZKL8w=;
 b=uLcTknFOciQI8H1e4rOlhrDFNfj0GgAmjF4VSFpry1O+mNNj37NfV856E24QcJMGUlcfD
 68ar4z8LVI6W5OQQEc4XT+mYSItnps2xgPMihGJ5zBO0542OC7IZ6g+lcaEhPw26JDi3MMP
 ikpa5Rt9iHDoyF7A05Qif+jxVjaOtYs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7EA1880038
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Oct 2023 16:24:39 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1697466279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gN1VypSqcdv9EkwiIq7lXfJheXJg/aKtALIyGCZKL8w=;
	b=mnbaj8Ljt6AVQWWVQWS/zJ2oG4BliODkVW1TSaoYai6n+6Qf7Pe1AFm/CrpQlROVI16Q2B
	0bplbkJXfR7SOlzSVckUw3gDe2OaPJDkgpQmxp1X2I1HKDwLVtJivAYuEK5Y4ukxA6bPnH
	JwPljEG+X5K2fXu7s6GqeN2wkEsckjg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1697466279; a=rsa-sha256;
	cv=none;
	b=ee5nko/4sIhuzGZNR6kGAcZcXUw4J+kk8RZUBfkiq//kPIr1jkVSMrdb2tbhiYNM4oJJKS
	m51itC8w6pCnQ0MkT3qktbWCbKhgZQHuuwS8lBXMii1UFKNcmO0SBK0VJ+IIYzIQkpYc6K
	KYXBoOBRirGTo8sheTQ8Z29AMoVbRyY=
Received: from prime.localnet
 (p200300C59716E7d872D6097B395B7873.dip0.t-ipconnect.de
 [IPv6:2003:c5:9716:e7d8:72d6:97b:395b:7873])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0847BFA2D3;
	Mon, 16 Oct 2023 16:24:38 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: "mareklindner@neomailbox.ch" <mareklindner@neomailbox.ch>,
 XU Yang <young.xu@connect.ust.hk>
Subject: 
 Re: Inquiry about Communication Issue between Nodes in "ONLY two nodes mesh
 network" with batman-adv
Date: Mon, 16 Oct 2023 16:24:38 +0200
Message-ID: <2197854.1BCLMh4Saa@prime>
In-Reply-To: 
 <OS0P286MB0116B77E8A851D552949A43CBCD7A@OS0P286MB0116.JPNP286.PROD.OUTLOOK.COM>
References: 
 <OS0P286MB0116B77E8A851D552949A43CBCD7A@OS0P286MB0116.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: TKY26J3272UONGR33FY76VABFGWPXBFW
X-Message-ID-Hash: TKY26J3272UONGR33FY76VABFGWPXBFW
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TKY26J3272UONGR33FY76VABFGWPXBFW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Monday, October 16, 2023 4:12:41 PM CEST XU Yang wrote:
> Dear maintainer,
> 
> I am a developer currently using the batman-adv library in research and have
> encountered some issues that I hope you might be able to assist with.
 
> In setting up a mesh network using batman-adv, I've noticed that when only
> two nodes are present in the network, they are unable to communicate with
> each other. However, once a third node is introduced, all nodes can
> communicate normally. Further testing has revealed that even with two
> nodes, despite good ad-hoc wifi connection quality, the nodes remain
> invisible to each other.
 
> Here are the system and configuration details:
> 
> Hardware: Jetson Orin NX with rtl8822ce
> Operating System: L4T r35.3.1 Ubuntu20.04
> batman-adv version: 2023.2-9-g5fecd4a3
> 
> The configuration code we use is in the attachment.
> 
> 
> I appreciate your time in reading this email and look forward to your
> response. I hope you might be able to help me understand the cause of this
> issue and suggest possible methods to resolve it.

Hi Young Xu,

this sounds like a underlying Wi-Fi driver issue. You may want to set up IP 
addresses on the base Wi-Fi interfaces (e.g. wlan0) and try to ping between 
the nodes directly, without batman-adv. You may also check further with "iw 
wlan0 station dump" (or similar) who receives packets by whom, or check with 
tcpdump if you see the OGM broadcasts.

I haven't seen many Realtek Wi-Fi devices to use batman-adv, and at least in 
the past my experience with those devices not very positive, so also for that 
reason I'd look into driver related issues first.

Cheers,
       Simon


