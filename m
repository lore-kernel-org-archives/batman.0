Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CD01088E5C
	for <batman-adv@archiver.kernel.org>; Thu, 19 Mar 2026 00:50:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B546585600
	for <batman-adv@archiver.kernel.org>; Thu, 19 Mar 2026 01:50:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1773881443;
 b=d4tE+94sOtN+wDJCNfVVeknFjxms8CjynYFcAY9WYk8iT3/oeS0BVnmjkWr4y/EaBzTbo
 9NAAY1yLuAly3HKVNg0fQ8Qa6GRWuiPubykFJ0kDf3VWp4sA1jGAIHWFgT2e78ypdXwdkwI
 hfTf8TlSIepLec9pS4ECJUCO61xO+Bg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1773881443; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ega4L27UBVxGCNGqNWh0YNIXEat3fnjfMirbCjMX8Wc=;
 b=kaRmvlNbCTU9M/gkHPR16jKDYMzCbXNWEuse/2qYqOmN6KMzjYMVuO6GeSB+EBpzJt2qX
 wwwt4hs1JCf2/L57RvSi5mv2510b3qauKaHwxkT4FVVJuXYa/oVPMpn0497UFhuYf77YzEZ
 ncC1A8XbJLjpokv1QXm8T54ZBzuK7Xg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 514EE84746
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 19 Mar 2026 01:50:16 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1773881416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ega4L27UBVxGCNGqNWh0YNIXEat3fnjfMirbCjMX8Wc=;
	b=MchttkUE/gdS6YuS3S145AdeAKyemDEFQ0SjloG2mYkSqahBHaiVsQ03dh4FLn5HH1iQIe
	Q7LpNhEku6I1ovDO/awG7FW7rZS1HAwpd8xEwLvdrsD98CVagKuCtOH+/mmqDX0r9K/a9U
	5quJZEALdyCorF6Z/KNJvi5Wp6Ch5kg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=HJYLeSb3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1773881416;
	b=IfjrWRK5yiHff/nZmo4hcdso4wBbY6cVxsMAzrJmZdTU/xUL2rsVvfx07X4CUR0N5xGc/x
	JViahMVMwS79OVlLwOT+JGicY7Y4Ewoy4KGmUBJCPuhAD75UorLyAljKysIpUz1tHLbUCu
	uMvBCj87+u6uRIb5Fbq3HNkodL1Gov4=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B15E401DD;
	Thu, 19 Mar 2026 00:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77EDC19421;
	Thu, 19 Mar 2026 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881413;
	bh=zVSPhyCN3HbYx/+zS8Jfh3txHDqhUdsmp5XEI4vKPxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HJYLeSb3Qctac8TOmNF1fAn23HOhFKSi8Do0r/T8SKNAsdZ1RTY5Gy8jN3e3bJGdu
	 mRsTbN6wEIqIhjGCf8/0VBNiA9cqow0jj99tM4Rf+pnZMFiKkyUrud1yJlTAx0qdtq
	 pY5TgBBGclYnwaeFoDKO85n4h/0pqtfCLxPqOeiIfCbF0wIb5nrlsLmL3Pl4pwx/Xk
	 4w0dW5GC7m+2jdY/zThw2G2gP+BA+TqV6285NnqDH7sSHWnv+Gb4zVq4bgpJ5NzvSH
	 iqD+EyqOHpv5usvkeR6ZYE7BenDX7gpwzS2xKvJp4XGbl2t7xQZIN+kqRxsznho2q5
	 6F7N4EI1wb9EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D1053808200;
	Thu, 19 Mar 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: avoid OGM aggregation when skb
 tailroom
 is insufficient
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388140529.969605.9189456516645267942.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:50:05 +0000
References: <20260317160002.1869478-2-sw@simonwunderlich.de>
In-Reply-To: <20260317160002.1869478-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, n05ec@lzu.edu.cn, stable@vger.kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, tanyuan98@outlook.com,
 bird@lzu.edu.cn, sven@narfation.org
Message-ID-Hash: FEMLYKRRLDWQSVMK6P6VBMQFLTQ7UTJJ
X-Message-ID-Hash: FEMLYKRRLDWQSVMK6P6VBMQFLTQ7UTJJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FEMLYKRRLDWQSVMK6P6VBMQFLTQ7UTJJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 17 Mar 2026 17:00:02 +0100 you wrote:
> From: Yang Yang <n05ec@lzu.edu.cn>
> 
> When OGM aggregation state is toggled at runtime, an existing forwarded
> packet may have been allocated with only packet_len bytes, while a later
> packet can still be selected for aggregation. Appending in this case can
> hit skb_put overflow conditions.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: avoid OGM aggregation when skb tailroom is insufficient
    https://git.kernel.org/netdev/net/c/0d4aef630be9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


