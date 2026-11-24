Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79584606A333
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftqDc1Sm
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0CEDD83138
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:28:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541327;
 b=KB9dhH2tmO7zMQ9RlhQ+xCG2k1/cK+H6fHtQya+PjDsTjo+gGl2nDxVxHB8KRAtL9rAem
 U0NR6b+LuGWPEJINWry1oSmyHQ5SiCRZASWAjj3likTkXYRMaQMH8Q4nfQxhlT5+RkFzK60
 KDNoU0rD7drDccZE/2+ILLL9Aufm3zM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541327; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oF3gep8PuNm39VKSTgtUwLjYfM6inrzVn5cOxsyGdW4=;
 b=SLba2oAH1zuvKCHPweiW5YRUIa/MD+0JCjFZDULsBJCQqBpZPApoCjyX6seiqUqNNLcxg
 635sXrHj7juwlQ7l+dAVHvserkrxRnSHEfNsb0dm49+lHJ1K9Kp9wn3ISTnifOdm9HYfUiZ
 U/ObMWY6t7gDMOPgtkB/dH8mTBcSa+M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CEE268082E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540860;
	b=xHAU88sEcwJkX5Ut26RxXbwi+jJY+pFuS34icweAdapAS4D6TAEmpAFn0lQx1OTaXoX+Fv
	4fyuax6d28BNSx0g7W5WxM8Ty3oi3YW/A8JTVqpW6ogzTcBpCNsjYOxnxmoj6X5onHi9Dg
	ENQpGTdw8C9nNllZD3YhG/VdeoaYnHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oF3gep8PuNm39VKSTgtUwLjYfM6inrzVn5cOxsyGdW4=;
	b=EzjNcogTuSg5zfgauiEE/HfGgMPhTpdO0E+/AcHNkkNBvPi+bFhURb2Xj11RjrUPXWNgew
	5RqxehbYeXx0iV8EMlsqxhj5ngCkd/xzpemfu6vJoCOOje0uLzDhThwyIlAuagKbEVc3bi
	hR59bYkBxkQleFYKvDYQ3pQ8wb1TJmI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ftqDc1Sm;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 172.105.4.254 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DFFBF627FB;
	Tue, 24 Nov 2026 17:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEE41F000C0;
	Tue, 24 Nov 2026 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540848;
	bh=oF3gep8PuNm39VKSTgtUwLjYfM6inrzVn5cOxsyGdW4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ftqDc1Sm7x6WDAtzdsj5bEi7RsVmLDLgqybaEyPWIojJn0MFY1QsEFPNiEb+/HOB0
	 fyuai+LK0Aoaehy6l4TvPvg96XkPzvIfz9OfI7BNvpTH4bB4+UWZOr4JUgHA7V1/G7
	 rXhj7Yio2DqRxVfQDW/8NixI6LrVYUNFkgDZwL4buzMiFlvuX/pfmL6r7Tvav+wN1B
	 Bm/L0QBPBAalKp4DtP4UA/IBhCZgmaeYBeFuUUj5SYipvicyBD5vIC4A4OFamFd+uj
	 EyRD9nwsRdrkS4Kre2bmvu6awbidENyrZauoKKuO/0zdHUatMiFxAFsX24zu18LXEM
	 +dVwM2Ot+0pMA==
Subject: Re: [PATCH net-next 13/15] batman-adv: tt: commit only the announced
 local changes
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:47 +0000
Message-ID: <179554084776.3135.15585552473847641901@kernel.org>
In-Reply-To: <20261123171827.3294525-14-sw@simonwunderlich.de>
References: <20261123171827.3294525-14-sw@simonwunderlich.de>
X-sashiko-severity: Medium
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
Message-ID-Hash: DAOF24XOUY5Q5EQXV7HKXWFG7PXVSFXK
X-Message-ID-Hash: DAOF24XOUY5Q5EQXV7HKXWFG7PXVSFXK
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:25 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DAOF24XOUY5Q5EQXV7HKXWFG7PXVSFXK/>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The change does not fully deliver the invariant it states.
- [Low] Two comments no longer match the code after this patch.

--

batman-adv: tt: commit only the announced local changes

batadv_tt_local_commit_changes_nolock() no longer scans the whole local
table when it commits. It now walks the change list it took for the new
TTVN and calls batadv_tt_local_commit_change() for each queued change: an
ADD ends the NEW state of an entry and a DEL removes the pending entry. An
entry whose client was detected again after its DEL was taken is put back
into the NEW state, so it stays out of the CRC until its ADD is committed.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 2a7f50de70fc8..b03d6c74732f4 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -1876,9 +1882,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
>   *
>   * All checks and modifications happen under the hash bucket list_lock and the
>   * flags_lock of the entry. This prevents a concurrent
> - * batadv_tt_local_purge_pending_clients() from removing the entry,
> - * batadv_tt_local_transition_new() from clearing BATADV_TT_CLIENT_NEW and
> - * batadv_tt_local_refresh() from modifying the entry after it was checked.
> + * batadv_tt_local_commit_change() from removing the entry and
> + * batadv_tt_local_refresh() from modifying it after it was checked.
>   */

[Severity: Low]
Should batadv_tt_local_purge_pending_clients() still be listed here?

It is still called from batadv_tt_local_resize_to_mtu() with only
commit_lock held:

    batadv_tt_local_purge(bat_priv, timeout);
    batadv_tt_local_purge_pending_clients(bat_priv);

It unhashes PENDING entries through batadv_tt_local_unhash_pending()
under the same list_locks[i] and entry flags_lock. Because
batadv_tt_local_remove_entry() does not take commit_lock, the two can
still run concurrently.

On a related note, the comment in batadv_tt_local_unhash() is no longer
accurate:

    /* An entry which still carries BATADV_TT_CLIENT_NEW was never counted
     * and must not be uncounted here.
     */
    if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
        batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);

batadv_tt_local_commit_change() can now set NEW again on an entry that
was already counted, and it uncounts that entry with
batadv_tt_local_size_dec(). The accounting is still correct, because NEW
means "not counted right now". But "was never counted" is wrong for such
entries. Could this comment be updated too? Later patches in the series
change neither comment.

[ ... ]

> +/**
> + * batadv_tt_local_commit_change() - apply a committed change to the local table
> + * @bat_priv: the bat priv with all the mesh interface information
> + * @change: the change which is announced with the new ttvn
> + *
> + * The CRC and the full table responses of a ttvn must reflect exactly the
> + * changes announced with it. Only the entry affected by a committed change is
> + * therefore modified. An entry which was added or marked for removal after the
> + * change set was taken stays in its current state until its own change is
> + * committed with a later ttvn.

[ ... ]

> +	hlist_for_each_entry(tt_common, head, hash_entry) {
> +		if (!batadv_compare_tt(&tt_common->hash_entry, &key))
> +			continue;
> +
> +		scoped_guard(spinlock_bh, &tt_common->flags_lock) {
> +			if (!del_op) {
> +				/* an ADD of an already committed entry only
> +				 * announces new flags or cancels its removal
> +				 */
> +				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
> +					break;

[Severity: Medium]
Does this fully meet the invariant in the kernel-doc above ("must
reflect exactly the changes announced with it") when flags change?

The CRC-relevant flags BATADV_TT_CLIENT_WIFI and BATADV_TT_CLIENT_ISOLA
are in BATADV_TT_SYNC_MASK. They are still written to the live entry
when their ADD is queued, not when that ADD is committed. That happens
in batadv_tt_local_refresh_locked(), reached through
batadv_tt_local_add()->batadv_tt_local_refresh(). That path holds only
the bucket list_lock and the entry flags_lock, not tt.commit_lock:

    if (announce &&
        !__batadv_tt_local_event(bat_priv, common, flags))
        return false;

    common->flags = flags;

Consider this sequence:

CPU1 (commit_lock held)
batadv_tt_local_commit_changes_nolock()
    list_splice_init(&bat_priv->tt.changes_list, &changes_list);

CPU2
batadv_tt_local_add()->batadv_tt_local_refresh()
    WIFI or ISOLA of client X changes
    ADD(X) is queued in the fresh tt.changes_list for N+1
    common->flags = flags;

CPU1
    batadv_tt_local_commit_change() for X: entry is not NEW, so break
    batadv_tt_local_update_crc()

batadv_tt_local_crc() hashes the live flags of every entry that is not
NEW:

    if (tt_flags & BATADV_TT_CLIENT_NEW)
        continue;

    flags = tt_flags & BATADV_TT_SYNC_MASK;

Doesn't CRC N then already include flags that are only announced with
N+1?

The same seems to apply when changeset N carries the initial ADD(X, F1)
and a refresh queues ADD(X, F2) for N+1 before the commit runs. This
function clears NEW, and CRC N is computed with F2, while the announced
changeset says F1.

Receivers that apply changeset N would then see a CRC mismatch and fall
back to a full-table TT_REQUEST. The commit message says this patch
removes that symptom. The window is small: one bucket lookup per queued
change between list_splice_init() and batadv_tt_local_update_crc().

The eager common->flags = flags write is still there at the end of the
series. The last patch ("drop ADD+DEL events of never announced
clients") also mentions this window: "An ADD queued by
batadv_tt_local_refresh() in this window (for example for a changed
BATADV_TT_CLIENT_WIFI flag)".

> +
> +				tt_common->flags &= ~BATADV_TT_CLIENT_NEW;
> +				committed = true;
> +				break;
> +			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
