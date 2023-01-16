Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3B0C46467
	for <batman@archiver.kernel.org>; Mon, 16 Jan 2023 18:31:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C33CD83DA3
	for <batman@archiver.kernel.org>; Mon, 16 Jan 2023 19:31:40 +0100 (CET)
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3595F803A5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Jan 2023 19:31:17 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1673893877; a=rsa-sha256;
	cv=none;
	b=TC/hr+vIxlZQi84b6mS8gYjH1ULeHAJX9M/Y82F7AaxTEvWOJsuLCZZuEAMJY+oh37WHbw
	6i00EM5bJwPNlHANhR4VcQd+R/uQ6AohfaBj1sv9zGIsIJlAnlAyClnq6+DdZAkTQkfkej
	FbOKPpxyjID/wkI5bUt8vRutfmyblSA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no SPF policy when checking 116.203.183.178) smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1673893877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSLbGrdbi3zOQvozut8sXHxzVAN1kcs3dMNIVR/SL7A=;
	b=WZR64A1ROncHT2PAULiST7XQASLA5TD1sr50uaVOnpEx0g7LYwYROOmQcQacj1IHfwudop
	75aveQZwxoXbfMWlBLCg9cIHJG5os+CtJ0blOEnJnQQ8Ncrh+6u/bUdd2u6vAUxtEdLPC9
	R3Nl6nlYEPi6oBZfBQn4R8GXU8S3T6s=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A6294129D;
	Mon, 16 Jan 2023 19:31:15 +0100 (CET)
Date: Mon, 16 Jan 2023 19:31:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v4 3/5] batman-adv: mcast: implement multicast packet
 reception and forwarding
Message-ID: <Y8WX8a0REDduYlKW@sellars>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue>
 <20221227193409.13461-4-linus.luessing@c0d3.blue>
 <7420352.31tnzDBltd@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7420352.31tnzDBltd@sven-l14>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 3BAOSL53AC7LFK46OVIYKBA4NH73SDGV
X-Message-ID-Hash: 3BAOSL53AC7LFK46OVIYKBA4NH73SDGV
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3BAOSL53AC7LFK46OVIYKBA4NH73SDGV/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Jan 15, 2023 at 06:56:37PM +0100, Sven Eckelmann wrote:
> [...]
> > +static void
> > +batadv_mcast_forw_scrub_dests(struct batadv_priv *bat_priv,
> > +			      struct batadv_neigh_node *comp_neigh, u8 *dest,
> > +			      u8 *next_dest, u16 num_dests)
> > +{
> > +	struct batadv_neigh_node *next_neigh;
> > +
> > +	/* skip first entry, this is what we are comparing with */
> > +	eth_zero_addr(dest);
> > +	dest += ETH_ALEN;
> > +	next_dest += ETH_ALEN;
> > +	num_dests--;
> > +
> > +	batadv_mcast_forw_tracker_for_each_dest(next_dest, num_dests) {
> > +		if (is_zero_ether_addr(next_dest))
> > +			goto scrub_next;
> > +
> > +		if (is_multicast_ether_addr(next_dest)) {
> > +			eth_zero_addr(dest);
> > +			eth_zero_addr(next_dest);
> > +			goto scrub_next;
> > +		}
> > +
> > +		next_neigh = batadv_mcast_forw_orig_to_neigh(bat_priv,
> > +							     next_dest);
> > +		if (!next_neigh) {
> > +			eth_zero_addr(next_dest);
> 
> Why is the original skb not touched in this case?
> 
> It might not be a problem because you are also doing the 
> batadv_mcast_forw_orig_to_neigh check in batadv_mcast_forw_packet. But I was 
> just wondering about it

I actually thought the same at some point, to potentially reduce the
number of neighbor node lookups, and tried it. And then
realized that it can break local reception. The destination
address might be our own one and then the neighbor node lookup
will return NULL, too.

So instead of adding another batadv_is_my_mac() check in yet
another place and branching here in scrub_dests(), I thought I'd keep
it simple.

I could also add these two lines in scrub_dests(), the check and zeroing,
I'm just not quite sure if we would overall gain something with it, as
batadv_is_my_mac() can be a bit expensive at the moment when there are
many interfaces?

> 
> 
> Btw. it could happen that you send out a packet with zero destinations in the 
> TVLV because the neighbor disappeared between the 
> batadv_mcast_forw_orig_to_neigh in batadv_mcast_forw_packet and in 
> batadv_mcast_forw_scrub_dests

Ah good point. Hm, the protocol should be robust enough on
the receiver side to handle it. And it should overall happen very rarely.
I'm indifferent to adding two more lines of code to check that.

> 
> Kind regards,
> 	Sven

