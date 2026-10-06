Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED039CA5FF0
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 00:50:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ECD1584270
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 02:50:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791247831;
 b=ApHO6JbbMDrUWAvnrpAf5xvSjC5VSdJzsLcw3Ydmy78llYaT8MFClFN8KBHB7FXV6/uB6
 2thVSaIrncQR8Rc1kMxDsG3bwbGPewdH9w1ab9b0rtnZ0XsH1126y+PssqNiPyKleO8oyK7
 B4BDIKqDkRlBq0RNiPrKwvjqU+pePg8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791247831; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nwczxQ9fvICRfG0h3rEJO7F4BMVUHAG9xNrV1heXrVU=;
 b=hN7JMDGT2YAoZepwICo4S5lWBVWtUTsPIPagzoT23ZK2R78sEOZYlQw+4kr31fRayz3mB
 /HXBmACqs3WOaW1GJr2p/7n/iyUQiRGOxocMd9jox9ccdz+QileENGz3ZogkStqBfQ+a1zj
 cpzRw6pvz9SjEaDTDnD0r3U+LtNHQkQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 85231806E1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 02:50:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791247821;
	b=YeoJ7bOSeTfkzhsv0zfDqUIDdIxE2B1rH7mH3DIhCa/TiH8mfHaM7rEIth4C499ode8HDe
	KKAtWFuuGTo1vW6djl3NlOSbmhSSdBMBOMzsF04aAaYdmJsKFDBMwNlI+LAGJTUfnv+TLb
	AYKrtREscaoZuwjFXlPXKGT5RzDxeYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791247821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nwczxQ9fvICRfG0h3rEJO7F4BMVUHAG9xNrV1heXrVU=;
	b=fRQz61309yE2bTE6rHMYAcAX+23/9iBStokDi5MMaRWIGEDqA7vWoi8R228gNxC5V7JiUY
	XHZWyYQMK4HCxI8VHZB2wIZhoOPDu4sBAWKkioc8DyE110EvlnJb1xkywmkvuN1UhQTKXO
	BavW8dP7tQN4yGfDQ3c1hRVBup5amZc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oj9dogqZ;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c04:e001:324:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5392A601F1;
	Tue,  6 Oct 2026 00:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C0E1F000FF;
	Tue,  6 Oct 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247809;
	bh=nwczxQ9fvICRfG0h3rEJO7F4BMVUHAG9xNrV1heXrVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oj9dogqZKC91eT6hUP1XWDFC93Wa32ndL++A2aphs292/Mht/WqsEHNKcNlQgFjrY
	 8JqMU19Y0q0yOEXBFJ/jvIyk9C8t3irk7UUfQYvIB3vNqhCID+ETanPeXaduAgmybQ
	 vlvXU3aLNU6gGyxiGUDr7Vw/2GNxeISllNn2Ga4AQgPpM9vpwI7CdripWMNTkWulUa
	 kIe4u/fo/3a8EmwCGiPwOaMHP3er39szwsOtkeU2XQRsbU+theES0vFcVYy7irI/TO
	 GsQ6Xid6WqQMDp4bDo+BF9/H/sC4mBGC/h5VE9BVneX5EuVlNVOK0kAr3pN2+Mgop9
	 9A/16KSc2YIzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F142A392667F;
	Tue,  6 Oct 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/9] batman-adv: bla: avoid double free after
 failed
 backbone_hash alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124780778.1960739.8553982365608117644.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:50:07 +0000
References: <20260930094558.3723766-2-sw@simonwunderlich.de>
In-Reply-To: <20260930094558.3723766-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Message-ID-Hash: ONBU5LU2IHRNTWBABXVT7LM6KLEKPB2F
X-Message-ID-Hash: ONBU5LU2IHRNTWBABXVT7LM6KLEKPB2F
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ONBU5LU2IHRNTWBABXVT7LM6KLEKPB2F/>
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

On Wed, 30 Sep 2026 11:45:50 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> When batadv_bla_init() fails to initialize the backbone_hash, it is freeing
> the (previously) allocated claim_hash. The initialization function will
> then return an error and the net_device initialization will stop. The
> destructor will be called instead and (indirectly via batadv_mesh_free() ->
> batadv_bla_free()) will try to free the bat_priv->bla.claim_hash again.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] batman-adv: bla: avoid double free after failed backbone_hash alloc
    https://git.kernel.org/netdev/net-next/c/4c0a6a5b7715
  - [net-next,2/9] batman-adv: tt: clarify kernel-doc for batadv_tt_global_purge_local
    https://git.kernel.org/netdev/net-next/c/f11712fc3d5f
  - [net-next,3/9] batman-adv: tt: clarify responsibility for roam flag during removal
    https://git.kernel.org/netdev/net-next/c/08967c26cc8d
  - [net-next,4/9] batman-adv: tt: soften kernel-doc for batadv_tt_local_remove_now()
    https://git.kernel.org/netdev/net-next/c/be66c5ac5485
  - [net-next,5/9] batman-adv: tt: only queue local del event after successful unlink
    https://git.kernel.org/netdev/net-next/c/597c0f2f69c0
  - [net-next,6/9] batman-adv: tt: queue local DEL event under bucket lock
    https://git.kernel.org/netdev/net-next/c/f95b9f28a9df
  - [net-next,7/9] batman-adv: tt: queue local DEL event before marking entry as pending
    https://git.kernel.org/netdev/net-next/c/a6746cb19076
  - [net-next,8/9] batman-adv: tt: reject VLAN/TT entries before reaching size limit
    https://git.kernel.org/netdev/net-next/c/85fb027f611b
  - [net-next,9/9] batman-adv: use assign_bit() where applicable
    https://git.kernel.org/netdev/net-next/c/d1807b20d548

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


