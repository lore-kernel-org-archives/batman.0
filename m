Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B4ACA5FB3
	for <batman-adv@archiver.kernel.org>; Thu,  1 Oct 2026 12:16:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EE80384578
	for <batman-adv@archiver.kernel.org>; Thu, 01 Oct 2026 14:16:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790856983;
 b=rT8AHW/2D+c0VOG/O4DaITgI4zQOGe/QNRXjNBEHJ0DTLjO2ZBGDATtyIyAWoRouw6TAz
 53Wbp6GLRphSX0CkfJCRE17MgWvgkl7OIOwwMAbkFfPHQpFos/pxm4VdHrwMq3RoEZl3GqA
 41gyb9faN2EeFGy89QW59+kNa8pzG/Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790856983; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WJorM2EtzzH95Xd1l8U0gNldIVFjJeiAV6lkiYM15bo=;
 b=OAKQMae5Q8HQRILLXFm1V3OqTRrnLRV+tTvfBiIulXTtbrfQEQLjUx239cvGWV2p+ztb7
 lPmLZsJ6MgUgDjTKYKoHRQHCIK/iuLFyM8N06COaZbkTnWolmQwYmaZylDb73jkuDbbX55z
 vHtM5vrTxD83Jio+HBMFIYfxH0Sl+Zg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A290E80406
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 01 Oct 2026 12:10:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790849440;
	b=ULSbPWFrvMOxlFlZh7o+Mr70X2bsjP9yw+qOgyEjT1PfsRWD2y1gaRIrJhD9LUyiGaAeZb
	lULipYFgmn9Wi+AUatH+PnRoOEEQaXpKUsepUI/ZbtuoNrnUYmwVExY++BvHTfkmsVW7sz
	OpvSA/XgFjqxNIE0s8a+Vk4Gpz29F1Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790849440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WJorM2EtzzH95Xd1l8U0gNldIVFjJeiAV6lkiYM15bo=;
	b=irfvhBBw3Hs8jek2MGKWFTNp1zbgGR5EgEm0/M6/D/Ar++PEdd3MYKbdz2MgKU7lprrKOq
	ItgcWmJ+m4unsusaCudaxuRm1792RQxM3E7/Lfa/CIcGnFXNwcb7gwGA/tCntB+QQziL8R
	8iE2dyVTy+aVp0cKd3m2tsG36V6PE6g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cLRlIm8r;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 172.105.4.254 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 80F086022F;
	Thu,  1 Oct 2026 10:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52EA1F00899;
	Thu,  1 Oct 2026 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849429;
	bh=WJorM2EtzzH95Xd1l8U0gNldIVFjJeiAV6lkiYM15bo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cLRlIm8rKqRPygqyuL900K/75GEZNZ16SeFyIY7LR7fpE7OU8q2eJFkkpZ7vHlYZI
	 vsOBSANx7s3Z1WqjA3pn3ePqhUlCQCsUMt1BdigBlW2iv+5hegzODi3+xVu+EZWIZ6
	 kJP70Etu9zMVFvkVSSmGBXpvqlafWEy+6B1cvuhzhGxnJv77ksUWe+2ZWQcHuzVqsT
	 fuGJ/Qyf6XbGr1yB8WJqAXOUTf24WBzITOKFkIs7w99r5dBoHY2VaBZJfYeRy6H6pn
	 svsvR9+RnuP8E7nVYYO/6ohq1pZfwQ9sjlGL0ClDJY+gJCNGqQKxfqrTagj8MNMDPY
	 xPvXCfF5oEA5g==
Subject: Re: [PATCH net-next 5/9] batman-adv: tt: only queue local del event
 after successful unlink
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:28 +0000
Message-ID: <179084942832.434549.10138352246210429649@kernel.org>
In-Reply-To: <20260930094558.3723766-6-sw@simonwunderlich.de>
References: <20260930094558.3723766-6-sw@simonwunderlich.de>
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
Message-ID-Hash: Q2JTDX7GVDZNCWOOOVGD2ZWH5SUZTT2C
X-Message-ID-Hash: Q2JTDX7GVDZNCWOOOVGD2ZWH5SUZTT2C
X-Mailman-Approved-At: Thu, 01 Oct 2026 14:15:11 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q2JTDX7GVDZNCWOOOVGD2ZWH5SUZTT2C/>
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

- [High] The fix is incomplete, and the reordering opens a new window.
- [Low] The commit fixes a TT announcement bug but has no Fixes: tag.

--

batman-adv: tt: only queue local del event after successful unlink

This commit moves the BATADV_TT_CLIENT_DEL event in
batadv_tt_local_remove_now() so it runs after batadv_hash_remove(). A
delete event is now only queued when this exact entry was unlinked. The
goal is to stop cancelling the pending add event of another local entry
with the same MAC and VLAN.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

[Severity: Low]

This isn't a runtime bug, but should this have a Fixes: tag?

The problem seems to come from bbfb0d2cf035 ("batman-adv: tt: remove only
the entry which was looked up from the hash"). That commit changed the
unlink in batadv_tt_local_remove() from batadv_compare_tt to
batadv_compare_tt_entry. It kept the unconditional delete event in front
of the unlink.

931de98d3960 ("batman-adv: tt: extract immediate purge of a local entry")
only moved that code into batadv_tt_local_remove_now().

Other fixes in the same series have Fixes: tags, for example "batman-adv:
tt: queue local DEL event under bucket lock". Perhaps something like:

Fixes: bbfb0d2cf035 ("batman-adv: tt: remove only the entry which was looked up from the hash")

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 354d9416c1b75..c904d67791f8f 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1496,8 +1496,6 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
>  	struct batadv_tt_common_entry *common = &tt_local_entry->common;
>  	struct hlist_node *tt_removed_node;
>  
> -	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
> -
>  	/* remove exactly this object when still present in hash */
>  	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
>  					     batadv_compare_tt_entry,
> @@ -1505,6 +1503,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
>  	if (!tt_removed_node)
>  		return;
>  
> +	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
> +

[Severity: High]

Does this reordering open a new window in which a replacement entry's add
event gets dropped?

batadv_hash_remove() takes and releases the bucket list_lock before it
returns. batadv_tt_local_event() only takes tt.changes_list_lock after
that. Nothing seems to serialize this gap against batadv_tt_local_add()
called from batadv_interface_tx() for the same MAC and VID.

The remove side can be reached from a remote TT announcement:

batadv_tt_global_add()
  batadv_tt_global_purge_local()
    batadv_tt_local_remove()
      batadv_tt_local_remove_now()

Consider entry E, which is still NEW and has a queued add event:

CPU0 (remove path)
batadv_hash_remove(E)
  /* E unlinked, its add event still queued */

CPU1 (batadv_tt_local_add())
batadv_tt_local_hash_find()      /* misses E */
batadv_tt_local_create()         /* new entry E' */
batadv_hash_add(E')
batadv_tt_local_event(E', BATADV_NO_FLAGS)
  /* same addr/vid as E's pending add, so only flags are updated */

CPU0
batadv_tt_local_event(E, BATADV_TT_CLIENT_DEL)
  /* matches the remaining add by addr/vid only */
  if (del_op_requested != del_op_entry) {
      list_del(&entry->list);
      kmem_cache_free(batadv_tt_change_cache, entry);
      changes--;

E' is then in tt.local_hash with BATADV_TT_CLIENT_NEW set and no add
event queued. The commit message says this should be prevented.

Later packets from the client do not queue it again, because
batadv_tt_local_add_existing() returns false for a NEW entry that is not
PENDING.

If local_changes drops to 0, batadv_tt_local_commit_changes_nolock()
returns early and E' stays unannounced. A later unrelated commit would
move E' into the CRC through batadv_tt_local_transition_new() without an
add diff. Neighbours would then see a CRC mismatch and fall back to full
table requests.

Before this patch the delete event was queued while E was still in the
hash. An add that ran after the unlink would then get a fresh add event
that nothing cancels.

The later patches in the series don't seem to change this part of
batadv_tt_local_remove_now().

Could the delete event instead be queued inside the same bucket list_lock
critical section as the unlink, and only when this exact object was
found? batadv_tt_local_set_pending() in "batman-adv: tt: queue local DEL
event under bucket lock" already takes list_lock and then
changes_list_lock in that order.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
