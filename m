Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D6FC369A6
	for <batman@archiver.kernel.org>; Fri, 11 Apr 2025 00:40:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 94949842AB
	for <batman@archiver.kernel.org>; Fri, 11 Apr 2025 02:40:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744332029;
 b=hdYaNBktclxD6XdRWmO1CY9mKkn2YdIM0blwpMFf0uI6+HNxzLrEdvLRu6P0OBys8U707
 YDR+TjddATUPnwoZrlsah3GvsQQETJiQlqq7mh2y0rvDFy/IpW/KjbRTXmhuj1FzxVzK3UT
 wVa0I4mG5I4aWvOdGqRI6Wmwcu+OLyE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744332029; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SxbOhmer7D4ga/L9P3QOR2OQSO21NRLCh9hqahVXou4=;
 b=C2cuInpbLPinsCpnxy7mrATdmB6BDCgXlrxqiGNgV1OriGY22cC9H0bwbngJ0o1wCkMuR
 QnxaGL7yTfVplC1TPZxbCEabyyPLxeUOR4AQ2hA3E+bkteGd4UYGy4bbsI4h70Wn84085y5
 hFW9n0vFzXkwzLSBF6izaf21INRs3BM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3079180F86
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 11 Apr 2025 02:40:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744332013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SxbOhmer7D4ga/L9P3QOR2OQSO21NRLCh9hqahVXou4=;
	b=ccUqC01cg8ErorzF7AKBsngVWyEId1ClMxA34skxljHvkpqBNIv+i2gYlYYWnonckHH3Lo
	Eg7/lmxxqWc+ZZ5qB49CZFbS0vAZkBPxHEOvqfYC6rChtH9P7Y634Mm2z+hSgFekKfNpB2
	k0T0OKVvF2NtjZp/uzlUeI8RHRy3qCc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=JRJ0A6Aq;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744332013; a=rsa-sha256;
	cv=none;
	b=vV+eqAmOzAfDnnACFwuJWExHmFiZ8rH3yqSLpECUwWVJJJ7xie+TtKRpON0xbqw3ZLFxBl
	6v6L0vY4yKASU5CuIOxq0eSsn5TJ++ERlVQjCRMjoy9ifmXa4K99e1bFYSTCRNktE/q1VB
	I3/lUfp8o18xSG3xmFbknMeMRmzUutQ=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5159244958;
	Fri, 11 Apr 2025 00:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AD6C4CEDD;
	Fri, 11 Apr 2025 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744332001;
	bh=mnGvZiGOwOCpuDiXn5hOB8Yy8cepG2SDp5Tiv7JDr/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JRJ0A6AqKkGwhN4xgL14GqSP1uApNcmBPrL/HFY33SNa2VOjr0AdE+KzIgkvmy/iO
	 KZlE9cB57mO21kKZdYMQoQZ5OW1LRwlcWpSrCsZ1fjit4sjyXauHcor6uIF7zybyLV
	 ZDfFlgh9PTD0f+EmC1dh/D0qC5gbRyQ45h+79O2QdIKfScmfv/ssZuX4Yp4NsbFuy3
	 UBBqobzkdqfQe6Ik1KJ+BKvJYcvDF283SzBH4vHICLC46ieoRHyfdyfKM9pAvNnl4h
	 znIV/43wdm69/9RO8BZyLfNfhXnacVCR+T/c2qMHZG8JtO1fFysk1c/yFCDqTjb/nB
	 4spvJXSUmd15A==
Date: Thu, 10 Apr 2025 17:39:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Marek Lindner
 <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>, Sven Eckelmann
 <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] batman-adv: fix duplicate MAC address check
Message-ID: <20250410173958.788611a1@kernel.org>
In-Reply-To: <94e1ac2c-46f1-4787-ad50-e4a5ab11011a@universe-factory.net>
References: 
 <c775aab5514f25014f778c334235a21ee39708b4.1744129395.git.mschiffer@universe-factory.net>
	<0c288b2e-9747-4a50-a16f-bf4238829ffa@redhat.com>
	<94e1ac2c-46f1-4787-ad50-e4a5ab11011a@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 3LA2P4H5QDN6UOBXSZRKMTTDSITRAZWS
X-Message-ID-Hash: 3LA2P4H5QDN6UOBXSZRKMTTDSITRAZWS
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3LA2P4H5QDN6UOBXSZRKMTTDSITRAZWS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, 10 Apr 2025 17:38:30 +0200 Matthias Schiffer wrote:
> >> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
> >> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>  
> > 
> > Even if marked for net I assume this will eventually go first via the
> > batman tree.  
> 
> Yes. Should I have marked this differently?

Yes, let's reserve net for patches which will go directly into:
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
Similar for net-next.

The tree name is supposed to tell the maintainer who you expect
to take the patch.

The batman tree (according to MAINTAINERS) is called linux-merge
so let's ignore that and use batman and batman-next?
