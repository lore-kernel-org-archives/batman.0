Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86FFD216AA
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 13:54:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E879682544
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 15:54:00 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1729000440;
 b=qe2sgLZjYbZ/uTdWLVZhoBh7r6KI0Q5mlZwLzdnkYvlXogurjck1RRin2lRFyS+LkPe8l
 7+fWEIHhPh5t3zx1FGdpEtVAoweAJkR8ea+CXd3mDZEBryE3P1sRcDfN7OhQkXhNGhOlcX+
 KUFWGEuIIkCebwAesXV+8xfz65+AwOA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1729000440; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=d7qv0QxsG7JVjq8cejXf4m9OYklJT0YzutAIE+sT6bY=;
 b=Ndu2YPtdFyv2uf5UHKrNmSyGKw/t1MYy9/hWLmt5xcavOMxlzOdW+R2TTjkbSGOc4y/6K
 NIjxk4JyddA1VPqF53qX0jbnz9j6GBjOuNJhb/bA+ycuYwhWnm+AXh1o6I3Qme1a977A1hG
 OrJJzBo9a8jpnqa00uOmFk7uLnKCVP0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0D2BA810CD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 15 Oct 2024 15:40:26 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728999627; a=rsa-sha256;
	cv=none;
	b=CEVtLOOWdQsuYw3Hgnmt2BeYzoTAgaqz76rdJFm2sOtAPh3J6xYFjY1/8ZhVvPskZ2gDHC
	3doM4Ab6NOCR3hmsrF982wIfTsdt1bmQH2H59BfBalo0IQQPW/dJg2D+6ztRyuWEEknND6
	k5N8T4RiCxJuRap2f2N6pRSOZOYze0A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=gc80enfs;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4641:c500::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728999627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=d7qv0QxsG7JVjq8cejXf4m9OYklJT0YzutAIE+sT6bY=;
	b=BGj5zlDZuHvTIldgPfb2hcmrlhWBaDc7Up0gmVFy+Fml4hn7fKX7E5LblHtzT97jSwiS2b
	aPK/fB8hq4LLuNr7feONbdookj0my328n933uO0uXRch+OSwszgJDcli0bYqxwxq4Ba7ur
	d3OT56u47VAwvYBmFnWEv7Pz5Y3fOLQ=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3D1675C4B9D;
	Tue, 15 Oct 2024 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDDFC4CEC6;
	Tue, 15 Oct 2024 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728999625;
	bh=b5y3IscGRmb/wpzVvp1/nTnMJhvtbyKoww/llZjjv78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gc80enfsBa3TXrTI7U/d604am910OUv4UigweWPOKIX123whHbH/BPaSE/yPFtZhe
	 Dd2ge8JvNm8YiAmzkKqDmhaE584HZBHN98/DbSzHWWuuB2+/2tEGJlrZv2VnW6U6Ir
	 M/Sk6XGLdD+3t7YvuVRnn65BzC8JAyqxPOJNmi4dMiwJ59c66QbWoIydzlQ67eWhvC
	 acT/ieKnEu10sT70CgeFqKSfQbXYY41QeCVb1Xjth3ujN9N3XUGCnKChTc6WCx+g2A
	 0PwET2BK5mmBkOsMTDfl2unzx5PXpq7Yj63j2FU6qFAiBJTAVPcA2mQQaeOqm+Z9Kq
	 X3TXS/0F7PvrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADDAE3809A8A;
	Tue, 15 Oct 2024 13:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899963051.1165800.3482605759558886670.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 13:40:30 +0000
References: <20241015073946.46613-2-sw@simonwunderlich.de>
In-Reply-To: <20241015073946.46613-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: QE4STLFFO4GGYAQHKYOIPP6MTGOBJNXX
X-Message-ID-Hash: QE4STLFFO4GGYAQHKYOIPP6MTGOBJNXX
X-Mailman-Approved-At: Tue, 15 Oct 2024 15:53:57 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7AC4LCEQYYHW6HKVW3CKC2AN3SGBJHXE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 15 Oct 2024 09:39:43 +0200 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.13.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/4] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/0f4e6f947600
  - [2/4] batman-adv: Add flex array to struct batadv_tvlv_tt_data
    https://git.kernel.org/netdev/net-next/c/4436df478860
  - [3/4] batman-adv: Use string choice helper to print booleans
    https://git.kernel.org/netdev/net-next/c/5c956d11cfca
  - [4/4] batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    https://git.kernel.org/netdev/net-next/c/356c81b6c494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


