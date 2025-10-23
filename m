Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F66CCD1BE
	for <batman-adv@archiver.kernel.org>; Thu, 23 Oct 2025 15:15:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DA41B85276
	for <batman-adv@archiver.kernel.org>; Thu, 23 Oct 2025 17:15:55 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1761232555;
 b=Jetb+ikWKPMUmAkVqCK9IYLXZHmSuge8cQ3ZaVQgZxCr1DdxmVjCwGhpuzKdgsYXXRJXS
 DyW/keIayGyulnl5Xxhh0mSrFQ/mDb7jHEQtFjRh6xjAfE4ucWw6mD7EwbFGlrQ/HWC65Ie
 SSnqP4jYwMMKFFRTx2OJBQJYxXyPgM4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1761232555; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iSYTvOiEJIFGvoVk1JuQ23Z/+wuvbVxm9NIOYqpi2ew=;
 b=YUvp2u+0Rj1ZDLiCsNxCBm1Q4iAD++isNfKMZU6HeDZt3RzHl6O5LDUdh/lvalhFLLI4i
 86KPV7PncENRX2wZKErXnqfGTjCi032c9U3+3WPksYA1GEQG1Xe09ySksyvRHwGuvcqZQtU
 DXo4Rufw0XjiT5ECpqCPtLvO0GBxn2M=
ARC-Authentication-Results: i=1; open-mesh.org;
 dkim=fail;
 arc=none;
 dmarc=fail header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AD8298473A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 23 Oct 2025 14:28:10 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: Gateway shut down detection takes too time from other nodes
From: mbiglari4@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 23 Oct 2025 12:28:10 -0000
Message-ID: <176122249070.1493.7302683075039006895@diktynna.open-mesh.org>
In-Reply-To: <9767419.DvuYhMxLoT@prime>
References: <9767419.DvuYhMxLoT@prime>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: mbiglari4@gmail.com
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency
Message-ID-Hash: ZFUY5PESVII7ILNQUP2OKNDRNCKJAEC4
X-Message-ID-Hash: ZFUY5PESVII7ILNQUP2OKNDRNCKJAEC4
X-Mailman-Approved-At: Thu, 23 Oct 2025 17:15:51 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZFUY5PESVII7ILNQUP2OKNDRNCKJAEC4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear Simon,

I have a mesh network with three nodes that use 802.11s for the PHY and MAC layers, and BATMAN-adv on top to provide routing and mobility. Two of the nodes act as gateways, and the other functions as a client. The client selects the best gateway based on throughput.

Currently, I don’t have a DHCP server in this network — each node has a static IP address. The issue I’m encountering is that when the selected gateway node turns off, the client takes too long to switch to a new gateway. All nodes are using the BATMAN V routing protocol.

I believe this delay could be reduced by factoring the last connection time into the throughput calculation. For example, if you’re using an EWMA filter, you could treat a node that has been disconnected for more than 10 seconds as having a throughput of zero. This would cause the EWMA value to drop quickly, allowing the client to select a new gateway sooner.
