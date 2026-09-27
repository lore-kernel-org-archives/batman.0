Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D652DC9830E
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 08:19:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E162C83FBA
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 10:19:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790497165;
 b=uDBHoAzCSxg+pOpHoLy5FPPJO2s03r3jqfAOIKh06VHbwAzpc6sTYK228ZPOw1SxX/evh
 1jQQETKX3QfHiyKJdsML84YjPTO+bmzr/jT0aLFziEy9LtddSWJM909KZ+qnIxIYB630JRj
 ltaHs6g9r6kgkev0lT1s32osyuf6sHo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790497165; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=He0WY3jCbriwnigCsrMUly3CG2kXHpH728uQPwmsPaI=;
 b=AOZBv2Y6j3o8lRRAra0f1YaGT455/JY1G/ke5wjJQDgGqL6vAeSl6+s/NIbKPalYMrEdI
 xTIGFjxvLD1cii2IanguYxlZ6vLvuiCZFWNQ7ElRl/3wwKX6wGIQ7IJ03FTulrHQpuye6bK
 B44SrKURSgcHlYX95kZet69Dg9hgj1Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0987381C1F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 10:19:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790497153;
	b=Tc42VpMDmwk7qtaMJbPEZ1hrP5Muf9u2HQiDObpJM9lxXfXFyNbBlU2kLgFGmSKwmcFfTY
	LdqeLfvGdltwrtg7G74/bMO6+39Rrihi12p66w7nxUHFqpAoJ6lsHKaJo5AkmF32QU47OQ
	9qVheEFX/i9TV2UG4Jkawy8beMi9FNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790497153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=He0WY3jCbriwnigCsrMUly3CG2kXHpH728uQPwmsPaI=;
	b=l+N2XQqHbd4X+7K4FIFt92vrK1Xqp1TjHmg+19rptqSHQKMUFQjAShxvlfczwVlAPAvI9D
	X2YW0zxYg0nulUFy9mvuL9DlAgh9DH/iDZc2ZQh14Om2ElbCp6Kowyb8XY6oncaOl8JsZt
	E0tKhCn8s8lZtcYyF9rSyGBHiubqQC0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vQLlBTJ4;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 30792202F3;
	Sun, 27 Sep 2026 08:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790497151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=He0WY3jCbriwnigCsrMUly3CG2kXHpH728uQPwmsPaI=;
	b=vQLlBTJ4eC3l+pNRvSFlUaxIVfk5Hojnyeh3ymiRZ75iTAVtyFWl1fMleSfdhNHUM2lP69
	Vq8wfCCoINFEiQdFKqfuZUNwQIvHLdK+CD5zMUE7dWfc4Xp4kqvBafj9FJ7IR37mVCtY1J
	yd9/npehRVseGciIjGl4GkWnW4+BxaA=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] batman-adv: Close OGM aggregation before
 transmission
From: Sven Eckelmann <sven@narfation.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
In-Reply-To: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
References: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 10:19:00 +0200
Message-Id: <179049714090.25414.9706892666916736240.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4389; i=sven@narfation.org;
 h=from:subject:message-id; bh=Eerh34NEDalT7cOEsgMj+oWM6IMiwMDKuegRj+hdGDM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7LpZHiNucl+29Nt84vbqNa/Lx+6uNAjepnhXpvduZ9
 0pxEufkjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEEm8zMqx3Wzv90rLK9E07
 01n6W1PdVtQ7lgRdb652agvdqKt2/CYjw2mrpljNztVLGjl/nmWV/plxinXZsXJJKy07ZRGxpvQ
 z/AA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7XRXM4L2AIPLYZXYBUIBMAXBVQOYQYA5
X-Message-ID-Hash: 7XRXM4L2AIPLYZXYBUIBMAXBVQOYQYA5
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7XRXM4L2AIPLYZXYBUIBMAXBVQOYQYA5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thanks for the fix.

Please don't submit batman-adv changes to netdev directly. And please send the
patch also to the person which introduced the problem. You can use tools like
`b4 prep --auto-to-cc` or just the underlying ./scripts/get_maintainer.pl 

    $ b4 mbox 20260926172600.2394088-1-nicoyip.dev@gmail.com
    $ ./scripts/get_maintainer.pl 20260926172600.2394088-1-nicoyip.dev@gmail.com.mbx
    Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED)
    Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED,blamed_fixes:1/1=100%)
    Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED)
    Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED,blamed_fixes:1/1=100%)
    "Linus Lüssing" <linus.luessing@c0d3.blue> (blamed_fixes:1/1=100%)
    b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
    linux-kernel@vger.kernel.org (open list)

This change should not go directly to net.git. The target tree must be
batadv.git

    $ ./scripts/get_maintainer.pl --scm 20260926172600.2394088-1-nicoyip.dev@gmail.com.mbx
    [...]
    git https://git.open-mesh.org/batadv.git
    git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

The last tree is irrelevant for you because it is really unlikely that Linus
Torvalds will apply your patch directly.

> The OGM send worker leaves its forwarding packet on forw_bat_list until
> after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
> but emission reads and clones the packet without that lock.
> 
> CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
> list lock, finds the same packet and appends another OGM. The sender can
> observe the new packet length before the corresponding direct-link flag
> is set, or clone the skb while its length and payload are being updated.
> This can transmit an OGM with incorrect flags or inconsistent data.
> 
> KCSAN reported:
> 
>   BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
>   write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
>   read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
>   value changed: 0x00c0 -> 0x00d8

Is there a reproducer and where can I find it?

> Set num_packets to BATADV_MAX_AGGREGATION_PACKETS under the list lock
> before emission. This waits for any ongoing append and makes the existing
> aggregation limit check reject further appends before inspecting mutable
> OGM flags. Emission walks packet_len rather than num_packets, so the
> queued contents are still sent normally. Keep the packet on the list so
> interface purging can still wait for the worker and retain its existing
> ownership of the packet when freeing it.

I might be wrong but this reads a little bit like it was written by an LLM. If
this is the case, please think about following the annotation style described
in https://docs.kernel.org/process/coding-assistants.html

> Backports before Linux 6.15 need count-handling adaptation.

This is wrong. You are depending on 434becf57bdc ("batman-adv: Limit number of
aggregated packets directly") and not the counting adaption. Of course, for
4.10.x-6.14.x, you also need to change the BATADV_MAX_AGGREGATION_PACKETS to
BITS_PER_TYPE(forw_packet->direct_link_flags)

And it doesn't belong in the commit message (like this). Please annotate the
dependencies as described in
https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-rules

> Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
>
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index 53fbdbbe8f4f7..59847299a1237 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -1909,6 +1909,10 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
>  		goto out;
>  	}
>  
> +	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> +	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
> +	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
> +

Can you add a small comment above like "mark aggregate as full before forcing
emit" (or something similar).

-- 
Sven Eckelmann <sven@narfation.org>
