Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E1606A323
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hgx4/M8s
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5271C8145A
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:26:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541179;
 b=xHsGCscV/kp3Mxtkm/Iim/9yv331J+5abC85Ozjx8TcLKmW9i3iuc/lik1n7A21cXf1N2
 pYFHQmjhZWwVoYcWbJSJg/rFy+I4pcHUyse601C6NDESITIGA3Yu77tgwMc9RWNfhLfr3CI
 YcaTkbCovnXEPOTvla6bb7LuolZL/y8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541179; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/OQQQduCopXVIDGmi2trA2UVwG7vGp1csUVpwdmh0dg=;
 b=hrL79hwuL7CN5UdlT84EijCvZq6xCfzPAV9M5valcwmH++rmHvPX/rdqtQ1THbI2FTB5o
 uHaaywWBiX6jPf3UjTvhHfT4A+W4CpQMrBv9KXpIKQaQJ04palAskouWeNy2dCvuKbQE9Vj
 SYuc2njjf7GGbd0HezXOeFflHDvtzr4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD7F782EDF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540854;
	b=vdVEspIlZy5r10KFszOKc5ipttC2IoldNDxGN2TvzFWHwdlgTqONjd4co6ufv7l3K/wVc/
	Ninmtk3J0ClJBPQuAN+EECH3zQlmjdB4djqBnFqlyrciRMInYZAcfZGwLpZZWUaWY6NYOR
	Qie+ZfO9UujeMXdxTYChpNaZjnlS7rE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/OQQQduCopXVIDGmi2trA2UVwG7vGp1csUVpwdmh0dg=;
	b=fVMoBJKB8SYjSl07IHTm9dkCgmfiCQCyKIhm3SWe8yDE2OR+IIIa5x5gRrE+bU2wExgeAN
	tT/f3gM8LvVrxGAxcwEqww3zEKxOX9I/kNKTtn9D+ToiBzM+b/XFeSiARLPpAAkGY/pa0m
	4bXx7CCmXqkdsC2qVeC7MBzJur/spnw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Hgx4/M8s";
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 172.105.4.254 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3304E61E01;
	Tue, 24 Nov 2026 17:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2061F000F0;
	Tue, 24 Nov 2026 17:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540840;
	bh=/OQQQduCopXVIDGmi2trA2UVwG7vGp1csUVpwdmh0dg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hgx4/M8svojd2sq/v2XH0KHRjBIJSp2H+4xtuTcejvr0YEpkwEJcd78+ATG+mxO+Y
	 7zL4HvoLUhLaUk70StCPiDjS52phYH1qrnwm2Jf+eznWyiRo/bG1eucEgjPRYS2FQe
	 4u1vEln9AysRORseuiFWk1Woxjn2d8LeRF6IQPev5dIaFu4TbGxE0ZFLJdIyGZGwjc
	 CFLdFt+/sjCXdB5lQMRtyxfyrrvJ2nkXruSFyVdr87hzE0OypBaI4nC/DK2bcOucKB
	 AXFdyslsO8kRDMgFFyeLJX4FppIB/Cr7d/BvNYUoEIgA+lIUmIeWiGGy7Q1SzZEDYm
	 YgqrrOPkPBiJw==
Subject: Re: [PATCH net-next 06/15] batman-adv: tt: refresh local entry in
 single flags_lock section
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:40 +0000
Message-ID: <179554084001.3135.10319614345027013330@kernel.org>
In-Reply-To: <20261123171827.3294525-7-sw@simonwunderlich.de>
References: <20261123171827.3294525-7-sw@simonwunderlich.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MailFrom: netdev-bot+sashiko@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: NWEOFI6TIONMYSESUQW63DJY3ULQD2ME
X-Message-ID-Hash: NWEOFI6TIONMYSESUQW63DJY3ULQD2ME
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:24 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NWEOFI6TIONMYSESUQW63DJY3ULQD2ME/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message of "batman-adv: tt: refresh local entry in
  single flags_lock section" tells reviewers and backporters less than…

--

batman-adv: tt: refresh local entry in single flags_lock section

This commit merges batadv_tt_local_add_existing() and
batadv_tt_local_update_flags() into batadv_tt_local_refresh(). Clearing
PENDING/ROAM, updating the dynamic flags and queueing the ADD event now all
happen in one flags_lock section. A new announce parameter requests the
initial ADD for a new entry.

Closes: https://sashiko.dev/#/bug/linux-7602d89e-b2cd-43ca-8aca-c165e5d674b2

> This is a preparation for the validation of the entry under the hash bucket
> list_lock, which then only needs to cover a single region.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-7602d89e-b2cd-43ca-8aca-c165e5d674b2

[Severity: Low]
The Reported-by: and Closes: tags suggest this is a bug fix. The message
calls it a preparation patch, though, and there is no Fixes: tag. Could the
message describe the race being fixed and what users see as a result?

Before this patch, batadv_tt_local_add() cleared PENDING in the flags_lock
section of batadv_tt_local_add_existing(). It then queued the ADD with
batadv_tt_local_event(), which reads the flags again after the lock has
been dropped:

    flags = batadv_tt_flags_get(common) | event_flags;
    __batadv_tt_local_event(bat_priv, common, flags);

That leaves a window like this:

CPU1                                   CPU2
batadv_tt_local_add()
  batadv_tt_local_add_existing()
    clear BATADV_TT_CLIENT_PENDING
                                       batadv_tt_local_remove()
                                         batadv_tt_local_set_pending()
                                           set PENDING, queue DEL
  batadv_tt_local_event()
    __batadv_tt_local_event()
      entry->change.flags = flags;

The late ADD is merged into the queued DEL, and its flags replace the DEL's
flags. The local entry still has PENDING set, so it is purged at the next
commit. The mesh is told ADD while the local table drops the client. The
CRC then no longer matches and a full table resync follows.

batadv_tt_local_refresh() now queues the event under the same flags_lock
that modifies the flags, which closes this window.

Could the commit message state this consequence and add a Fixes: tag? The
flag-update helpers being replaced seem to come from ec6edeb755ece6 and
d72e16b1c5d527.

Is this patch enough on its own to resolve the Closes: report? Or is the
later "batman-adv: tt: don't queue local events for unhashed entries" patch
also needed? Saying so in the message would help with backporting.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
