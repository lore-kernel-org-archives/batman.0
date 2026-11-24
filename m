Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACF606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUTV5Osk
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 44E5E8439B
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:27:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541267;
 b=ygWpITm4e4qO/N8pqvI+SQigbeEczk21rFRS6/MlQqZW2rBmnSMQmCFAewNWPGsV8F4/L
 tk55OmYGq6I8AR19VjGNVXb5FzOkzIC5FJzmfqVXeQZ/R4pEoN99mUY3J1vAMPb1E9duEZG
 dXRKMR5kJfiHjLrUv7jP7/cJzMtRzO0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541267; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qMX1K4LfI+C2lX6IEyz7++MGwrFPHDSNls5QRDDbrJc=;
 b=c345pbysEAP0uwFbNbL5WgusTNDB5gwLl8S2g4a983Oq9qnbg3LuMFb/QLA7s6mRUZhnQ
 74wrBtrM39lZxfLGNzXM8UVGtISVnBg6m+WC3IH2Hy7bUgYSusDYYbdJ9RPYKKSeK/trLuM
 XBCihwm8B2SYfLdtFcrltff9/udB7PQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D26B082F0A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540857;
	b=kj+7NsHrskv9VsZukhmSC69m52wse7I369OW4jaVc5SaLjrB28AWnurSMNTZvYOoxDcQqe
	MpND+do0LaE9uMAPn/BX0vme/C+sXANtxN5e6s60D8/neyOoDNjZCuGf/UV9nEns5s9TBc
	NrNq4iFeB46awmS8yqyHB0r1HwQ02jw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qMX1K4LfI+C2lX6IEyz7++MGwrFPHDSNls5QRDDbrJc=;
	b=a41hh0zLpap5nowT8Vzh45a9UPXCd4LrWysIs9lAbKekYB8AA9F0SRDR5zmLlxCKEi8gAf
	CmLgSiBdWzhddpRFLvSRKare8IhyhlG5nmUgiRrh7RA1jT+pobWYC6cU9bi+ptdUDMLlLo
	sItQbphmyHKei2a61Hm1RyuXYhbOz+0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QUTV5Osk;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C35C4627EA;
	Tue, 24 Nov 2026 17:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3901F000D3;
	Tue, 24 Nov 2026 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540845;
	bh=qMX1K4LfI+C2lX6IEyz7++MGwrFPHDSNls5QRDDbrJc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QUTV5Oskr7VQxgwbHUbT74C9Utw+ExYIPPPWoZaEdl6bWIEsm0KX9+Vrc03wEV8TI
	 PBWJsV9VRSEkBH1KCPpl/Om8N6dJrsmr41IYsf6ObwrewdwU4FL+hQaSPWoWgLMR6y
	 CB9ERP+2O2lOfblLEzfx+HizX6o2qXB4FElGzd42sikYec0EC4qKzY7zL/lNSZq3te
	 Hk3JtYfNmBDbqw3KIJ8ayfvgkYdxuNqP8JYzpLbPABp4HWmmsJFvQmSj5nLwQHsOZx
	 h4Sh9MbHXgx3u2oCGLAS+89VHxCGcoPr9bR7EVPd01B0nY5b5aLBnV7qhzkAlABd4i
	 24KAmrSlzqqsQ==
Subject: Re: [PATCH net-next 11/15] batman-adv: tt: requeue DEL of pending
 local entry after failed allocation
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:44 +0000
Message-ID: <179554084450.3135.11910035656981995724@kernel.org>
In-Reply-To: <20261123171827.3294525-12-sw@simonwunderlich.de>
References: <20261123171827.3294525-12-sw@simonwunderlich.de>
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
Message-ID-Hash: T5H2SOITIT757KSC4DK2FSQ4QDKTQ7YU
X-Message-ID-Hash: T5H2SOITIT757KSC4DK2FSQ4QDKTQ7YU
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:24 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T5H2SOITIT757KSC4DK2FSQ4QDKTQ7YU/>
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

- [Low] A failed DEL|ROAM for a local entry that is already
  BATADV_TT_CLIENT_PENDING is never retried, and the new kernel-doc says…
- [Low] The concern: the patch has no Fixes: tag and does not say that it
  depends on the preceding commit "batman-adv: tt: keep local entry…

Pre-existing issues:
- [Low] The concern: the periodic batadv_tt_local_purge_list() requeue
  runs without tt.commit_lock and can clear del_unqueued after…

--

batman-adv: tt: requeue DEL of pending local entry after failed allocation

Sometimes batadv_tt_local_set_pending() cannot queue the DEL for a local
entry because the change allocation failed. This patch marks such an
entry as del_unqueued. batadv_tt_local_purge_list() then retries the
DEL, and batadv_tt_local_purge_pending_clients() keeps the entry in the
local table until the DEL is queued. batadv_tt_local_refresh_locked()
clears the mark when the client is added again.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index c94b292a1c4a8..0c5e21f3ba756 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -1779,13 +1793,24 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
>  {
>  	struct batadv_tt_common_entry *common = &tt_local_entry->common;
>  	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
> +	bool queued;
>  	u32 i;
>  
>  	i = batadv_choose_tt(&common->key, hash->size);
>  	lockdep_assert_held(&hash->list_locks[i]);
>  	lockdep_assert_held(&common->flags_lock);
>  
> -	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
> +	queued = __batadv_tt_local_event(bat_priv, common,
> +					 common->flags | flags);

[Severity: Low]
This isn't a bug, but this code now relies on __batadv_tt_local_event()
returning bool. That return value was added by the preceding patch,
"batman-adv: tt: keep local entry unchanged when ADD can't be queued".

The commit message doesn't mention this dependency, and there is no
Fixes: tag. No patch in the series has a Fixes: tag, so this may be
intentional. Is the series meant to stay out of stable?

> +
> +	/* a failed attempt must not hide the still queued DEL of an already
> +	 * pending entry
> +	 */
> +	if (queued)
> +		tt_local_entry->del_unqueued = false;
> +	else if (!(common->flags & BATADV_TT_CLIENT_PENDING))
> +		tt_local_entry->del_unqueued = true;

[Severity: Low]
What happens here when the entry is already BATADV_TT_CLIENT_PENDING and
the new event carries BATADV_TT_CLIENT_ROAM?

batadv_tt_local_remove_entry() doesn't check for PENDING. With roaming
set, it does this:

	if (roaming)
		common->flags |= BATADV_TT_CLIENT_ROAM;

	flags = BATADV_TT_CLIENT_DEL;
	if (roaming)
		flags |= BATADV_TT_CLIENT_ROAM;

	batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
				    message);

A remote node can reach this path:

batadv_handle_roam_adv()
  batadv_tt_global_add(..., BATADV_TT_CLIENT_ROAM)
    batadv_tt_global_purge_local()
      batadv_tt_local_remove(..., roaming=true)
        batadv_tt_local_set_pending(DEL | ROAM)

Say a plain DEL was already queued earlier in the same OGM interval, for
example by the timeout in batadv_tt_local_purge_list(). The DEL+DEL
update can still fail, because __batadv_tt_local_event() allocates
before it looks for the queued change to merge into:

	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
	if (!tt_change_node)
		return false;

In that case the else-if above leaves del_unqueued false. So
batadv_tt_local_purge_list() never requeues the DEL with the ROAM flag.

Only the plain DEL is announced. Receivers then call
batadv_tt_global_del() with roaming=false. That removes the old
originator right away instead of going through
batadv_tt_global_del_roaming().

Could unicast traffic to the client be lost until the ADD from the new
originator arrives?

The kernel-doc this patch adds to __batadv_tt_local_event() says:

  The only exception is the DEL of batadv_tt_local_set_pending(). Its
  entry is marked as del_unqueued to get the DEL requeued by
  batadv_tt_local_purge_list().

The new batadv_tt_local_set_pending() kernel-doc says the same: "Such an
entry is marked as del_unqueued instead". Neither seems to hold for this
case.

The lost ROAM upgrade was already possible before this series. The
kernel-doc claiming this case is covered is new, though, and this part
looks the same at the end of the series.

Could __batadv_tt_local_event() look up the existing change before
allocating, so the in-place update can't fail? If not, the kernel-doc
could say that an already pending entry only keeps its first DEL.

> +
>  	common->flags |= BATADV_TT_CLIENT_PENDING;

[ ... ]

> @@ -1911,11 +1936,18 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
>  					      common);
>  
>  		scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
> -			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
> +			/* entry already marked for deletion */
> +			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) {
> +				/* but its removal must still be announced */
> +				if (tt_local_entry->del_unqueued)
> +					batadv_tt_local_set_pending(bat_priv,
> +								    tt_local_entry,
> +								    BATADV_TT_CLIENT_DEL,
> +								    "requeued");

[Severity: Low]
This is a pre-existing issue and wasn't introduced by this patch. This
requeue runs from the periodic work without tt.commit_lock.

Can it clear del_unqueued after the splice but before
batadv_tt_local_purge_pending_clients() runs in
batadv_tt_local_commit_changes_nolock()?

	spin_lock_bh(&bat_priv->tt.changes_list_lock);
	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
	...
	batadv_tt_local_transition_new(bat_priv);

	batadv_tt_local_purge_pending_clients(bat_priv);

If so, the entry is removed in the current TTVN, but its DEL is only
announced in the next one. The same window already existed for any
concurrent batadv_tt_local_set_pending() DEL. The worst case looks like
a CRC mismatch for one TTVN, which a full table request repairs.

A later patch in this series, "batman-adv: tt: commit only the announced
local changes", seems to close this. After it, only entries whose DEL is
in the spliced changes_list are unhashed. The only remaining caller of
batadv_tt_local_purge_pending_clients() is
batadv_tt_local_resize_to_mtu(), which runs under commit_lock before the
splice.

>  				break;
> +			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
