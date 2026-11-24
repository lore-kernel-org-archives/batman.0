Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAF606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqD8bK6e
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F255684365
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:27:17 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541237;
 b=BJ11YMV2RV9s8c97Y0U3yFkIre+jhkHL+80DtpXVMuI9EhNGwUapbgQoESneSlA63GL+s
 S4ByK+kWu0+K4x/8c1hunzOza/9MCcna+w4f+X3XlLuOWypV5i9XzSW7BFEy11c4kO3a6/S
 GUQbWFFc5XYbIhlDQiTc33abouP1rPI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541237; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=p/UDQyxJhw3BUiVVRQgYZDlK10E10e+GdTAXRLIZy3k=;
 b=kSCMrhuQELueq5jVw5EdpuKjIuOwwaug1NFu0vVLy4kgGF/ksGHkNgm5GqvgQ87/WYFZJ
 7tCdWT6qmEm7DNAo3vHOfOqMjTC4KB4MWjQI9EvV6V+ObXwUruFRs4huPXQD/iQRHQaZr3y
 rEZ7TdAJkUjPY3FlSoshjlI6H7T9X1U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 894EA82EDF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540855;
	b=Nzir/S5nBAFCDCp6ahB2tZgWohLY0xTCByf1ZUGyjrOqQPcr923lotn2QqY1qYEaryW9o1
	Tq09PwBjJB0mXSQpJm1LASzQ5PQJjfRheP5V38+UNHNjY/ygsrHevVYbVOTajZMRSJ++aL
	1t4ZlxBGTD733Jw5BPOEFOY5CBB8O74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=p/UDQyxJhw3BUiVVRQgYZDlK10E10e+GdTAXRLIZy3k=;
	b=Rg8ldz44g6rsxOtaWY391VeNzKoyPgqHp9jSo/eR/eW+BVfj01sDfDpWLvoMZA3lOhAF+l
	36rDUIp+CKrqWP2l7TNq4UYBF3ox5nriA7hEyXLRdvksW0hfJxKdtkXOUnDGMSLxwVIgtL
	l84LL5Do2/r2k5GkVDLsoSdwU5mEOEc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CqD8bK6e;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 172.105.4.254 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A7CD627EE;
	Tue, 24 Nov 2026 17:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931281F0089E;
	Tue, 24 Nov 2026 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540844;
	bh=p/UDQyxJhw3BUiVVRQgYZDlK10E10e+GdTAXRLIZy3k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CqD8bK6eTCAlE9p/jKV2ZBuOzZvSm3xdaSkkraofai/eP3wmtfcXOFta0OQt7/bZt
	 Uc4Wh3qoRKcTxUS5NistBRnJe/TPeqDjlQ9sayiuvqoQ8TDKUptop2vFMmlffmqboQ
	 /2rZFI3b55Rm3Km2bM0Sv+YwEBb/DgWr+BRqKDy9wSCtxAxFi+uLi88MV85a7rywas
	 PtI1Afk0xGXOUJObWXF/nmySaQisNCHiqp2xj9nKFkqv2vpEvJE7j/5+E9jDtbh9j9
	 X3zINW7/tE/rjOC9OEhgvttERyXVyh3gNlaFfQoxbvaebRfj3XgXeaA3w7eXCDN3dx
	 uEEMx+Bud9++A==
Subject: Re: [PATCH net-next 10/15] batman-adv: tt: keep local entry unchanged
 when ADD can't be queued
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:43 +0000
Message-ID: <179554084314.3135.7493792255015362398@kernel.org>
In-Reply-To: <20261123171827.3294525-11-sw@simonwunderlich.de>
References: <20261123171827.3294525-11-sw@simonwunderlich.de>
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
Message-ID-Hash: MW6NCNZU7IKI22UFSCBOXEKR5NIU22LJ
X-Message-ID-Hash: MW6NCNZU7IKI22UFSCBOXEKR5NIU22LJ
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:24 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MW6NCNZU7IKI22UFSCBOXEKR5NIU22LJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Resolved later in the series.

--

batman-adv: tt: keep local entry unchanged when ADD can't be queued

This patch makes __batadv_tt_local_event() return whether the change was
stored. Callers that queue an ADD now modify the local entry only after
the ADD was queued: batadv_tt_local_refresh_locked() for flag updates and
batadv_tt_local_insert() for hashing a new entry. A failed refresh is
passed back up to batadv_tt_local_add().

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 977f62c88da76..c94b292a1c4a8 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -653,10 +653,18 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
>   * Only a single change per client is queued. It describes the latest state of
>   * the client and a new event therefore replaces an already queued one.
>   *
> + * The other nodes only learn about the modification of a local entry through
> + * the queued change. The caller must therefore not modify the entry in a way
> + * which depends on this change (e.g. hash it as BATADV_TT_CLIENT_NEW or mark it
> + * as BATADV_TT_CLIENT_PENDING) when the event could not be stored.
> + *
>   * The caller must hold the flags_lock of @common. The events of an entry are
>   * then queued in the same order in which its flags were modified.
> + *
> + * Return: true if the event was stored, false if the memory for it could not
> + * be allocated.
>   */
> -static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
> +static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
>  				    const struct batadv_tt_common_entry *common,
>  				    u8 flags)
>  	__must_hold(&common->flags_lock)

[Severity: Low]
At this commit, batadv_tt_local_set_pending() in
net/batman-adv/translation-table.c doesn't follow the new rule. It still
ignores the return value and always sets the PENDING flag:

net/batman-adv/translation-table.c:batadv_tt_local_set_pending() {
    ...
	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
	common->flags |= BATADV_TT_CLIENT_PENDING;
    ...
}

This DEL path has two callers. One is batadv_tt_local_remove_entry(),
including the roaming DEL with BATADV_TT_CLIENT_ROAM. The other is
batadv_tt_local_purge_list() for timed out clients.

If the GFP_ATOMIC allocation in __batadv_tt_local_event() fails there,
the entry ends up marked PENDING, and possibly ROAM, with no DEL queued.
At the next commit, batadv_tt_local_purge_pending_clients() unhashes
every PENDING entry. So the removal is never announced to the other
nodes.

The silent loss of the DEL already happened before this patch. What this
patch adds is a kerneldoc rule that this caller breaks. Should the
kerneldoc name batadv_tt_local_set_pending() as an exception here, or
should set_pending check the new return value?

The next patch in the series, "batman-adv: tt: requeue DEL of pending
local entry after failed allocation", seems to fix both. It adds
tt_local->del_unqueued, which batadv_tt_local_set_pending() sets when
the DEL was not queued. batadv_tt_local_purge_list() then requeues the
DEL, and pending entries with del_unqueued set are not unhashed. That
patch also rewords the kerneldoc to say that the DEL of
batadv_tt_local_set_pending() is the only exception.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
