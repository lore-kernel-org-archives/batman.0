Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB8C369A2
	for <batman@archiver.kernel.org>; Mon, 14 Apr 2025 18:08:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 809B8847AD
	for <batman@archiver.kernel.org>; Mon, 14 Apr 2025 20:08:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744654104;
 b=bowIh1UaH+F+l7nONN9rzpOIMbtdNE19cYH4ZE2vUn61xyDRukyvQM0Bz64OGysPK6uI4
 hzquWDeuvKYrnv2mdFhCOloX608KARlVPJzNXSupoc7atlIgXchiGoUQtaa2lwzmX63i9NB
 u2e0hjUuNYKBygzBTgH+bVIE4yK9y98=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744654104; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ore2h7sZOyoYEG4C62YqwDZEFQDa/Mcv8WyUAUTbahM=;
 b=rVFKpuzDCfTQNXfgK3jLAWg+N7O39ghGrkf9gMoQMjZDtv7zykVj+K/fh6NUT9sOs7b2C
 t2RRWQ9Yhz03YYbyW0NkslafUas+u6osCUktNPIWxVFtDqczWiPtuHRyYTNunmmYzaF9LL7
 buqgivqiCROl3iap09dmyMWWsNs9Hvc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7A9D984221
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Apr 2025 18:55:29 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744649739; a=rsa-sha256;
	cv=none;
	b=RKg9xdX7+0FKkVQ+nFjM4u51UJKhpaxhU1QjpJbUBhMB1HpZfzYwV9GqofTe1gyNXsg3GP
	+ea/rMS487hDGBulfql3r9JIZL7G8G4u4O6hNsM8DhNeaewNxHa89fTp/oJ7y549OcMuhq
	eCy3ymJdj1PNJw7noHHBRBn8H/vd4Jc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=VsoRwWB1;
	spf=pass (diktynna.open-mesh.org: domain of horms@kernel.org designates
 2604:1380:45d1:ec00::3 as permitted sender) smtp.mailfrom=horms@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744649739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ore2h7sZOyoYEG4C62YqwDZEFQDa/Mcv8WyUAUTbahM=;
	b=zFC2Ppo32mJgNeLUrwiorJWGCnn5XuLZyuD284H5dgqR54w9FGPTGCOiLJxcpCiHUSu2YE
	MhlagRQOblqoBQidhWL/JFUELaV3nhLBCHcB5MvGSq626DKzgels3tzjHOKS3tDrFIusMN
	QyfBmtWsRBybCQcwwX1FRypxJR/S/e4=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D003CA49F4E;
	Mon, 14 Apr 2025 16:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407D4C4CEE2;
	Mon, 14 Apr 2025 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744649727;
	bh=B/f8nfuCKrz3hf3ccJBtDMWjTuWvH9EW7AkbfWjqkrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsoRwWB1aQivpwc5jmlzMzh0dvP+D9thuMGPLW6og/2G6EpsUigpcwI1L8xYjMQA8
	 bM6yoTrT8/JEyVUbhPljmzTG+U14OfV4knZxc5iL8ISIjCYzOnaumc7y/WFt/F843t
	 qoza24nMp8VO0BJmK9nlAK7q/fZ4fEH5FHOfNPHPtzu7LFztzWtHzpFJn+jgoqNg7t
	 aRFgVj39xnnz5qnh/a7thobFPe/rkxwIw19icHBDmZFC3sWgzMmVo+AJ5A7gZMFWd4
	 XK7yDgHlPpTNDUw2VLNN5G2jUxD7O14+aHWGRMGXgSvDhQXBr/jm3LExUVHC+C3cGi
	 J0snPHWvjbjLA==
Date: Mon, 14 Apr 2025 17:55:23 +0100
From: Simon Horman <horms@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] batman-adv: Fix double-hold of meshif when
 getting enabled
Message-ID: <20250414165523.GV395307@horms.kernel.org>
References: <20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org>
X-MailFrom: horms@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: NSVUT7VMPVRDXKNTQ3LBANN7WY7MO45H
X-Message-ID-Hash: NSVUT7VMPVRDXKNTQ3LBANN7WY7MO45H
X-Mailman-Approved-At: Mon, 14 Apr 2025 20:08:19 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NSVUT7VMPVRDXKNTQ3LBANN7WY7MO45H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Apr 10, 2025 at 08:58:51PM +0200, Sven Eckelmann wrote:
> It was originally meant to replace the dev_hold with netdev_hold. But this
> was missed in batadv_hardif_enable_interface(). As result, there was an
> imbalance and a hang when trying to remove the mesh-interface with
> (previously) active hard-interfaces:
> 
>   unregister_netdevice: waiting for batadv0 to become free. Usage count = 3
> 
> Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch is skipping Simon's normal PR submission to get this problem
> fixed faster in Linus' tree. This currently creates quite a lot of wrong
> bisect results for syzkaller and it would be better to have this fixed
> sooner than later.
> ---
> Changes in v4:
> - added Suggested-by: Eric Dumazet <edumazet@google.com>
> - added Reported-by: of various syzkaller reports which were affected (during
>   bisecting) by this problem

FWIIW, I don't see those tags at the bottom of the commit message.

> - resubmission after 24h cooldown time
> - added kernel message during hang to commit message
> - Link to v3: https://lore.kernel.org/r/20250409073524.557189-1-sven@narfation.org
> Changes in v3:
> - fix submitter address
> - Link to v2: https://lore.kernel.org/r/20250409073304.556841-1-sw@simonwunderlich.de
> Changes in v2:
> - add missing commit message
> - Link to v1: https://lore.kernel.org/r/20250409073000.556263-1-sven@narfation.org

...
