Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4731CCA5FE6
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 22:05:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 88C788409C
	for <batman@archiver.kernel.org>; Sat, 03 Oct 2026 00:05:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790978726;
 b=hJdw4JmYelgiLDJ8FmDjAF6Jb0jooKyX68yDumyru4Hm0aRUFrQJfbNUJ2Ai0W4DEBnme
 8noZ+NaXL4yU4MvWyLVY2HgbxCfOB8Nv7aOK23NPbMhv+0bKKVz2TbvUJ5PXVQZMvhU6dQE
 NYB1bQFPKnT1gjykIUHqM8F7f4+CeJw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790978726; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GNvw00UCUW/0bO/7q1Yy7pulx8K0aP4KiltkrXhApqY=;
 b=OwXhDaUWp5svxmgtR/+Yt2sElIJirEf62NzE1IpUpmzaswiT1NTD/wZPY89jMXJpHJFx+
 YLEZkSzehJs9HP0I9kfvhgkNyQC3SKExi5HdxGjtHkZgZ8AsAMp3lQakFq8gijIOvMYU41g
 ds6PRsu+vJTmUlTFIV+Ny0/XFpZquUU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4BA28807F8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 03 Oct 2026 00:05:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790978717;
	b=4D2Kfwd+EdT+HJ+h0L/garYHM1jP+hesqxw0MQbxCslOiF/j9Nx5RRPofuL1oIPZw+O6/Q
	glXp2Gr/kD8X3US8kPfBv1erx7eiELB85VW8ngQ1CsbVnwuOq02BVnnSApFHtDsNC0TUh0
	zP7jc+TfSF4kOwzpid9Dmyg2yue4E5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790978717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GNvw00UCUW/0bO/7q1Yy7pulx8K0aP4KiltkrXhApqY=;
	b=M3QSxRdtjxkilUTe89Xo07rCbr+qYidxhAhziKzhLm/TUW2ypOhjwB8FM04eG3d4YYhwWb
	hdqC4i1yI+WgJfZjC+tzxupjsbUX3qmfJn1GE08D9f09HdBa8A5+NHVjizN9v2UCrG+28b
	xgF9+xh5khGlIHfXex766oWfvMJs7wk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=uExVwByN;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 696382046C;
	Fri, 02 Oct 2026 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790978716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNvw00UCUW/0bO/7q1Yy7pulx8K0aP4KiltkrXhApqY=;
	b=uExVwByNcR78Kw5tcPlA8m5DnlP3A9/4PbXahxAGHjeX0LglxYH/UDOWCI3Fx0t2MxAuVX
	QZGu4lCd65HRBfSMLKL+VJMWr57Ub3IVmY8tEO2BbxJf0FmnAUAe/niF3kRFNCHJP4rv1x
	lVj1u83dSX9a/1zeRbZsq+5GPEoPPO4=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 8/9] batman-adv: tt: reject VLAN/TT entries
 before
 reaching size limit
Date: Sat, 03 Oct 2026 00:05:13 +0200
Message-ID: <2653823.Sgy9Pd6rRy@sven-desktop>
In-Reply-To: <179084943174.434549.11209044496055868169@kernel.org>
References: <20260930094558.3723766-9-sw@simonwunderlich.de>
 <179084943174.434549.11209044496055868169@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3881024.RUnXabflUD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: A7J2KGGB6H3R4MAXW7TP3IHYXAVMDGH7
X-Message-ID-Hash: A7J2KGGB6H3R4MAXW7TP3IHYXAVMDGH7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/A7J2KGGB6H3R4MAXW7TP3IHYXAVMDGH7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3881024.RUnXabflUD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Sat, 03 Oct 2026 00:05:13 +0200
Message-ID: <2653823.Sgy9Pd6rRy@sven-desktop>
In-Reply-To: <179084943174.434549.11209044496055868169@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:31 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> [Severity: Low]
> Should this have a Fixes: tag, and maybe a Cc to stable?

No, the change is not suitable for stable backports. And since it is submitted 
for net-next, I am not allowed to add Fixes: (for old kernels) or Cc: stable@ tags.

[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 481dc6afaaba1..3349376a9087d 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -234,6 +234,162 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
> 
> [ ... ]
> 
> > +static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
> > +				    u16 num_entries, int *table_size)
> > +{
> > +	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> > +
> > +	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
> > +		bat_priv->tt.reserved_vlans += num_vlan;
> > +		bat_priv->tt.reserved_entries += num_entries;
> > +
> > +		*table_size = batadv_tt_local_transmit_size(bat_priv->tt.reserved_vlans,
> > +							    bat_priv->tt.reserved_entries);
> > +		if (*table_size <= packet_size_max)
> > +			return true;
> 
> [Severity: Medium]
> Can bat_priv->tt.reserved_entries wrap here?
>
> The new counters in struct batadv_priv_tt are u16. The only bound on them
> is packet_size_max, and nothing caps packet_size_max at what a single TT
> TVLV can hold. When fragmentation is disabled, batadv_hardif_min_mtu()
> skips the clamp:

This is actually a good point. I didn't think about the case of an extremely 
large MTU and used a 9000/64K MTU in my head as reason for using only u16. I 
still consider it as a corner case and will submit a follow up patch for it.


> If packet_size_max is above roughly 65535, the table can still grow past
> what batadv_tt_prepare_tvlv_local_data() can build, because tvlv_len is a
> u16:
> 
> 	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
> 		tvlv_len = 0;
> 		*tt_len = 0;
> 		goto out;
> 	}

Correct, so widening over u16 doesn't make any sense. It seems to be better to 
just limit the size of the packet against which it is checked:

Will be submitted later to netdev as follow up check because it is not a 
regression but just a limitation in the supported packet_size_max limits (for 
non-standard setups).

https://lore.kernel.org/r/20261003-tvlv-limited-tt-response-reservation-v1-1-82fbca929cd9@narfation.org

Regards,
	Sven

--nextPart3881024.RUnXabflUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasAqmQAKCRBND3cr0xT1
yzWBAP0WNBEmBd8u8mbzWIsGBUe2DLQV3yZCvFe/k5tsK1/hSgD9FW9xaMmfG1CI
Qx/yW8Lbr+K6Jlns4DDpSs+KUR0SGgU=
=ByNZ
-----END PGP SIGNATURE-----

--nextPart3881024.RUnXabflUD--



