Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44063606A324
	for <batman@archiver.kernel.org>; Sun,  1 Nov 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeFpMrWz
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DB8CA84036
	for <batman@archiver.kernel.org>; Sun, 01 Nov 2026 16:27:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793546839;
 b=EzH59AYauYZlSTrwy8m6NPa9dF/nBLN9piH1o07ldr9vwJigwB8Uxrlk8UpzCkXEBQI2m
 xIRwLp3+3nJTjv06Ml4TmsHHBg+pKFQuIXT2B92xxJ1yvavinMQkumQITtwL4aYTg8zhnMv
 kifvLFZ0b0WFKjjf8X3gEfhQajPW4EY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793546839; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EWk1o24hNVLI6fMDx2Ljuovu3/zKSyHGHALwckQZDtU=;
 b=M5FteMc14v1AXl/32VbUCsfBdTlrxPGnIbsPfgzD0AzcRMz9kRCQxv1FBTD8tVUjvKvsU
 YdcNMWQE2SKzET2VUs9P+O7iOBWmD7H+CJo7PHwGerOp86R6GRNyNWjjVbZfgTebn2Sk+uq
 TkI5Pv6nys9WpOZalXYooVicRUqxTBA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F13758072E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 01 Nov 2026 14:52:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793541151;
	b=mlKAKMEBQ+5tvUvUaV7FIT5vEQoOKEKCZsc5pMVrohHem+vaKcn4XynmiHP4uBsYJlFjkT
	VsbozJ/XOw79AkW1MovhQsBGf0ob4bPYiIB2DxVLvWYeZAv8RY8JNbbUcfAyLn56g3hepB
	x/esWF4ip6HgdVIZYD99BQhApGcCZg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793541151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EWk1o24hNVLI6fMDx2Ljuovu3/zKSyHGHALwckQZDtU=;
	b=0nKqku2ai+zGuEgauObvsV9qF/z0hT5CinRIgl55UDISUMVZcY5YMBWw6CabA0m7j5ik5D
	nq20ffAnbgh9W1bbPnLZJzx86ZmHGekK2L3PHSwU3ogOyarnfwdeKgdsgVYhOPilhIHIjf
	CXoJvaQ3v5/+qg13bkJXaapnSaD+oKQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FeFpMrWz;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E1ED143B95;
	Sun,  1 Nov 2026 13:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C751F000C1;
	Sun,  1 Nov 2026 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793541148;
	bh=EWk1o24hNVLI6fMDx2Ljuovu3/zKSyHGHALwckQZDtU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FeFpMrWzZwvt7lYtODCQjif7PfV4/ocTOlCv2ATVqb5hVXeXIxNCqvLtoe/h2RlZy
	 sxUauEJAxCs8NraEvaYQKbZM4jtL0g6jfb21uL4+mI+JUniUq1Sxf93ILV9HUMJ1zd
	 BZuRzYyoCb2S5Ok7dK7K6bmB8rDrBLBf5FFpM0y/aLSV9IA3GciRYlK0zeTwZg/59q
	 SeFdmtW+luPNJFUfkL2tghCMn87wVVWsatVBKBIwZntVyOc6XQ4S0ozy7KRhq0v000
	 XNwsi4ikbRcynoDeV7/g75RdVVh9D0VsOkD9wEqaNRI/V1CHg9YmX5Ctbaizc8ICRB
	 LF4XQAeyzBoQQ==
Subject: Re: [PATCH net v2 12/14] batman-adv: tt: only update flags for TT
 events
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Sun, 01 Nov 2026 13:52:27 +0000
Message-ID: <179354114771.3131.18425781657657497381@kernel.org>
In-Reply-To: <20261030135105.2555887-13-sw@simonwunderlich.de>
References: <20261030135105.2555887-13-sw@simonwunderlich.de>
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
Message-ID-Hash: D7U7KCR2OFPHPEQMZGECJMQCOYBHL6SZ
X-Message-ID-Hash: D7U7KCR2OFPHPEQMZGECJMQCOYBHL6SZ
X-Mailman-Approved-At: Sun, 01 Nov 2026 16:27:06 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D7U7KCR2OFPHPEQMZGECJMQCOYBHL6SZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
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

- [Medium] The patch now treats each new TT event as the client's latest
  state and writes its flags over any queued change for the same…
- [Low] Claimed mismatch between the kernel-doc and the new behaviour for
  NEW clients.

--

batman-adv: tt: only update flags for TT events

This commit changes __batadv_tt_local_event(). DEL+ADD and ADD+DEL pairs
for the same client no longer cancel each other. Instead, a new event
overwrites the flags of the change that is already queued. This keeps a
DEL that follows a flag-update ADD, and it keeps an ADD with new flags
that follows a DEL.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 247cce95c09f4..fa5ead248f192 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -665,25 +667,12 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
>  		if (entry->change.vid != tt_change_node->change.vid)
>  			continue;
>  
> -		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
> -		if (del_op_requested != del_op_entry) {
> -			/* DEL+ADD in the same orig interval have no effect and
> -			 * can be removed to avoid silly behaviour on the
> -			 * receiver side. The  other way around (ADD+DEL) can
> -			 * happen in case of roaming of  a client still in the
> -			 * NEW state. Roaming of NEW clients is now possible due
> -			 * to automatically recognition of "temporary" clients
> -			 */
> -			list_del(&entry->list);
> -			kmem_cache_free(batadv_tt_change_cache, entry);
> -			changes--;

[Severity: Low]

This isn't a bug, but for a client still in the NEW state, the ADD+DEL
pair used to cancel. It is now kept as an announced DEL:

batadv_tt_local_remove()
  batadv_tt_local_mark_removed()   <- breaks out for BATADV_TT_CLIENT_NEW
  batadv_tt_local_remove_now()
    batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);

When a NEW client is added and removed within one OGM interval, this
causes an extra TTVN increment. It also puts a DEL entry in the TT diff
for a client that was never announced.

Receivers seem to treat that DEL as a no-op, because batadv_tt_global_del()
bails out when batadv_tt_global_hash_find() finds nothing. The commit
message also says the extra event is accepted for now ("The first and the
last type of event could in theory still be removed together ...").

Is the extra announcement intended for the NEW-client case, or would it be
worth keeping the cancellation there?

> -		} else {
> -			/* this is a second add or del in the same originator
> -			 * interval. It could mean that flags have been changed
> -			 * (e.g. double add): update them
> -			 */
> -			entry->change.flags = flags;
> -		}
> +		/* the other nodes may know the client with different
> +		 * flags. A DEL+ADD must therefore still announce the
> +		 * current flags and an ADD+DEL must still remove the
> +		 * client. ADD+ADD and DEL+DEL only update the flags
> +		 */
> +		entry->change.flags = flags;

[Severity: Medium]

Does this overwrite rely on events reaching changes_list_lock in the same
order as the state changes they describe?

batadv_tt_local_event() takes its flags snapshot under flags_lock. It
releases that lock before __batadv_tt_local_event() takes
changes_list_lock:

net/batman-adv/translation-table.c:batadv_tt_local_event() {
	...
	flags = batadv_tt_flags_get(common) | event_flags;
	__batadv_tt_local_event(bat_priv, common, flags);
}

The ADD callers in batadv_tt_local_add() hold neither the bucket list_lock
nor flags_lock here. The DEL paths queue their event either under those
locks (batadv_tt_local_set_pending()) or after removing the entry from the
hash (batadv_tt_local_remove_now()). Nothing orders either DEL path against
a concurrent ADD.

Here is the sequence for a new client:

CPU A (TX path)
batadv_interface_tx()
  batadv_tt_local_add()
    batadv_tt_local_create()
    batadv_hash_add()             <- entry is now visible
    batadv_tt_local_event(ADD)
      batadv_tt_flags_get()
                                  CPU B (RX path)
                                  batadv_tt_global_add()
                                    batadv_tt_global_purge_local()
                                      batadv_tt_local_remove()
                                        batadv_tt_local_mark_removed()
                                          <- NEW, not set pending
                                        batadv_tt_local_remove_now()
                                          batadv_hash_remove()
                                          batadv_tt_local_event(DEL)
      __batadv_tt_local_event()
        entry->change.flags = flags;  <- queued DEL becomes ADD

Before this patch the DEL+ADD pair cancelled. That gave the right result
in this case, because the client was never announced and is no longer in
the local hash.

With this change, can an ADD be announced for a client that is no longer
in the local table?

The same window exists for an existing client. batadv_tt_local_add() can
take the ADD snapshot after batadv_tt_local_update_flags(), and
batadv_tt_local_set_pending() can then queue DEL|... before the ADD gets
changes_list_lock. The DEL was also lost in this ordering before the
patch. Now the stale ADD replaces it as the latest state.

In both cases, remote global tables would keep a client that the local
node removes, through batadv_tt_local_purge_pending_clients() at the next
commit in the second case. This lasts until a CRC mismatch triggers a full
table request.

As far as I can tell, the later patches in this series don't change
batadv_tt_local_event() or __batadv_tt_local_event(), so the window is
still there at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030135105.2555887-2-sw%40simonwunderlich.de
