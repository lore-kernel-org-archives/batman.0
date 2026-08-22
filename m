Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BADEC5DF8C
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 20:01:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9F4F483D16
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 22:01:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787428892;
 b=qfKaBuc8FatI1RnFACqitb54nsZUJhZprj4NziOUiTCB5R0NLbCdlH7ioiL5Scqkiupsm
 bVT2u3k5hCH4LuoMs7MdHQ29wBFHkYi3FqCmpcvtef71axK9CzUuWMmM9xsrbpD4luTdwld
 pvlhYk9fX3xeItde02BCLhKHSj/EWnY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787428892; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rG7xpvk/jI2Cf5bJb178qqtyZfjMEvbfQkdsZyaDBHQ=;
 b=TQl+AQdkjomHVv0CYsCm1woSvpMrjlu2iASjw9Niaz4ubrw4zzvz+SJpn6p4NIm3OXg8q
 U5lAQkQ6GpweZQeO+ZBSpR35I3yZFvfeVmeKD2C3y9jELRI3jOP1+iwUmy4KfWcoWegrBgt
 XXBgWRgrdpt55E6eUM9ZMLlvSNQ3kcQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7D60481D9B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 22:01:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787428884;
	b=MOdDniAnQ7vZfTSXJYabR1DDHd3DajWELJ49SJrp8umGTjelbTO/GXugJTHcTRmby3J0rz
	F812Wz1dltDZZDJDbeT19HWSG0/oQI2gmFcBa2xQmeUymbRoLr/11IZmBiZa7M/sNMbt0p
	4b+H48QcUd4u8clOx2x/BpR+9onR8Lw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787428884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rG7xpvk/jI2Cf5bJb178qqtyZfjMEvbfQkdsZyaDBHQ=;
	b=VmNKu17cn3aQ88kDriLmbYHNUFNM6rfyh3SAXti2QAgfBRqPbM8s34SQYi6Lkku7K6vZx8
	uuLh8rZyxTAwrNmL7MdaiEZD6e5i7INT95To5HMSOcb0jAGK1PnAlsx8QvLQ+Kk7upikK/
	7B1eFbKiw0cjuykDxujAS4RK5zKjtW4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SkpqrcOt;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.105.4.254 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 236DB600AE;
	Sat, 22 Aug 2026 20:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE3F1F000E9;
	Sat, 22 Aug 2026 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787428872;
	bh=rG7xpvk/jI2Cf5bJb178qqtyZfjMEvbfQkdsZyaDBHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SkpqrcOtFGGlPgvuriGNJUclqSNUop5rJRa0UxQ5cDp/CMj36GZqoxckjNCQJmzTU
	 HoCOL6XiRLA9ugOy//F77ETKiMNUU/nSWSXbmtMhSwkOkGORZ6QN4tmAnXWHtERZRK
	 NX/UAJa/YQlsBxAtRCjAcEc02GVAC+5vPYcwcnQPv/EG0V+d0PYTM/M4JHtWzDW4gW
	 ewgzz9Ua2lQXHe+kFWxk4/+wAj4lLKBqIfxnThvH6m+PgGhkFVMhcAm+FTm2X2TJ+E
	 3ldI/8sn/Ti+cKv8AVfFyL38bTFJeiFxhzE2UDz8SlDC4gDLI8yQOFyknK+DW+/WGJ
	 tHufXzJaucHew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A40380CEF9;
	Sat, 22 Aug 2026 20:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] batman-adv: fix stale receive device on merged
 fragments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178742882155.1812309.6129874703667132966.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:00:21 +0000
References: <20260821094813.201800-2-sw@simonwunderlich.de>
In-Reply-To: <20260821094813.201800-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, zhilinz@nebusec.ai, stable@vger.kernel.org,
 vega@nebusec.ai, sven@narfation.org
Message-ID-Hash: T6NYZP3BHWED5R2VNVI7DQNRJWSG76X4
X-Message-ID-Hash: T6NYZP3BHWED5R2VNVI7DQNRJWSG76X4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T6NYZP3BHWED5R2VNVI7DQNRJWSG76X4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri, 21 Aug 2026 11:48:05 +0200 you wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> Fragment reassembly reuses the skb from the highest-numbered buffered
> fragment as the merged packet. When that fragment was received on a hard
> interface which is deleted before the chain completes, the merged skb can
> re-enter the receive path with a stale skb->dev and skb_iif.
> 
> [...]

Here is the summary with links:
  - [net,1/9] batman-adv: fix stale receive device on merged fragments
    https://git.kernel.org/netdev/net/c/ad46c907d7d9
  - [net,2/9] batman-adv: bla: avoid CRC corruption due to parallel claim add
    https://git.kernel.org/netdev/net/c/08645ab95768
  - [net,3/9] batman-adv: bla: prevent CRC corruptions after claim flush
    https://git.kernel.org/netdev/net/c/89f3502ff687
  - [net,4/9] batman-adv: dat: avoid unaligned fault in IP extraction
    https://git.kernel.org/netdev/net/c/0121afa52cdb
  - [net,5/9] batman-adv: dat: atomically update mac addresses
    https://git.kernel.org/netdev/net/c/e6de568d3eda
  - [net,6/9] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
    https://git.kernel.org/netdev/net/c/7aedb59b8099
  - [net,7/9] batman-adv: mcast: ensure unshared skb for multicast packets
    https://git.kernel.org/netdev/net/c/82bf207f48eb
  - [net,8/9] batman-adv: mcast: linearize skbuff for packet generation
    https://git.kernel.org/netdev/net/c/6a30a59e2660
  - [net,9/9] batman-adv: bla: fix freeing of claims on meshif deletion
    https://git.kernel.org/netdev/net/c/8d128c932bce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


