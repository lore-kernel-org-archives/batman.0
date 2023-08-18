Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE28BEE49AA
	for <batman-adv@archiver.kernel.org>; Sat, 19 Aug 2023 08:11:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EA97B83478
	for <batman-adv@archiver.kernel.org>; Sat, 19 Aug 2023 10:11:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692432669;
 b=CZ3KQKN76oipjteWNGYjzhgjhqzNXf9xjN5FF3zm8NvDHB75iJNS4eTqqhTfLZCVrlJsc
 U6GY1VnCgrJNTnDWE/6238qvDOienmiB5NiwvGQtf0FtREdYDB8y5vgVary0atsq+s0h4hE
 WlbKqP4REJfTHvApwcMlCLcnzNo+58Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692432669; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2e52wcqOp8k90hg949bxzX96c8QIuL634VSpxsd/I9s=;
 b=aFOgQ1Q2DGdiFHcgT3kSDcuzDYNr/V3qKmKA/LA30cJUwnVwYeK+Px6dD+EeuOAeOv0LK
 vMbi3fCeXXUHbWOgT4ObVFF8VgXmewnO9th8WuwYAKxYrABsTJxmFyotnpeQEHzTAbaGtJO
 ASnXhjmfSP15LUPbQ3NoCAKJm5rbXvI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 68A6E8022E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 19 Aug 2023 00:20:27 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692397227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2e52wcqOp8k90hg949bxzX96c8QIuL634VSpxsd/I9s=;
	b=Sxcg9Em+2Dno+XhmL9ai/2xmvVk/JMVOCX8oeiIVXd1g9rjFw45e2B4hUH1wneOgQR69MQ
	bVW7rP6bpy/GXCP7redVqV42wKdsDfwB1ZMKEpq8GA6+IMVdlTofbDrEdRuKxPLMdlK4/3
	cQY548WSasJLq8URYUM3bEUJWkU9NDM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=eQcIuavP;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 139.178.84.217 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1692397227; a=rsa-sha256;
	cv=none;
	b=utoBJipLdzxlHaHO0QzTnkKPrrT00PIuFX5z8ij3BVAcneBBrNYBGzoqtaHpGCaKlS8vmS
	ySmDBDJiI0eTdDvh0X5sgpbSzeF5gMMiNmPtqASeybVXAefN47dzdNQ4zjcdb0fZlKx5Sz
	JvUeicqmECYzwMcZuh6gGiKPaDHwxXU=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CE15762232;
	Fri, 18 Aug 2023 22:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A1D4C433C8;
	Fri, 18 Aug 2023 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397225;
	bh=B84Ed/Eub/ZxXe98rGhtXzjES0xyVZVz+SiunbmFd10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eQcIuavP2adT6lEqWoQ080wisukuG78x9KnSNCvSi/ALgsgVfCl+eGQKFjHqN5C28
	 dufNidF5i47IPAC08UsVNba6SDqe52Q0W6o/uAq7C+6uSErbl9UvdkbCb2QEU6un0q
	 CtgQR7jJxdmXEQbOkFayhYbg4U+f0+9gWn4Tlipo7IY/UgwbTQRGWWnaJFhVnOFiv1
	 opOtaDTkNeAM64wsaAvb5Vr0cxpp9JQRDH7XgcU4tUjQbYpgKuPvuGDuiX+3x+2jxx
	 /R64QrZg7PCRFTKiJT4G4JFDjbUSwbVEPWyMEUN1HQZD4ix7ri/WxcwutC7A3eiFYa
	 0Zb4OsgoAJkVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 1BF83C395DC;
	Fri, 18 Aug 2023 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] batman-adv: Trigger events for auto adjusted MTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239722510.24641.8619081876432561940.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:20:25 +0000
References: <20230816163318.189996-2-sw@simonwunderlich.de>
In-Reply-To: <20230816163318.189996-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: 7FK4YNFS5GYGWBFFKCM2IGCZIIGZHMZI
X-Message-ID-Hash: 7FK4YNFS5GYGWBFFKCM2IGCZIIGZHMZI
X-Mailman-Approved-At: Sat, 19 Aug 2023 10:10:32 +0200
CC: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6CSTGFVY2U6EJNC7ZU7W3ZJREABKALD2/>
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

On Wed, 16 Aug 2023 18:33:14 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> If an interface changes the MTU, it is expected that an NETDEV_PRECHANGEMTU
> and NETDEV_CHANGEMTU notification events is triggered. This worked fine for
> .ndo_change_mtu based changes because core networking code took care of it.
> But for auto-adjustments after hard-interfaces changes, these events were
> simply missing.
> 
> [...]

Here is the summary with links:
  - [1/5] batman-adv: Trigger events for auto adjusted MTU
    https://git.kernel.org/netdev/net/c/c6a953cce8d0
  - [2/5] batman-adv: Don't increase MTU when set by user
    https://git.kernel.org/netdev/net/c/d8e42a2b0add
  - [3/5] batman-adv: Do not get eth header before batadv_check_management_packet
    https://git.kernel.org/netdev/net/c/eac27a41ab64
  - [4/5] batman-adv: Fix TT global entry leak when client roamed back
    https://git.kernel.org/netdev/net/c/d25ddb7e788d
  - [5/5] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
    https://git.kernel.org/netdev/net/c/421d467dc2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


