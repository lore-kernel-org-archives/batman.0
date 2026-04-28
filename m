Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB303FF8864
	for <batman@archiver.kernel.org>; Wed, 29 Apr 2026 06:10:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3FFA9859DC
	for <batman@archiver.kernel.org>; Wed, 29 Apr 2026 08:10:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777443052;
 b=zLcvIsbq6FZuZJA8H25UpdYlxZrncb1hpX6/UVo4sikXDLKEGP3Cd5c3JMuzuVUsJXnGo
 Gj65zsbwz9/E9ulSVQRL1dfddHmHxA5L4XtCJ9lPXz2I/jzI51gA5UyEHpt080UEnbuqeF+
 wQq1Bk6JTxgQVq6RMTvKAP0AAI5TLiQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777443052; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1g3jqWUMNf2kPSyUYwgIQAER1vxZ3edAIrtlbCrtFwE=;
 b=NIA3kSrFYnlfIty+tvQKOJyhXkcnnLiPft7wDnNh05M++lNTRWxJwu1ss/NLbBX7ZLhkd
 flg8QpFDUtA47LD55dB7TXunwlV/JmtOtlTJ7Vp9WSUcvualdqfDG551eOxApSnyZT54G/Q
 hGaU3HJ2SP+TRc7Akz/E0IovZsPAXjE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0A7DA84684
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Apr 2026 20:30:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777401046;
	b=xWWiWYFfdt1CyFI6fjtH17EUJMAjGVJvRcTJfYi9SOIz3NiI2sKjlgGximlcUIt1Twzgqk
	drG9j0dJb1Wl3PziO3X6mJDfoiCrXYadJ5RNE7j1EedGbHJH/1r3bHT8Sf16yqZ+BbQrU6
	kHNUKXnz8WJYq1R6Yom9teStBwd9LrA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oZ6EVaz3;
	spf=pass (diktynna.open-mesh.org: domain of horms@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=horms@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777401046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1g3jqWUMNf2kPSyUYwgIQAER1vxZ3edAIrtlbCrtFwE=;
	b=qIaGXx8NCGlCkHZu8wGN9ZwB/PGENduDFZuScJiGcZN7SAstUEkCiBXZ+TTfiD2I24ADpv
	EqanaXEpuv4dLwMClXx/AIQu0uo5WwCnExAN0ocXX6AQJqRiyT+zyQZ7GjVUxeZu3HoAA7
	EEMBdfzf9OOPi/jRBuSLCvQGupLt2IM=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C960740A08;
	Tue, 28 Apr 2026 18:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD311C2BCAF;
	Tue, 28 Apr 2026 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777401033;
	bh=Wu1rPi/JdV1ncJyIF4Ch7km429IcExTfSCrhEs8W8Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ6EVaz3yviM37KAMMTNpZicruYnfKUMHrJj8SvzFlDOnUNiKRML/TxszMZo3DSM2
	 F5XBC7oJOdIPdAIyPzz6W/sUbfolUoVhw7b8pcheYc1a0MuO4IG90vPYRL+md6oNei
	 l4hmoneb4L6LFLE8kbXU91VUsxnqSjnnnJP0z1Em/phrzzmaUgJAMBQ/lCJWPsGrW8
	 dhJwXBoLsV/NLYyQBcFJXizp32OOairjonwzEClmSSEMxpCcWQqK5z+xSNkDU1/JqA
	 pWLizWs9VTjXrbCS/rUunuG9OMCXbr6KiZLQ9YXAuLxevEwAdiDALqaKkOrGPOTEA4
	 sDiq4zQ7owNIg==
Date: Tue, 28 Apr 2026 19:30:28 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	marek.lindner@mailbox.org, sw@simonwunderlich.de,
	antonio@mandelbit.com, sven@narfation.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, tr0jan@lzu.edu.cn, wangjiexun2025@gmail.com
Subject: Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions
 during teardown
Message-ID: <20260428183028.GW900403@horms.kernel.org>
References: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
X-MailFrom: horms@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: YGAH6DFYUF66JSV42CARHJWCSYS5WZ5N
X-Message-ID-Hash: YGAH6DFYUF66JSV42CARHJWCSYS5WZ5N
X-Mailman-Approved-At: Wed, 29 Apr 2026 08:10:22 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YGAH6DFYUF66JSV42CARHJWCSYS5WZ5N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Apr 27, 2026 at 02:43:33PM +0800, Ren Wei wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> Prevent tp_meter from starting new sender or receiver sessions after
> mesh_state has left BATADV_MESH_ACTIVE.
> 
> Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
> - Split the original fix into setup-side and teardown-side patches

Hi Ren,

An AI generated review of this patch-set is available on sashiko.dev.
Could you take a look over that. I expect that some follow-up patches
are warranted.
