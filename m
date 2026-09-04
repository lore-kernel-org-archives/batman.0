Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1885C624D3
	for <batman-adv@archiver.kernel.org>; Fri,  4 Sep 2026 22:52:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E5D82841C4
	for <batman-adv@archiver.kernel.org>; Sat, 05 Sep 2026 00:52:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788562339;
 b=Wz2TkvNKATN3WavqcQsTrS4RikMG5t3pE8Qj8ctaEcFjvyJM4gTWGwsgDHTnMRSNTucV0
 fPtdw9POVKlKJ5310mfnNdsZQSkdLlsJLSXWWq5z9iS5rctEyisbwq9djEPjd/9HFPilKST
 5d53vKWXnJhivfK0WQrBKvfeeweT6WY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788562339; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=48YAXpM6+cY7H6sQpzfemiGImqwpsxdBm2ZoqTJCilU=;
 b=hmpkIKL7IdhgZOoQJexbJXXdUoK5l2Dv4sY3u/xi0uVv5LAMK62zwJbkY80Q9XqH2rTs6
 mIchMLf+SCSahKdAd2HoubTxfMdwAu/URALJGgD+63dtmAc6geGcutMOdv+UAWx2cvMH1HE
 SJwJVGzbAODxfzjxJq6gT51R2uDNln4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EBD1A81465
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 05 Sep 2026 00:52:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788562332;
	b=b8FaMDhd+Od9/N0VATRR6diq+7SWvRDuQDRR8lGiAFf3UgFhDBN6lO7cnWrDC58RNHE0u5
	LIqoT9TViEOggW7IaxD8DkOAhCy6kJEIYp8upsTIVW1lOipdDXoYIrVXikUPo+qyXHOigp
	tO5XenWQWZhROkBSguX5TWaIN4U2Fr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788562332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=48YAXpM6+cY7H6sQpzfemiGImqwpsxdBm2ZoqTJCilU=;
	b=qF0VEwavxXd62cVgwKe4miKLFgEAd0H3ANGtKrFu0bAoT7uuVI25Qe6Zugrg1uOHaBVpdn
	Se6WeYyunz984yA9VLmHsJYfaaecoz0gvGUINPrD0tXC5l664F6FDPhTf1715Br0t0p0GT
	AZC7ak+IV4gyOKXKacNefgFQyG/sgtE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E7+x96nX;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B3AE4375E;
	Fri,  4 Sep 2026 22:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD551F00A3D;
	Fri,  4 Sep 2026 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562320;
	bh=48YAXpM6+cY7H6sQpzfemiGImqwpsxdBm2ZoqTJCilU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E7+x96nXuQ3GmMhoezOtH7UmPwejXhIQaJ2A0mD44WOZbbCpDBJmyifeqHmrtqada
	 N2vo5hXbyHvbhXq5XDyp1RaeKSBVyTjSG/OqF5k4N9PVPnrLDu00dyNsPos+co4ujV
	 319ZYpoQq8BFfIHtHx7WHZrK6/NP4v+kDz243O1t59mwXxx9gTvJ9nT0H6cDDNncEM
	 vRbaY1O87MAAHrT+BT8RNISpKQOcngh4EcV1LmIir9gUzvCv9aOytJ4/bQJiNAiWPg
	 /YHtEQyx6qoLGGP36FtxJi/nDxB4X7DF4HeJJ6wGTOAXcSTyEUECxmrUjJMUnvhzdl
	 mflos4VPtbxLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 199393924A7F;
	Fri,  4 Sep 2026 22:51:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: dat: fix printing of unknown
 4addr
 subtype
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856226064.1003513.4882624192828119251.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:51:00 +0000
References: <20260831135117.574836-2-sw@simonwunderlich.de>
In-Reply-To: <20260831135117.574836-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Message-ID-Hash: FDGRANECZZMIHWTKLJG2QUPMO5JXIPU7
X-Message-ID-Hash: FDGRANECZZMIHWTKLJG2QUPMO5JXIPU7
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FDGRANECZZMIHWTKLJG2QUPMO5JXIPU7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Mon, 31 Aug 2026 15:51:03 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> If an unknown subtype of an unicast 4addr packets was detected in
> batadv_dbg_arp(), it is printing the (known) packet_type instead of the
> subtype. This must be switched to the subtype to have any kind of use for
> the reader of the debug message.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: dat: fix printing of unknown 4addr subtype
    https://git.kernel.org/netdev/net-next/c/c6c8f1d693ac
  - [net-next,02/15] batman-adv: drop direction in _batadv_is_ap_isolated kernel-doc
    https://git.kernel.org/netdev/net-next/c/b963ee1dc32c
  - [net-next,03/15] batman-adv: bat_v: fix bonding candidate selection
    https://git.kernel.org/netdev/net-next/c/77f653e6f722
  - [net-next,04/15] batman-adv: clarify cut-off in batadv_v_neigh_is_sob kernel-doc
    https://git.kernel.org/netdev/net-next/c/7356a9232d9c
  - [net-next,05/15] batman-adv: use more descriptive var names for is_similar_or_better
    https://git.kernel.org/netdev/net-next/c/776c26254d24
  - [net-next,06/15] batman-adv: ensure u16 aligned mac address arrays on stack
    https://git.kernel.org/netdev/net-next/c/a5f7058bee1e
  - [net-next,07/15] batman-adv: ensure u16 aligned mac address in structs
    https://git.kernel.org/netdev/net-next/c/d9304a90eca5
  - [net-next,08/15] batman-adv: tt: remove only the entry which was looked up from the hash
    https://git.kernel.org/netdev/net-next/c/bbfb0d2cf035
  - [net-next,09/15] batman-adv: tt: extract code handling a roam on add
    https://git.kernel.org/netdev/net-next/c/fd8d892c685a
  - [net-next,10/15] batman-adv: tt: simplify NEW flag transition code
    https://git.kernel.org/netdev/net-next/c/e103fbefa049
  - [net-next,11/15] batman-adv: tt: drop unnecessary cleanup goto in helpers
    https://git.kernel.org/netdev/net-next/c/52d8c713f464
  - [net-next,12/15] batman-adv: tt: use protected flag modifications
    https://git.kernel.org/netdev/net-next/c/976b159b3c12
  - [net-next,13/15] batman-adv: tt: transition NEW local entries only under lock
    https://git.kernel.org/netdev/net-next/c/f59c4c59df10
  - [net-next,14/15] batman-adv: tt: don't uncount never committed clients on pending purge
    https://git.kernel.org/netdev/net-next/c/01ae63ecd1c0
  - [net-next,15/15] batman-adv: tt: decrement count for committed client on local_remove
    https://git.kernel.org/netdev/net-next/c/799152bcf6cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


