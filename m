Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E437606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlQlFrxo
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6FF8B832E3
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:25:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541118;
 b=FIkYi7nHsEt11d4iaVGcf/t+5rCXnLVN/vJqHmUe3BV/u7ZKaBSE1pwJWYz9dacaEzjb0
 cevDZrn1RPoqo6ql8SlA8kJdP+Aj0lm9zoDMMHMUXtUexg/oQo+Cef5X22/4GVAdChdOyWb
 prgtgjibO1EOsBpHLFtC97X/XcoBz4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541118; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=X8JHW0SkUZKnUVH13i74k2v1LzOsJddb26647MR2yus=;
 b=RUaFjCnpid0QuOvS0B61SPVEO+MaBegilKGHtRQNfuzkaS0sMUS0cI3pxcZrkUoGcjR20
 b5JtOdTFS6G+zcNXvI5KderoXVjhHw9ElGoXXKpw7HNO/n+tMyLr3uwtUyXk7J2X+1ExZws
 A8F3lsv5mKgnVWoiuENe/G+WhHGOCbQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CF07E8082E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540851;
	b=t6I1UnxAV/EGKRfdT3eV29A5YAyOJffIMriYx417+BFBmVBvWtsdthpsYfzMVwxe+BL3WP
	voVbksfMIbDs/WqLtbFG4NCdh/bLMP7rLdiz1Hmcnw28H616EP6mUkZhUoTW7UR74w0Bsa
	h0z80fBh9Im9a+pVZTGP1bFPowhPm+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=X8JHW0SkUZKnUVH13i74k2v1LzOsJddb26647MR2yus=;
	b=d9BSQ2kYtNwZQgD69QUTa0cl9fKFqh+/k/k6UTSGBBRTbBNLcD0ifriCaBqTU5KcBUUCpG
	2t/vffaQ3M5ylp3gs4NZLdZ9dEPiqoWOH475IiD92FxOemJdM2IGUIKZ+xpjVFB4nGWuCr
	9LK/Z1VfcfL5CcpvitViAuv36HFeoH8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AlQlFrxo;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FB6641709;
	Tue, 24 Nov 2026 17:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76A01F000E6;
	Tue, 24 Nov 2026 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540838;
	bh=X8JHW0SkUZKnUVH13i74k2v1LzOsJddb26647MR2yus=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AlQlFrxoaSA6KFjAOJaJxy9YUcC3gMUpEl3ef3axLSRwEjE5gr6YnZ+TWs6OKLGRN
	 2vQUfj1tyzROl7BsEngwdRKBbCjEIXmw1VokiPedLHjCyhYNNpJc4nT7SzaDutNFgb
	 ONZCoty29WNi2NiVn82ZIj6pcPrX79s4xAOoDTrkX8PbE4hQ7n1L/Z9YMqTYnG6yeC
	 ojxMi4MsbYPp+NLWW3czyaw281I93kxKuT/Geg5In4jC6ndRhOsqUizGSyX+Yz//Z4
	 ouRQt5iM1GR4FWsDnfEz3f5CyIfIM82KM8MHKEthVVmaPgkUk1GG05S6kfIxinbFda
	 rpiFMKY899NzQ==
Subject: Re: [PATCH net-next 01/15] batman-adv: document refcount of returned
 objects
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:37 +0000
Message-ID: <179554083742.3135.4885971613759489815@kernel.org>
In-Reply-To: <20261123171827.3294525-2-sw@simonwunderlich.de>
References: <20261123171827.3294525-2-sw@simonwunderlich.de>
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
Message-ID-Hash: FFB4SLIQFMTNAGQ6AJPLWNTDMRTGYVHM
X-Message-ID-Hash: FFB4SLIQFMTNAGQ6AJPLWNTDMRTGYVHM
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:11 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FFB4SLIQFMTNAGQ6AJPLWNTDMRTGYVHM/>
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

- [Low] The commit message does not match the diff.

--

batman-adv: document refcount of returned objects

This patch adds a kerneldoc note to the batman-adv lookup, get and create
functions that return an object with an increased refcounter. For
batadv_transtable_best_orig() and batadv_mcast_forw_orig_entry(), it notes
the opposite: the returned object is only borrowed within the caller's
RCU read-side critical section.

> Add a note to the kerneldoc of the __must_check functions that return an
> object with an increased refcounter and did not document this yet. For the
> exceptions:

[Severity: Low]
This isn't a bug, but the commit message doesn't quite match the diff.

Earlier, the message gives "(with increased refcnt)" as an example of
wording that already documents this. The diff then removes that wording
and rewrites it in batadv_gw_get_selected_gw_node(),
batadv_gw_get_selected_orig(), batadv_hardif_get_by_netdev(),
batadv_primary_if_get_selected(), batadv_orig_hash_find() and all of the
netlink.c getters.

The same happens to "with an initialized reference counter" in
batadv_tt_local_create() and batadv_tt_global_create(). It also happens to
"it with an increased refcounter" in batadv_tt_global_orig_entry_find().

On the other hand, the other existing phrasing is left alone:

    * The object is returned with refcounter increased by 1.

It is still in batadv_orig_node_vlan_new(), batadv_orig_router_get(),
batadv_orig_ifinfo_get(), batadv_orig_ifinfo_new(),
batadv_neigh_ifinfo_get(), batadv_neigh_ifinfo_new() and
batadv_last_bonding_get().

So the patch does more than add notes where none existed, but it also
doesn't make all of the refcount wording consistent. Could the commit
message say that existing refcount wording is being rewritten?
Alternatively, could the remaining "increased by 1" comments be converted
too, so the wording is consistent?

> diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
> index e6e97c0478cc4..0dddcea7def9d 100644
> --- a/net/batman-adv/gateway_client.c
> +++ b/net/batman-adv/gateway_client.c
> @@ -74,7 +74,8 @@ void batadv_gw_node_release(struct kref *ref)
>   * batadv_gw_get_selected_gw_node() - Get currently selected gateway
>   * @bat_priv: the bat priv with all the mesh interface information
>   *
> - * Return: selected gateway (with increased refcnt), NULL on errors
> + * Return: selected gateway, NULL on errors.
> + * The returned object has an increased refcounter.
>   */

[ ... ]

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index f9de255ef0dfd..216f41387afa7 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -962,8 +965,8 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
>   * as BATADV_TT_CLIENT_NEW to avoid sending it in a full table response going
>   * out before the next ttvn increment (consistency check).
>   *
> - * Return: the new entry with an initialized reference counter on success, NULL
> - * otherwise.
> + * Return: the new entry on success, NULL otherwise.
> + * The returned object has an increased refcounter.
>   */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
