Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03B4CAC5BB
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 17:27:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 513848426A
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 19:27:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759080477;
 b=3RfMsvwQ1/hkk7dd0TYh7G4IfEwO/Mf4nuNnhWPeSCZ+1Pj6x9olqBPS0Xae1cR2hlxuD
 SsR7eZdgkZjKP0wXWDUc3PONinJirBLpUaD4CbvHlgBr9FXtH5Yp3KB0X7va71vbfZ75XCl
 4Fqu+oDdKl//IEJLoV3xCiLCwcASgKg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759080477; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yx1yPuHFgBpQck8rR9QoO2Gr8jEasMfY+RSwKrKmDSw=;
 b=EmOT717/jwdAukl21DhgjuSvSJMlJ465QDBCIjEA8NL8xLS9+4YmWBqZYjWxak1ujpfqp
 VYG5TnxDvDmK6W5lpwkP9VFPFrhlby0qFdxXM61lBrN5gY1QbSJxyxrXS5oZM7b0ApjFZJK
 d9FWNLMSngSe2TFnPV9fH8+O75jCTyk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7634780EB7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Sep 2025 19:18:24 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1759079914; a=rsa-sha256;
	cv=none;
	b=IZVdjXZ5/M2depsWKcr+/Ouf7eLVZ2HlgfI9guE4uXSP818n1lSMQ+1ybfEZycmrbVHfub
	5fmqH6szFOzxmd2XydthUB43fZ9gf432I1+Bn5Rfxh6pxNFLg1JGBkSLM6gkaORMktih9s
	Yp8iJPnT0nwLMupA7m1gm7gGsw1aNu8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=XUdIQ+bT;
	spf=pass (diktynna.open-mesh.org: domain of ebiggers@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=ebiggers@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1759079914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yx1yPuHFgBpQck8rR9QoO2Gr8jEasMfY+RSwKrKmDSw=;
	b=eFT8PGE/C+AVqvBtBRgLQ2QnIHn1LKFfXU1TXl9AWbU57OZzN5LB26KevNHvTD6zgjySa1
	+TjNXao8tlPhXmNQC1w8Z6l4jMJamTRJ0UqJQlk7gTgGCZcowM3/tWtk1gh9i2heNPVGK4
	Mtw/G9hcn4DwWhtIb1cPYGqUpkBFqUc=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 12C2943A34;
	Sun, 28 Sep 2025 17:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0912C4CEF0;
	Sun, 28 Sep 2025 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759079902;
	bh=x2yexiXIy45u2otga7DM9/2C/G9c+BzLFnUMgiFDWgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUdIQ+bTKFjbZ0ndk8QdFvHlmV0dDZkpCWLPHS+5L11iAohcBvkHfhTbai+eicon3
	 OaMI57rilM0czp+x3dM9Vn/TACAUvrHjmyiDtEcDhBQy10iQV/sDbZuFI6bG56XLCm
	 4L2YOgOVSl07P+U74FUx1RZNVH1NE0Tfp3BZhGrl34nax4Qls15rULw8pT9yj0SGEJ
	 WmnGohB/zEidAYYaCmRtlBP4cTsBorfa0p1WOcaKTGoDEK4ZUddM1aHInpM1PV6gAV
	 qRgUxlDkAJe0W1aFJNEX/kRAGoG5AsHeNK/NDDrGeX6yFJOeoH46bfUeVuLiKoc2yf
	 AOJYlTl/9hgqw==
Date: Sun, 28 Sep 2025 10:17:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next 3/4] batman-adv: keep skb crc32 helper local in
 BLA
Message-ID: <20250928171703.GA6416@sol>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
 <20250916122441.89246-4-sw@simonwunderlich.de>
 <20250927205552.GD9798@quark>
 <2878689.BEx9A2HvPv@sven-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2878689.BEx9A2HvPv@sven-desktop>
X-MailFrom: ebiggers@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: ETLXPJ4KD2YTM2DJQWRMHMR4KUJT4KAY
X-Message-ID-Hash: ETLXPJ4KD2YTM2DJQWRMHMR4KUJT4KAY
X-Mailman-Approved-At: Sun, 28 Sep 2025 19:27:31 +0200
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ETLXPJ4KD2YTM2DJQWRMHMR4KUJT4KAY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Sep 28, 2025 at 10:45:12AM +0200, Sven Eckelmann wrote:
> On Saturday, 27 September 2025 22:55:52 CEST Eric Biggers wrote:
> > Hi,
> > 
> > On Tue, Sep 16, 2025 at 02:24:40PM +0200, Simon Wunderlich wrote:
> > > +static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
> > > +{
> > > +	unsigned int to = skb->len;
> > > +	unsigned int consumed = 0;
> > > +	struct skb_seq_state st;
> > > +	unsigned int from;
> > > +	unsigned int len;
> > > +	const u8 *data;
> > > +	u32 crc = 0;
> > > +
> > > +	from = (unsigned int)(payload_ptr - skb->data);
> > > +
> > > +	skb_prepare_seq_read(skb, from, to, &st);
> > > +	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
> > > +		crc = crc32c(crc, data, len);
> > > +		consumed += len;
> > > +	}
> > > +
> > > +	return htonl(crc);
> > > +}
> > 
> > Has using skb_crc32c() been considered here?
> 
> No. At the time this was written (v3.8), skb_crc32c (v6.16) didnt exist. Also 
> its predecessor __skb_checksum only started its existence in v3.13. And no one 
> noticed it as candidate to replace batadv_skb_crc32 with
> 
> And this patch here was just moving the function between two places - so not 
> introducing new code.
> 
> Do you want to submit a patch to integrate your new function in batman-adv? I 
> only performed a quick-and-dirty test to see if it returns the same results 
> and it seemed to do its job fine.
> 
> diff --git c/net/batman-adv/Kconfig w/net/batman-adv/Kconfig
> index c299e2bc..58c408b7 100644
> --- c/net/batman-adv/Kconfig
> +++ w/net/batman-adv/Kconfig
> @@ -35,6 +35,7 @@ config BATMAN_ADV_BLA
>  	bool "Bridge Loop Avoidance"
>  	depends on BATMAN_ADV && INET
>  	select CRC16
> +	select NET_CRC32C
>  	default y
>  	help
>  	  This option enables BLA (Bridge Loop Avoidance), a mechanism
> diff --git c/net/batman-adv/bridge_loop_avoidance.c w/net/batman-adv/bridge_loop_avoidance.c
> index b992ba12..eef40b6f 100644
> --- c/net/batman-adv/bridge_loop_avoidance.c
> +++ w/net/batman-adv/bridge_loop_avoidance.c
> @@ -12,7 +12,6 @@
>  #include <linux/compiler.h>
>  #include <linux/container_of.h>
>  #include <linux/crc16.h>
> -#include <linux/crc32.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/etherdevice.h>
> @@ -1585,45 +1584,11 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
>  	return 0;
>  }
>  
> -/**
> - * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
> - *  the header
> - * @skb: skb pointing to fragmented socket buffers
> - * @payload_ptr: Pointer to position inside the head buffer of the skb
> - *  marking the start of the data to be CRC'ed
> - *
> - * payload_ptr must always point to an address in the skb head buffer and not to
> - * a fragment.
> - *
> - * Return: big endian crc32c of the checksummed data
> - */
> -static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
> -{
> -	unsigned int to = skb->len;
> -	unsigned int consumed = 0;
> -	struct skb_seq_state st;
> -	unsigned int from;
> -	unsigned int len;
> -	const u8 *data;
> -	u32 crc = 0;
> -
> -	from = (unsigned int)(payload_ptr - skb->data);
> -
> -	skb_prepare_seq_read(skb, from, to, &st);
> -	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
> -		crc = crc32c(crc, data, len);
> -		consumed += len;
> -	}
> -
> -	return htonl(crc);
> -}
> -
>  /**
>   * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
>   * @bat_priv: the bat priv with all the mesh interface information
>   * @skb: contains the multicast packet to be checked
> - * @payload_ptr: pointer to position inside the head buffer of the skb
> - *  marking the start of the data to be CRC'ed
> + * @payload_offset: offset in the skb, marking the start of the data to be CRC'ed
>   * @orig: originator mac address, NULL if unknown
>   *
>   * Check if it is on our broadcast list. Another gateway might have sent the
> @@ -1638,16 +1603,18 @@ static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
>   * Return: true if a packet is in the duplicate list, false otherwise.
>   */
>  static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
> -				     struct sk_buff *skb, u8 *payload_ptr,
> +				     struct sk_buff *skb, int payload_offset,
>  				     const u8 *orig)
>  {
>  	struct batadv_bcast_duplist_entry *entry;
>  	bool ret = false;
> +	int payload_len;
>  	int i, curr;
>  	__be32 crc;
>  
>  	/* calculate the crc ... */
> -	crc = batadv_skb_crc32(skb, payload_ptr);
> +	payload_len = skb->len - payload_offset;
> +	crc = htonl(skb_crc32c(skb, payload_offset, payload_len, 0));
>  
>  	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
>  
> @@ -1727,7 +1694,7 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
>  static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
>  					   struct sk_buff *skb)
>  {
> -	return batadv_bla_check_duplist(bat_priv, skb, (u8 *)skb->data, NULL);
> +	return batadv_bla_check_duplist(bat_priv, skb, 0, NULL);
>  }
>  
>  /**
> @@ -1745,12 +1712,10 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
>  				    struct sk_buff *skb)
>  {
>  	struct batadv_bcast_packet *bcast_packet;
> -	u8 *payload_ptr;
>  
>  	bcast_packet = (struct batadv_bcast_packet *)skb->data;
> -	payload_ptr = (u8 *)(bcast_packet + 1);
>  
> -	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
> +	return batadv_bla_check_duplist(bat_priv, skb, sizeof(*bcast_packet),
>  					bcast_packet->orig);
>  }

It looks like you're already most of the way there, so I suggest you
send the patch.  Thanks!

- Eric
