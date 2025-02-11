Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC97FC02198
	for <batman-adv@archiver.kernel.org>; Wed, 12 Feb 2025 07:23:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CF2918403D
	for <batman-adv@archiver.kernel.org>; Wed, 12 Feb 2025 08:23:42 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739345022;
 b=GWEPnYS2/4G0iQxtfWYVAw29NnmjEmoU0BsuGJQEW7tweVf65GX0r4Vy6ziScOJniIu5R
 6koA1X0h057skNrZipQS5QTrcvaEcpkokD5+l6uRbQwGYHGxxHHN2Pgl79va1XxOVEZ4eMp
 hgL2I/QBmc3IwZt5jT46qAKMOIs9hxk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739345022; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sZitVG8EuwIFP7zpAgEEUiRhghinUbWzjJuyQ+/7cDM=;
 b=3fh9H1ISyMR001Y7pMl/r1ztaLQbe3mk2GzQmFLrgiMNuZ/N0mWInbMp26tyMRrlBYx6T
 /+wIe0w7eh/f3KZZIQXrJo5pOwdntRrAzeTv5q+txfwmc/cgsEM3s/fBScvVBvxU/PYqGj2
 SwkIxyDUq3bckmOZdt2rsmQsiD1m50w=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6FA9B825A5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 11 Feb 2025 10:50:05 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739267405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sZitVG8EuwIFP7zpAgEEUiRhghinUbWzjJuyQ+/7cDM=;
	b=IjdJA5c4TADDn7+pNBIbLiHjpZ4mREVz2FnPUfwCpcn8mlfCJMsLZWG9SyBteyULlacfQY
	I1vOS0ltijUc3pNeX/Lr09a+dyXx+NX2KKFuOEMPNm6/Qix1fBnj3A+6JTn6CS5UsZy9vk
	lLLF/5r5UIPNnDJUS+1UfkQA3CAB5aM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="Qs9D4/+P";
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 147.75.193.91 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739267405; a=rsa-sha256;
	cv=none;
	b=MF0+U3UKUFFQLJ/Mr79Q8TnD36+h48evQCf6qePcZ2dVqbCE07vQdagiEhbBlipBU3MQwU
	yH3e8tpBM7k+65q76V8s8TdidiCOkogUgWH5hnfFyMN96PMHj8leBNEnntujw2G2FJ/P8h
	JeEHLH+KTo99WjD+fPW+ySZsns4WA9E=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 568CDA40171;
	Tue, 11 Feb 2025 09:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D666C4CEDD;
	Tue, 11 Feb 2025 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739267403;
	bh=VgBAiX3yNRVQj4Ge3DZC3LmymGMdpfvflsm+T+703Ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qs9D4/+PrEau59CsLC5BcwrH3Lq3LmW7Oa/lcXEbNN5eDlecIvaoMIEPT/fMhgggQ
	 YA5yA2ktcOLuBzeyBob1vQbCmJ3SP8gTswW7IY51qXLYf7JpAk19j+kkjh1i81uGx0
	 Ufvk0zv0lkYxhIZIfYWf5g74XlwOfINH8QzjHgcrs/RvCeLojvAHDofV3HW0fjYxei
	 0dhn3ZqoZkt3haqrRDMqjZ4EOsYwprMVdc3/hvUVa88mV0XjSETcJliIfrBfq6awnl
	 Q18oUHW9iZWifZ4YoKjxKnoKWaN8nqfchj3RlgFDCP6rr6i5z67onZNl1XIGx0bChT
	 dd98573PFZ2Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70E49380AA7A;
	Tue, 11 Feb 2025 09:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] batman-adv: fix panic during interface removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173926743228.4012981.3770708336571072464.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 09:50:32 +0000
References: <20250207095823.26043-2-sw@simonwunderlich.de>
In-Reply-To: <20250207095823.26043-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, andrew@andrewstrohman.com,
 stable@vger.kernel.org, sven@narfation.org
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: DAXJPJDGH63SXUBEGPV27TDUOE24TVBJ
X-Message-ID-Hash: DAXJPJDGH63SXUBEGPV27TDUOE24TVBJ
X-Mailman-Approved-At: Wed, 12 Feb 2025 08:23:31 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WNV7U2OSYIDESIUKJ5J4EBFJANSYEOJX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri,  7 Feb 2025 10:58:20 +0100 you wrote:
> From: Andy Strohman <andrew@andrewstrohman.com>
> 
> Reference counting is used to ensure that
> batadv_hardif_neigh_node and batadv_hard_iface
> are not freed before/during
> batadv_v_elp_throughput_metric_update work is
> finished.
> 
> [...]

Here is the summary with links:
  - [1/4] batman-adv: fix panic during interface removal
    https://git.kernel.org/netdev/net/c/ccb7276a6d26
  - [2/4] batman-adv: Ignore neighbor throughput metrics in error case
    https://git.kernel.org/netdev/net/c/e7e34ffc976a
  - [3/4] batman-adv: Drop unmanaged ELP metric worker
    https://git.kernel.org/netdev/net/c/8c8ecc98f5c6
  - [4/4] batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()
    https://git.kernel.org/netdev/net/c/f4c9c2cc827d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


