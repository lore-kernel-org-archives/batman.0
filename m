Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD7DCA5FB3
	for <batman-adv@archiver.kernel.org>; Thu,  1 Oct 2026 12:17:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4E02E844C5
	for <batman-adv@archiver.kernel.org>; Thu, 01 Oct 2026 14:17:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790857046;
 b=q7CyoyEXknySrVVAHdoBdaVUiXSBQMD1rUcnibEdpaMOeRrMvJlWoPvztXcMDFdBADeqB
 VRzd4R+yHgtntH1rr661j/cBtlKcrTktuNDKPLF2Pz4p84eGaLOM2juuDXMj8smZBBrQ1qP
 5V9b0o1IKwTsGwKf+ZVtk/3uWOXc9Xg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790857046; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mYCwVZ86pk4vf/57gZPBZ3UBch9DOIJqfwIhHYuihbY=;
 b=m+8xKd0ZJkyXB4NBdyxTmRTiziiGmI3lybOcbKZlXCqnv9q0MaGvAGrgEc1//HaqW+QXR
 bggWgAEfaR3Rjp63KgV5vllCmLVtudOinwOHApUBry7mdOL86yEbNmQsn5YXDIXZUTzxwKK
 Zr40nDWOZZ8mnLYtIMDqJy3ObeVU2tY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F3CE9811BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 01 Oct 2026 12:10:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790849443;
	b=0USL2yJrcZ0DVtrY9dERI6922b9A3cA/jR5IpXslI/JRoHdj8f9PYvAYkE7S+5CzHD+LoT
	E0mo+z23YSvl2qFDpQtk6CJ6iosxFLaxHHTf5/s29jnfAYRBieHdJjMt4PAsrkgJBfyKkO
	xOmPBfP7x3FMOwosJ60S78BjeRV4fcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790849443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mYCwVZ86pk4vf/57gZPBZ3UBch9DOIJqfwIhHYuihbY=;
	b=ghFfJ6FXItckbc3vHYkckTXjprI7S+QahLqcrm5cvQqM/VHUZymhGNTJqvSoPLDtS24rJ5
	9xZ7sGXuQIQ804DT+ikX6C8h3cIAkgzBluu7S0cmISkVMBPJCahlZxbxs5ys/Gby2JwI0i
	qC9bYSsppWVrfMosN0LJpfgF0AIu9wo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eSfCFWiQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A85D841677;
	Thu,  1 Oct 2026 10:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC31F0089B;
	Thu,  1 Oct 2026 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849431;
	bh=mYCwVZ86pk4vf/57gZPBZ3UBch9DOIJqfwIhHYuihbY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eSfCFWiQ9shRsqAnZXXUua0xTEtxnAT6x+0Ue7Rj+F11RDVEJoDN15ZYWWwaVwME8
	 SNkElTiHhGCmw3ishFw7zu4IldDTqYvQu/ja1mETLVsx6uBWpYA72K9N/1/giKGiKi
	 tClfTNd//5BbG2HfSAwZZMwcs2H21jK7tjyV3GjY2x5G2oRNUbJSGw9E7h74BEcHPK
	 t3S8nbr8/7EqpJrU3/snEy8oFdw/3ktybPBncDyEXCMJzQKuQqV58aoOcMuQGQNR36
	 Sd17jnNlzPH2sfDfRNR5s1ar6BscuCzwmjob+/WcLFmm3cdPsuQlyKRat4n8LZV+37
	 0CjMBk20hmILw==
Subject: Re: [PATCH net-next 7/9] batman-adv: tt: queue local DEL event before
 marking entry as pending
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:30 +0000
Message-ID: <179084943057.434549.7181634875043920373@kernel.org>
In-Reply-To: <20260930094558.3723766-8-sw@simonwunderlich.de>
References: <20260930094558.3723766-8-sw@simonwunderlich.de>
X-sashiko-severity: High
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
Message-ID-Hash: GUP2VYKMKBS3QK3I72MNNZXFKP24OCYH
X-Message-ID-Hash: GUP2VYKMKBS3QK3I72MNNZXFKP24OCYH
X-Mailman-Approved-At: Thu, 01 Oct 2026 14:15:11 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GUP2VYKMKBS3QK3I72MNNZXFKP24OCYH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix covers only one ordering of the set_pending vs. re-add
  race.
- [Low] Stale locking rationale in the new kernel-doc.

--

batman-adv: tt: queue local DEL event before marking entry as pending

This patch restores the original order in batadv_tt_local_set_pending(),
so the DEL change is queued before BATADV_TT_CLIENT_PENDING is set. It
also moves the NEW check, the event queuing and the PENDING update into a
single flags_lock critical section. The goal is to stop a concurrent
batadv_tt_local_add_existing() from leaving the PENDING state and the
queued changes out of sync, which corrupts the TT CRC on neighbour nodes.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index c229c51cafa72..481dc6afaaba1 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -1420,28 +1433,37 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
>  }
>  
>  /**
> - * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
> + * batadv_tt_local_set_pending() - mark local TT entry as pending removal
>   * @bat_priv: the bat priv with all the mesh interface information
> - * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
> + * @tt_local_entry: local TT entry to mark as BATADV_TT_CLIENT_PENDING
>   * @flags: TT change flags to announce together with the pending removal
>   * @message: debug message describing the reason for the change
>   *
> - * Schedule the TT change announcement for the entry. The caller must already
> - * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry and must hold the
> - * hash bucket list_lock of @tt_local_entry since setting the flag.
> + * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
> + * entry. The entry is kept in the local table until the next TTVN increment
> + * so that a consistency-check response can still be answered.
> + *
> + * Next to the flags_lock of the entry, the caller must hold the hash bucket
> + * list_lock of @tt_local_entry. Otherwise
> + * batadv_tt_local_purge_pending_clients() could remove the entry before its
> + * change was queued.

[Severity: Low]
Is this rationale still accurate after the reordering?

With this patch, batadv_tt_local_set_pending() queues the event and then
sets BATADV_TT_CLIENT_PENDING, and both happen inside one
common->flags_lock section:

    __batadv_tt_local_event(bat_priv, common, common->flags | flags);
    common->flags |= BATADV_TT_CLIENT_PENDING;

batadv_tt_local_purge_pending_clients() only acts on PENDING after
reading it under the same flags_lock:

    scoped_guard(spinlock_bh, &tt_common->flags_lock) {
        if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING)) {

So it looks like purge_pending_clients() cannot see PENDING before the
change is queued, whether or not list_lock is held.

The updated batadv_tt_local_mark_removed() kernel-doc has the same
problem. It still gives the old order ("marked as
BATADV_TT_CLIENT_PENDING and the (roamed) DEL change is queued"). It also
adds a claim that list_lock prevents batadv_tt_local_transition_new() from
clearing BATADV_TT_CLIENT_NEW after it was checked. As far as I can tell,
that protection comes from the NEW check and set_pending() sharing one
flags_lock scoped_guard. The commit message says the same thing.

Could both comments name the single flags_lock section, together with the
queue-then-mark order, as the invariant? A later change could otherwise
move __batadv_tt_local_event() out of the flags_lock section while keeping
list_lock, and bring back the ADD/DEL misordering this patch fixes.

>   */
>  static void
> -batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
> -				  struct batadv_tt_local_entry *tt_local_entry,
> -				  u16 flags, const char *message)
> +batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
> +			    struct batadv_tt_local_entry *tt_local_entry,
> +			    u16 flags, const char *message)
> +	__must_hold(&tt_local_entry->common.flags_lock)
>  {
> +	struct batadv_tt_common_entry *common = &tt_local_entry->common;
>  	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
>  	u32 i;
>  
> -	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
> +	i = batadv_choose_tt(common, hash->size);
>  	lockdep_assert_held(&hash->list_locks[i]);
> +	lockdep_assert_held(&common->flags_lock);
>  
> -	batadv_tt_local_event(bat_priv, tt_local_entry, flags);
> +	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
> +	common->flags |= BATADV_TT_CLIENT_PENDING;

[Severity: High]
Does this close only one ordering of the race with the re-add path?

The add side still changes the flags and queues the ADD in two separate
steps. batadv_tt_local_add_existing() clears PENDING inside a flags_lock
scoped_guard and returns. batadv_tt_local_add() then queues the ADD after
that lock is dropped:

    if (added)
        batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
    ...
    if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
        batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);

batadv_tt_local_set_pending() can run in that window from the RX path:

batadv_tt_global_add()->batadv_tt_global_purge_local()->
  batadv_tt_local_remove()->batadv_tt_local_mark_removed()->
    batadv_tt_local_set_pending()

Here is one interleaving, starting with DEL#1 already queued and PENDING
set:

  CPU1 (TX)                         CPU0 (RX)
  batadv_tt_local_add()
    batadv_tt_local_add_existing()
      flags &= ~PENDING;
                                    batadv_tt_local_mark_removed()
                                      batadv_tt_local_set_pending()
                                        DEL|ROAM merged into DEL#1
                                        flags |= PENDING;
    batadv_tt_local_event(NO_FLAGS)
      ADD cancels DEL#1

There is a similar case with no earlier DEL. batadv_tt_local_update_flags()
returns true on CPU1, CPU0 queues a new DEL and sets PENDING, and then the
ADD from CPU1 cancels that DEL through the DEL+ADD case in
__batadv_tt_local_event().

Either way, the entry would be left PENDING with no DEL queued. At the
next commit, batadv_tt_local_purge_pending_clients() would remove it
locally, but neighbours would never receive a DEL.

Wouldn't that give the same CRC mismatch and full table request that the
commit message describes? Would the ADD also need to be queued inside the
flags_lock section that clears PENDING or updates the flags?

>  
>  	batadv_dbg(BATADV_DBG_TT, bat_priv,
>  		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
> @@ -1460,7 +1482,8 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
>   * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
>   * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
>   * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
> - * from removing the entry.
> + * from removing the entry and batadv_tt_local_transition_new() from clearing
> + * BATADV_TT_CLIENT_NEW after it was checked.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
