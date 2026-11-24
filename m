Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BA606A32E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCa2s9rw
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3079F807A3
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:28:17 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541297;
 b=wzC5ShL5Qa5U6sEVUYOEuZHRCxzrArBGF6JJxFPMVdeGVTZa5Ja97Hk0NkrIJtoObZ9+j
 BQp1gYPuN8sRiTm/sPZ8OwZWnYhQBNYOWN2wITArzuyttaH/cir3ssgQYpYE7fVL72jGqiW
 mbHq2ruFcfSS10cK7kEycxmSritWn2I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541297; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3AaHa7wUvfXbgjXKSaJH9L1BQGA+L/wa6rMO4rpmjeI=;
 b=uQDw91u40eb38KL86iJzsoBznHFbI/A79d+juDD4sr7Q3GiPuGtP7r4zVqLxqFZRrOCtk
 SAxPsc8C8nu0kam1vEBfuYobhaJUSig3d40+pFQqHkWqAUuGzRAAcnZncmPM9y/gLFpGroc
 0b9M9duRre9bp7Qj++V6ae8l2z11M20=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7C96880B6E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540858;
	b=LcjyLa+GAsGGEd2Bij+p0ATCkMCrlshVqfUKGOV5Xj+bcOozhfQB2/whLfnM1jbZU0yl6p
	uAZsKNq75dNDp5nB9G9IO0FUJ+x7awi4NTvzQCsaEFoYV8eUp8TWxr3DwY7+OnbFy16tMS
	zCPEIU5QQaZihm/GC6yFYGtarJQVUOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3AaHa7wUvfXbgjXKSaJH9L1BQGA+L/wa6rMO4rpmjeI=;
	b=ncs/D5YSm46TCf92fRLtZGNSbWVwVe1YtQgQRbk6BP4KFF4H8AJ1lyctRV/zur/21gg6G9
	FnQtXTaAmAEZqg59NhYHTVFmkC4QDeH4aJ5+r385FYOe5zWvcJwqZoIJB39zW1g9MnGyC3
	yThvywItj2y+f2rKON0YygdWaRo0QjM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cCa2s9rw;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F7C940407;
	Tue, 24 Nov 2026 17:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914811F000D3;
	Tue, 24 Nov 2026 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540847;
	bh=3AaHa7wUvfXbgjXKSaJH9L1BQGA+L/wa6rMO4rpmjeI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cCa2s9rw9bd5FmH+j5Jo8eJUhcAvO3VZ/gLWj4PN10g6F1viGQS5VrgFfZxCGeRja
	 6pnvQqn1alJ5mDRc6RX4vpFvJhwh1z6z5k2fgteCqh4S51YcR56PAditcDNzuhPjlS
	 TWnICZ0EqpHAEgOboB3jHvVFBxuSup8J2oNDp3ySj7UXowz+KX7S2YT+743o+NV+q/
	 k+54UBHgcRA2KtHptucm2UIFXkVEFQRH8EVqF2hVCc7Epii25iOBrQjunDvObCDQ3K
	 U68ZeEBpmExuAWy7EGoqCdG2Plsqks0+ig8b2fr4wjb0Zvhuwzq9RE+Cf79LYrvsdF
	 p66LMN3dWNmiQ==
Subject: Re: [PATCH net-next 12/15] batman-adv: tt: extract removal of pending
 local entry
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:46 +0000
Message-ID: <179554084613.3135.2138652598368843379@kernel.org>
In-Reply-To: <20261123171827.3294525-13-sw@simonwunderlich.de>
References: <20261123171827.3294525-13-sw@simonwunderlich.de>
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
Message-ID-Hash: NGXSR4GIBO3MOI2R7ER36M5H5YHBK6PY
X-Message-ID-Hash: NGXSR4GIBO3MOI2R7ER36M5H5YHBK6PY
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:25 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NGXSR4GIBO3MOI2R7ER36M5H5YHBK6PY/>
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

- [Low] The kernel-docs of batadv_tt_local_unhash() and
  batadv_tt_local_unhash_pending() disagree about who checks that the…

--

batman-adv: tt: extract removal of pending local entry

This moves the removal of a single pending entry out of
batadv_tt_local_purge_pending_clients() into a new helper,
batadv_tt_local_unhash_pending(). The helper calls a lower level
batadv_tt_local_unhash(), which does the actual unhash steps. There is
no functional change.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 0c5e21f3ba756..2a7f50de70fc8 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1760,6 +1760,44 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
>  	return ret;
>  }
>  
> +/**
> + * batadv_tt_local_unhash() - remove an entry from the local table
> + * @bat_priv: the bat priv with all the mesh interface information
> + * @tt_local: the local TT entry to remove
> + * @message: message to append to the log on deletion
> + *
> + * The caller must hold the hash bucket list_lock and the flags_lock of the
> + * entry. It must have checked that the entry is still part of the local table
> + * and has to drop the reference of the hash after it released the flags_lock.
> + */

[ ... ]

> @@ -4550,6 +4588,43 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
>  	}
>  }
>  
> +/**
> + * batadv_tt_local_unhash_pending() - remove a pending entry from the local table
> + * @bat_priv: the bat priv with all the mesh interface information
> + * @tt_local: the local TT entry to remove
> + *
> + * Only an entry which is marked as BATADV_TT_CLIENT_PENDING and whose DEL was
> + * queued is removed. An entry which still waits for its DEL (del_unqueued) must
> + * stay in the local table until batadv_tt_local_purge_list() was able to queue
> + * it.
> + *
> + * The caller must hold the hash bucket list_lock and the flags_lock of the
> + * entry.
> + *
> + * Return: true if the entry was unhashed and the caller has to drop the
> + * reference of the hash, false otherwise.
> + */
> +static bool
> +batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,
> +			       struct batadv_tt_local_entry *tt_local)
> +	__must_hold(&tt_local->common.flags_lock)
> +{
> +	struct batadv_tt_common_entry *tt_common = &tt_local->common;
> +
> +	lockdep_assert_held(&tt_common->flags_lock);
> +
> +	if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
> +		return false;
> +
> +	/* the removal must be announced first */
> +	if (tt_local->del_unqueued)
> +		return false;
> +
> +	batadv_tt_local_unhash(bat_priv, tt_local, "pending");
> +
> +	return true;
> +}

[Severity: Low]
This isn't a bug, but the kernel-doc of batadv_tt_local_unhash_pending()
seems to leave out a requirement it inherits from batadv_tt_local_unhash().

The kernel-doc of batadv_tt_local_unhash() says the caller "must have
checked that the entry is still part of the local table". That function
does not check hlist_unhashed() itself. It always calls
hlist_del_init_rcu(), increments hash->generation and calls
batadv_tt_local_size_dec() for entries without BATADV_TT_CLIENT_NEW.

batadv_tt_local_unhash_pending() checks only BATADV_TT_CLIENT_PENDING and
del_unqueued before it calls batadv_tt_local_unhash(). Its kernel-doc asks
callers only to hold the bucket list_lock and the flags_lock. It still
says that a true return means the caller must drop the hash reference.

batadv_tt_local_unhash() does not clear the flags. So an entry that was
already unhashed can still have BATADV_TT_CLIENT_PENDING set with
del_unqueued false.

A caller that relied only on the documented contract of the wrapper could
pass such an entry and get true back. The per-VID size would then be
decremented twice and the hash reference put twice.

There is no such caller now. Both batadv_tt_local_purge_pending_clients()
and the batadv_tt_local_commit_change() caller added later in the series
find the entry by walking the bucket under list_lock.

Could the kernel-doc of batadv_tt_local_unhash_pending() state the same
membership requirement as batadv_tt_local_unhash()? Another option would
be an hlist_unhashed() check inside the wrapper.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
