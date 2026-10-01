Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984F9CA5FB3
	for <batman-adv@archiver.kernel.org>; Thu,  1 Oct 2026 12:15:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ABE50844B4
	for <batman-adv@archiver.kernel.org>; Thu, 01 Oct 2026 14:15:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790856920;
 b=gLfHTtkKVTfOdoX8xfIQ94chiWMLancHM6ScOnev0aYo/ZUqRJsw+xpdY8gra7qS0PayY
 1UVfw/WBd5I0TKIItnQEa9zngDLtvSUVYoBGtmCq/0p7yfiSVkYshzDnRox8rmhSG27+nR1
 zkMmSgccotdfNLHN2fWbNWWXHsVeF2o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790856920; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oM3Rf/hJ1hs27M7cPIkP2fp3x5YoxK2XjVR3AlTbgGQ=;
 b=kn/pExe+6u6XW95M1PlMqm+KduZDC86P29HcmfN4VySWfcqaUmXRIRP0cMSKf3ypPt9Yx
 GCrduYYcgF6fhnnDR9eTAQxnVZIeUTOQIFTkCVTwmL4Uz0luA75AWa2kJgeL5X4REvZLBXT
 mnNx0UZUdUNYVTQdGqKFJmiMgfbs1Zk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7F722811BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 01 Oct 2026 12:10:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790849439;
	b=p4q7OSxL6ZEDpGD5/OKyuTLXPRl7RfcZyIWdzk4WDc3hfNXyUuobw7TyprxCCUO8rHQTcV
	sdt1bXg3mx0RsvD6OENx2FD4iu4hlCS+kMCShbv6Xh1aHKJV8hSokJSE/7kW72E/UI58n1
	YAOGvx35bq0qqTDkY0fhhR7DDTni8lM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790849439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oM3Rf/hJ1hs27M7cPIkP2fp3x5YoxK2XjVR3AlTbgGQ=;
	b=IGnD7Cfh2sdgxoo82nJFPf6SEkmXdrbL3GvIXh6Cw1P6hWUWra+yzU9R5wj699O6HOTZjG
	vL8HSMxrSruqvsJ5U5PG3TO034fcJJoTWALr9dJgFNdcx+03x0FjiSJLr1XrtTeCIT5G6G
	/+v6JUABiehLPXMkC8I4hTzL9nwfYIE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AuMYN3fx;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FB9060A54;
	Thu,  1 Oct 2026 10:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A262E1F00898;
	Thu,  1 Oct 2026 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849428;
	bh=oM3Rf/hJ1hs27M7cPIkP2fp3x5YoxK2XjVR3AlTbgGQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AuMYN3fxDGxwyVTRDwT1qHo+WFsXeyEdiJRCCrZrjiyQJsv/A7V1lbeQgCsfs8K1s
	 xtXLKCAkTeNFJWjD4e+WCg5LwGcZFohIRbipQ96OzBXGhCTpRGPkPklMqX4au5IfNx
	 xLDFb0+BCTSJPFDzIyyVkw1rnaYvLLyozc4/KWSbzfJDSGOHyHkkIG5i542HvFaUmC
	 cFcuVJhD6NGQxU4mbmmxqATfXMdOfQpyjuQhnsXOfsoRuZ82yCx8mwuIDf0SPU7mMQ
	 L4nTmO1p9wheMHJlJdWr0OXgCNzTiiGrY+Waw0KHX85P15y44hdsu/YuJUTcff160t
	 JxUm3bNJchYig==
Subject: Re: [PATCH net-next 3/9] batman-adv: tt: clarify responsibility for
 roam flag during removal
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:27 +0000
Message-ID: <179084942724.434549.1630601702570339695@kernel.org>
In-Reply-To: <20260930094558.3723766-4-sw@simonwunderlich.de>
References: <20260930094558.3723766-4-sw@simonwunderlich.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MailFrom: netdev-bot+sashiko@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: GFFGBRAMSM7COX6P6R24VKZP4A3TQ6QO
X-Message-ID-Hash: GFFGBRAMSM7COX6P6R24VKZP4A3TQ6QO
X-Mailman-Approved-At: Thu, 01 Oct 2026 14:15:11 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GFFGBRAMSM7COX6P6R24VKZP4A3TQ6QO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comments rearranged by this patch don't fully match their
  functions.

--

batman-adv: tt: clarify responsibility for roam flag during removal

The comment about marking a local entry as "roamed" moves out of
batadv_tt_local_remove() and into batadv_tt_local_mark_removed(). That
helper is where BATADV_TT_CLIENT_ROAM is actually set on the entry.
Building the DEL/ROAM event flags in batadv_tt_local_remove() now happens
only inside the branch that queues the pending event.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=10

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 6d8fa6d28fee8..78f032c9ad65c 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1461,7 +1461,10 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
>  	scoped_guard(spinlock_bh, &common->flags_lock) {
>  		*curr_flags = common->flags;
>  
> -		/* mark the local client as ROAMed */
> +		/* if this global entry addition is due to a roaming, the node
> +		 * has to mark the local entry as "roamed" in order to
> +		 * correctly reroute packets later
> +		 */
>  		if (roaming)
>  			common->flags |= BATADV_TT_CLIENT_ROAM;
>  
> @@ -1532,22 +1535,22 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
>  	if (!tt_local_entry)
>  		return BATADV_NO_FLAGS;
>  
> -	flags = BATADV_TT_CLIENT_DEL;
> -	/* if this global entry addition is due to a roaming, the node has to
> -	 * mark the local entry as "roamed" in order to correctly reroute
> -	 * packets later
> -	 */
> -	if (roaming)
> -		flags |= BATADV_TT_CLIENT_ROAM;
> +	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags)) {
> +		/* queue (roamed) del event which was prepared by
> +		 * batadv_tt_local_mark_removed()
> +		 */
> +		flags = BATADV_TT_CLIENT_DEL;
> +		if (roaming)
> +			flags |= BATADV_TT_CLIENT_ROAM;

[Severity: Low]

This isn't a bug, but is the "prepared by batadv_tt_local_mark_removed()"
wording accurate at this commit?

In this commit, batadv_tt_local_mark_removed() doesn't build any event. It
only saves *curr_flags and sets BATADV_TT_CLIENT_ROAM and
BATADV_TT_CLIENT_PENDING on common->flags. The DEL and ROAM event flags are
built right after this comment and then passed to
batadv_tt_local_set_pending_event().

Two later patches in this series move the DEL event queuing into
batadv_tt_local_mark_removed() and drop this comment. They are "batman-adv:
tt: queue local DEL event under bucket lock" and "batman-adv: tt: queue
local DEL event before marking entry as pending". So the mismatch only
exists at this commit.

The other two points are small wording nits. Both come from code that was
already there before this patch.

The comment moved into batadv_tt_local_mark_removed() starts with "if this
global entry addition is due to a roaming". The helper's kernel-doc
describes @roaming as "true if the deletion is due to a roaming event".

The only caller passing roaming=true is batadv_tt_global_add(), so the
wording is correct in context. Would it read more naturally in terms of
the deletion, to match the kernel-doc?

The ROAM bit added to flags here is already part of the emitted change.
batadv_tt_local_event() does:

	flags = batadv_tt_flags_get(common) | event_flags;

and batadv_tt_local_mark_removed() has already set BATADV_TT_CLIENT_ROAM
on common->flags. The commit message already says this ("The former will
only create similar flags for the roaming event"), so this is just a note.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
