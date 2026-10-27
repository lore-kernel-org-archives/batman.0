Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A3606A321
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu0au9NQ
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5DA3F85689
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 10:02:15 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793091735;
 b=0Y8pizQHqnaTVbNCD7616KjgU9ImHJjPv3YRVCZBaPacLUkrQZjCtHIo7KZrrjMtE3bge
 tuOlxLTMiiP//OncBvzt6WEoSFlm+5u6WMajN1Wru/CB2kSBlOdKEj26XN/916EZhI7xiVq
 P/zpt/5ilNW2k8xXsjTc0bV7aRzwgEw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793091735; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RYGIIRLJleypOVfIwOcBtPmaAc6iH0lPsv0VdUsb1Xs=;
 b=UjPjlmA+Mf6lWW5Z3MBy+pilQdNbheQrYZR+Ya2n+l17UGtTyn4FRS55I3XEjoOBXHjcg
 R4NwHgmszFqdalKgIeSMRafApUJ2zecfHGZ3LBIn3rKXO/A9i6Pk9k+t8df4FHBHiY6my0J
 D4OZopDSJ3vdEeN5obozHRTXZSfytjE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1907C81350
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 09:55:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793091335;
	b=GI6QyNjPPLLklNcr6cyvoBPqVNCHnpjt/BjDQvIBJV4Dt0poekgVkwE7kupXnoSf6fdGyl
	QWv6J+rzbc4+SH65MRGHP+OT33kIbjaMuqQ2qmZG/TC4wHtqevqNY4KCUtx/uuM5A9ja6d
	GoBDsK17v4406+ZiGgsRsaCpDhneqiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793091335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RYGIIRLJleypOVfIwOcBtPmaAc6iH0lPsv0VdUsb1Xs=;
	b=piT7hOF6Zqz6Gj08TY2XiXClSNJYTtIM+5G9xBxPkMcGPteFbYjsTWU9M422wDvmm+7vcW
	Mvoh4gJ749csEvMUbZzs+0QKoU2bFgM2NQElLn+vlGmpK4Z/vm4vd4R3jrgswc9JOiOsyO
	yjZE3AY+MHDb4+zIK5uGCWv8czmwkU8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lu0au9NQ;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6EC4F42BA4;
	Tue, 27 Oct 2026 08:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE01F1F01825;
	Tue, 27 Oct 2026 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091322;
	bh=RYGIIRLJleypOVfIwOcBtPmaAc6iH0lPsv0VdUsb1Xs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lu0au9NQOg9keKTYJj7WeCRVO90Eq2tSmN9ByyTtDkS6oU+5au9Q0RIAK0+cau/lL
	 nObTrk+TA3SsUfMLzd06/qccxOVFRddLXgAp2fHA2b+TS3iXqplVOOpqZ91zb+IuPI
	 L6MwNzO/q+cN75I66amTKFETAZNxsYPz3P6OetNQoApDGaJg1Afg/whzmzkh3r4UaV
	 hvvJ/U0tzuieH5sXa7gsPzHpOuVPPobb1lAJdiB+NlizmNUyVpreHkzSviI6aY6SgM
	 G+5xPpfKAfz+oat+E/2gVyjIW3vghunq0V7NUQ5vd31KkQ72XjeY53kVYwAq1jRaU2
	 vkdS0mfNXMUPg==
Subject: Re: [PATCH net 02/10] batman-adv: Close OGM aggregation before
 transmission
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Tue, 27 Oct 2026 08:55:21 +0000
Message-ID: <179309132139.3134.350154128482754175@kernel.org>
In-Reply-To: <20261026085309.1074911-3-sw@simonwunderlich.de>
References: <20261026085309.1074911-3-sw@simonwunderlich.de>
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
Message-ID-Hash: 4KNYR4FU3GSQZJQMR7NY4LPKRRADFBCP
X-Message-ID-Hash: 4KNYR4FU3GSQZJQMR7NY4LPKRRADFBCP
X-Mailman-Approved-At: Tue, 27 Oct 2026 10:02:02 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4KNYR4FU3GSQZJQMR7NY4LPKRRADFBCP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch gives `struct batadv_forw_packet::num_packets` a second
  meaning without updating its kernel-doc.

--

batman-adv: Close OGM aggregation before transmission

This patch makes the OGM send worker mark the forwarding packet as a full
aggregate under forw_bat_list_lock before it calls batadv_iv_ogm_emit().
After that, no other context can append OGMs while the packet is being
emitted and cloned. The packet stays on forw_bat_list so interface purging
can still find it.

> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index 158d2b8f04036..85e99506a53f5 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
>  		goto out;
>  	}
>  
> +	/* Mark aggregate as full before forcing emit. */
> +	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> +	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
> +	spin_unlock_bh(&bat_priv->forw_bat_list_lock);

[Severity: Low]
This isn't a bug, but should the kernel-doc for num_packets be updated
to match this new use?

In net/batman-adv/types.h the field is still documented as a plain
counter:

	/** @num_packets: counter for aggregated OGMv1 packets */
	u8 num_packets;

After this change, the worker in
batadv_iv_send_outstanding_bat_ogm_packet() replaces the real count with
BATADV_MAX_AGGREGATION_PACKETS, whatever the number of queued OGMs is.
For example, an aggregate holding 3 OGMs reports 32 from then on. The
field is now both a counter and a "closed for aggregation" marker, and
only the comment at this call site says so.

As far as I can tell, nothing reads the inflated value today:

- batadv_iv_ogm_can_aggregate() rejects packet_num >=
  BATADV_MAX_AGGREGATION_PACKETS under the same lock.
- batadv_iv_ogm_aggregate() is only reached after that check passes, so
  set_bit(num_packets, direct_link_flags) cannot index past the bitmap.
- batadv_iv_ogm_send_to_if() walks the OGMs using packet_len and a local
  counter.

A short note in the struct documentation would help later readers who
rely on the field description.

>  	batadv_iv_ogm_emit(forw_packet);
>  
>  	/* we have to have at least one packet in the queue to determine the

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de
