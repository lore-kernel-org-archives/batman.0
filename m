Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A43ECA5FCB
	for <batman-adv@archiver.kernel.org>; Thu,  1 Oct 2026 12:16:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7C48E844A9
	for <batman-adv@archiver.kernel.org>; Thu, 01 Oct 2026 14:16:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790857015;
 b=KyyRrKCCa2R7bW3hBj0NZJf59E6HpvQsTzXLoVSdItQEtvANdGsb+ToA5rcN1QC3SKOEe
 1PTFofSOmPo/MTTscTG1RVdf8RcdMN9nw6epLCZsqsXryb3ZPxpEW264vsj8ryGbO83OCeo
 9StR1Yw7Rh7/Wm1rAE2baIyAL5XeWWQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790857015; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=B7HWefCeOTd++Q23BIO6fbuqpYfvROVbUS9RWbOIihs=;
 b=aLltZPJp/V8CinoXlaHOPguDprXTMVTQB8vHD5bTy6CctUCC24fASi1yrDYLg2VBT+k9O
 +5aTFwKZW4yJ+5BMoxNGhGuDaD4xgUL22A0toqDr8S0Qu0V/9bhqa6wX3WAezgieTd4AY5H
 ZEIVWQ+2YoeDMVoILDC/aM8hOBLnyjQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F3D2184492
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 01 Oct 2026 12:10:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790849443;
	b=dIkAi2gVkT1EL/kvpoCDaBGQ7rprRfVbqVuEw8ISSSO1W0K+rEzs1hvDDYZK6OkSGDFacy
	I6J0YmwYCHhyU8bxqKNgaA71tFHS7VtUWmrIfpC5SYR3NR1xHPhzE1Kyym+1qb5EJRgGsV
	I7VMkFdCDBlnxBeVGLZypjg4fibCLtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790849443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=B7HWefCeOTd++Q23BIO6fbuqpYfvROVbUS9RWbOIihs=;
	b=OMTudhT0wiOIsJfxD1/j4dVij5OzXNuNStmUUmr/4yWLQ/Hajh89XHzj8tGSfulP1O6EAB
	KMiJ2zABQQeIyyFV0ddjFLMN3GL5JBQ6BAQzw243uzGfmgjCJcDhiXyb2XQaCQxxAoAqvA
	vblOu02wK3OznzY/MyHkyDtznOyGeg4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DZGzXQW7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 804BE43215;
	Thu,  1 Oct 2026 10:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2E71F0089A;
	Thu,  1 Oct 2026 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849430;
	bh=B7HWefCeOTd++Q23BIO6fbuqpYfvROVbUS9RWbOIihs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DZGzXQW7TtnObIF6ApWFCReDjMiS8ArQpOeo8Qgs8bX4lN3rfk6ljau4o6lyJ0b+o
	 +KT4NssAMi16zj4+c24cpRhvCHLfTpfz941He09qU6IOcym9e3X6j3slimlFLzqyH1
	 ao+Z75pLOHuaYFAZi0rsGLQdhgBPKoTW7v3mpa1WRAAE5wowXdPL9UO7bXjedbF45A
	 6OqpAlLi81jb5k1nvCs4fSewGK5OwMwacVz9YNc0IbBavaxBdrke4fA5UHaREIdpyc
	 EZGqi9lu4/5Va7bdYS00YZ8FOmg72iGxnUIPEMaS+FSmJDMONfjbBlPoSQvMB0cmpq
	 MadZnEW73EAxg==
Subject: Re: [PATCH net-next 6/9] batman-adv: tt: queue local DEL event under
 bucket lock
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:29 +0000
Message-ID: <179084942939.434549.10348803956240291735@kernel.org>
In-Reply-To: <20260930094558.3723766-7-sw@simonwunderlich.de>
References: <20260930094558.3723766-7-sw@simonwunderlich.de>
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
Message-ID-Hash: G2ZSQVEKQYCJO6PX4ZQ77CFHY7KNZUQP
X-Message-ID-Hash: G2ZSQVEKQYCJO6PX4ZQ77CFHY7KNZUQP
X-Mailman-Approved-At: Thu, 01 Oct 2026 14:15:11 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G2ZSQVEKQYCJO6PX4ZQ77CFHY7KNZUQP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (4) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Holding the bucket list_lock is not enough to serialize
  batadv_tt_local_remove() against…

Pre-existing issues:
- [Medium] batadv_tt_local_mark_removed() (net/batman-adv/translation-
  table.c) acts on an entry that may no longer be in the local hash.
- [Medium] The add path undoes a pending removal without the bucket lock.
- [Medium] If the change-node allocation fails, the entry is still
  treated as pending but its DEL is never queued.
- [Medium] The immediate-purge branch of batadv_tt_local_remove() (the
  entry is still NEW) is not atomic with respect to…

--

batman-adv: tt: queue local DEL event under bucket lock

This moves queueing of the DEL change event into
batadv_tt_local_mark_removed(). The hash bucket list_lock is now held
across setting BATADV_TT_CLIENT_PENDING and queueing the DEL, so that
batadv_tt_local_purge_pending_clients() cannot remove the entry between
the two steps. batadv_tt_local_set_pending_event() now asserts that the
bucket lock is held.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index c904d67791f8f..c229c51cafa72 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1427,13 +1427,20 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)

[ ... ]

>  static void
>  batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
>  				  struct batadv_tt_local_entry *tt_local_entry,
>  				  u16 flags, const char *message)
>  {
> +	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
> +	u32 i;
> +
> +	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
> +	lockdep_assert_held(&hash->list_locks[i]);

[Severity: Medium]
This is a pre-existing issue, but the code that clears
BATADV_TT_CLIENT_PENDING doesn't follow the rule asserted here. Is the
add path safe against batadv_tt_local_purge_pending_clients()?

batadv_tt_local_add_existing() clears the flag while holding only
flags_lock:

	scoped_guard(spinlock_bh, &common->flags_lock) {
		if (common->flags & BATADV_TT_CLIENT_PENDING) {
			...
			common->flags &= ~BATADV_TT_CLIENT_PENDING;

			return true;
		}

batadv_tt_local_add() then queues the ADD through batadv_tt_local_event()
without the bucket list_lock.

Say batadv_tt_local_purge_pending_clients() unlinks a PENDING entry after
the lockless hash_find() in batadv_tt_local_add() but before
batadv_tt_local_add_existing() runs. The flag is then cleared on an entry
that is no longer hashed, and an ADD is queued for it:

- If the ADD is queued before batadv_tt_tvlv_container_update() drains
  the list, it cancels the entry's DEL in batadv_tt_local_event(). The
  client leaves the table and the CRC with no DEL announced.
- If it is queued after the drain, the next TTVN announces an ADD for a
  client that isn't in the local table.

Either way neighbours see a CRC mismatch. The active client is also
missing from the local table until another frame recreates it.

The later commit "batman-adv: tt: queue local DEL event before marking
entry as pending" reorders DEL and PENDING. It doesn't add list_lock or
an unlink check to batadv_tt_local_add_existing().

> +
>  	batadv_tt_local_event(bat_priv, tt_local_entry, flags);

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens if the
change node allocation fails here? batadv_tt_local_event() returns
silently:

	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
	if (!tt_change_node)
		return;

By then batadv_tt_local_mark_removed() has already set
BATADV_TT_CLIENT_PENDING and will return true, so
batadv_tt_local_remove() skips the immediate removal. No DEL is queued
and local_changes isn't incremented. The void return leaves no way to
undo PENDING.

If another change makes local_changes non-zero, the next commit's
batadv_tt_local_purge_pending_clients() drops the entry from the table
and the CRC. No DEL is ever announced.

If there are no other changes, batadv_tt_local_commit_changes_nolock()
returns early:

	if (READ_ONCE(bat_priv->tt.local_changes) == 0) {
		...
		return;
	}

batadv_tt_local_purge_list() also skips entries that are already
PENDING. The removal is never retried, and neighbours keep stale client
information.

The same order is still there at the end of the series.
batadv_tt_local_set_pending() calls __batadv_tt_local_event() and then
sets PENDING unconditionally.

>  
>  	batadv_dbg(BATADV_DBG_TT, bat_priv,

[ ... ]

> @@ -1443,20 +1450,37 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,

[ ... ]

>  static bool
> -batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
> -			     bool roaming, u16 *curr_flags)
> +batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
> +			     struct batadv_tt_local_entry *tt_local_entry,
> +			     const char *message, bool roaming, u16 *curr_flags)
>  {
> +	spinlock_t *list_lock; /* protects write access to the hash lists */
>  	struct batadv_tt_common_entry *common = &tt_local_entry->common;
> +	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
>  	bool pending = false;
> +	u16 flags;
> +	u32 i;
> +
> +	i = batadv_choose_tt(common, hash->size);
> +	list_lock = &hash->list_locks[i];
> +
> +	spin_lock_bh(list_lock);

[Severity: Medium]
This is a pre-existing issue, but now that the bucket lock is taken here,
should this also check that tt_local_entry is still hashed?

batadv_tt_local_remove() gets the entry from the lockless
batadv_tt_local_hash_find(). Nothing checks the entry again once
list_lock is held. Consider:

1. Entry E is already PENDING with a DEL queued, for example from
   batadv_tt_local_purge_list().
2. CPU0: batadv_tt_local_remove() finds E and takes a reference.
3. CPU1: a commit runs batadv_tt_local_purge_pending_clients(), which
   calls hlist_del_rcu() on E. The first DEL is sent.
4. batadv_tt_local_add() creates E' for the same addr/vid and queues its
   ADD.
5. CPU0 takes list_lock and sees that E isn't NEW. It sets PENDING again
   and queues a second DEL for E.

batadv_tt_local_event() only matches on addr and vid:

		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
		if (del_op_requested != del_op_entry) {
			...
			list_del(&entry->list);
			kmem_cache_free(batadv_tt_change_cache, entry);
			changes--;

So the stale DEL cancels the ADD for E'. E' stays in the local hash and
counts toward the CRC after the next batadv_tt_local_transition_new(),
but it is never announced. Neighbours then see a CRC mismatch and need a
full table request.

batadv_tt_local_remove_now() already guards against this. It queues its
DEL only after batadv_hash_remove() confirms that this exact object was
unlinked. That check came from the earlier series commit "batman-adv: tt:
only queue local del event after successful unlink".

Would a hlist_unhashed() check under list_lock be the equivalent here?
The same gap is still present at the end of the series in
batadv_tt_local_set_pending().

>  
>  	scoped_guard(spinlock_bh, &common->flags_lock) {
>  		*curr_flags = common->flags;
> @@ -1474,6 +1498,17 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
>  		}
>  	}
>  
> +	if (pending) {
> +		flags = BATADV_TT_CLIENT_DEL;
> +		if (roaming)
> +			flags |= BATADV_TT_CLIENT_ROAM;
> +
> +		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
> +						  flags, message);
> +	}
> +
> +	spin_unlock_bh(list_lock);

[Severity: High]
Is the bucket list_lock enough to serialize this against
batadv_tt_local_commit_changes_nolock()?

The lock only orders this code against the
batadv_tt_local_purge_pending_clients() pass over this one bucket. The
later phases of the commit take no bucket lock:
batadv_tt_local_update_crc() walks the hash under RCU, and
batadv_tt_tvlv_container_update() drains the change list. The only thing
holding those phases together is tt.commit_lock, and
batadv_tt_local_remove() never takes it.

That seems to leave two windows with the result the commit message says
it avoids.

In the first window the DEL is lost:

CPU0                              CPU1
                                  batadv_tt_local_commit_changes_nolock()
                                    ..._purge_pending_clients()
                                    batadv_tt_local_update_crc()
                                    batadv_tt_tvlv_container_update()
                                      /* snapshot local_changes == K */
batadv_tt_local_mark_removed()
  spin_lock_bh(list_lock);
  flags |= ..._PENDING;
  batadv_tt_local_event();
  /* local_changes == K + 1 */
  spin_unlock_bh(list_lock);
                                      spin_lock_bh(&changes_list_lock);
                                      /* copy K, free all K + 1 */

This is the batadv_tt_tvlv_container_update() code involved:

	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
	...
	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
				 list) {
		if (tt_diff_entries_count < tt_diff_entries_num) {
			memcpy(tt_change + tt_diff_entries_count, ...);
			tt_diff_entries_count++;
		}
		list_del(&entry->list);
		kmem_cache_free(batadv_tt_change_cache, entry);
	}

E stays PENDING with no DEL queued. The next commit's purge removes E
from the table and the CRC, and no DEL is ever sent. The gap between the
snapshot and the drain also includes batadv_tt_prepare_tvlv_local_data().

In the second window the DEL is announced with a CRC that still counts
the client. batadv_tt_local_mark_removed() runs after the purge has
scanned this bucket but before the snapshot, so the DEL goes out in TTVN
n+1. batadv_tt_local_crc() only skips NEW entries, which means the n+1
CRC still includes the PENDING entry. Neighbours that apply the DEL then
see a mismatch.

The commit message says:

  Move the event into batadv_tt_local_mark_removed() and hold the bucket
  list_lock of the entry around both the flag change and the DEL event to
  avoid this scenario.

That closes the exact interleaving in the diagram, but other remove vs
commit interleavings still reach the same result.

Does closing this need commit-level serialization instead, for example
taking tt.commit_lock around the marking and queueing? Nothing later in
the series changes batadv_tt_tvlv_container_update(),
batadv_tt_local_update_crc() or the locking in batadv_tt_local_remove().

> +
>  	return pending;
>  }
>  
> @@ -1532,28 +1567,17 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,

[ ... ]

>  	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
>  	if (!tt_local_entry)
>  		return BATADV_NO_FLAGS;
>  

[ ... ]

> +	/* if this client has been added right now, it is possible to
> +	 * immediately purge it
> +	 */
> +	if (!batadv_tt_local_mark_removed(bat_priv, tt_local_entry, message,
> +					  roaming, &curr_flags))
>  		batadv_tt_local_remove_now(bat_priv, tt_local_entry);

[Severity: Medium]
This isn't a bug introduced by this patch, but the immediate purge
branch has a similar ordering problem.

batadv_tt_local_mark_removed() checks BATADV_TT_CLIENT_NEW under
list_lock, but drops the lock before batadv_tt_local_remove_now() acts
on the result. batadv_tt_local_remove_now() then unlinks the entry first
and queues the DEL afterwards:

	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
					     batadv_compare_tt_entry,
					     batadv_choose_tt, common);
	if (!tt_removed_node)
		return;

	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);

If CPU0 stalls between those two calls while CPU1 commits, can this
happen?

CPU0                              CPU1
batadv_tt_local_remove_now()
  batadv_hash_remove()
                                  batadv_tt_local_commit_changes_nolock()
                                    batadv_tt_local_transition_new()
                                    batadv_tt_local_update_crc()
                                    /* CRC for n + 1 excludes E */
                                    batadv_tt_tvlv_container_update()
                                    /* queued ADD for E sent in n + 1 */
  batadv_tt_local_event(..., DEL)
  /* DEL only sent in n + 2 */

Neighbours apply the ADD. Their CRC for us then includes E while ours
doesn't, so they request the full table. The comment above
batadv_tt_local_remove_now() mentions a parallel context announcing the
entry, but only the size accounting handles that case.

The DEL-after-unlink order comes from the earlier series commit
"batman-adv: tt: only queue local del event after successful unlink".
The baseline queued the DEL before the unlink and had a mirror race with
the same CRC mismatch.

As with the PENDING branch, holding list_lock around both steps wouldn't
close this. batadv_tt_local_update_crc() and
batadv_tt_tvlv_container_update() never take list_lock.

>  
>  	batadv_tt_local_entry_put(tt_local_entry);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
