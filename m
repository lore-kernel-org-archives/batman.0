Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB30C982EE
	for <batman-adv@archiver.kernel.org>; Mon, 21 Sep 2026 01:07:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0EC8583F7E
	for <batman-adv@archiver.kernel.org>; Mon, 21 Sep 2026 03:07:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789952847;
 b=QyW8OqcJmoB2HF2uzlbI84fRnsyujo8Wl3oIk56WL96AXpUgoY5ICQGfZUrOy9woF/epU
 SdAAJ728j0RGaqjCr5wwwWIhR6yOQWylQfBSyeqhZeo7p1ilfTl6VuyHoV+JZIqNFDjDZRR
 6sPkJoNptKtWh9KpUU4sZGH2kFRdi+0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789952847; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=M6WTNz+xVNiBgnOc5h80UuTWSKWWx5CpqYLO5V1gDng=;
 b=JkSS9EmnWnNSa8El/eXrUOyHWpLEamd2ryBfoSfIUBkgrQsKEQ1yF/MctZWq0IjwZ3XUT
 N96xzQftg1KIssDQkMnrHYkso2774EpUhxUVgztzozXSnSCF5KRHNQ3fzRLxsLfNIyUQSTV
 eYAx1W44AcljQVkX5KU2aFaoOCl0cLI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D15A481912
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 21 Sep 2026 03:07:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789952842;
	b=DSW6IeJSafX2Fg0CrTI3EolUE71M++b+LppKIy0XTY6+IaNQp5X2Iuo438IdBYdr/OiC7i
	JKRczw0DmJfyghWTGPHxKi3eYDYNm1UEram6mggl1X9eEBDeReQDZcsReqNYb/ouGAu5kF
	qLYQ0ZAmAGMwE4i76Ah3yWIDSOOEDCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789952842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to; bh=hkU5fRgGesRuFMjoq6USJ/c5w5dmMDltbUpwfjTKgwo=;
	b=FsZn4WbID3eNkYbA7IO7adSXvYgFwJLRIYKP0lmKoBA/4jrCyQK+INez/B2ls0rq23cfZr
	SpxPc4HPLvaPgbXVzpPta1fiTPseYh3CNqgkawJKrUxzj14h5oFaCRPe43ah0R9Vi/iwn+
	YA24iAX3FjLXnoEDKzRkWFRLDXbdmEI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 34A8B1F79C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 21 Sep 2026 03:07:19 +0200 (CEST)
Date: Mon, 21 Sep 2026 03:07:18 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [batadv,v10 1/2] batman-adv: split DAT cache into DAT cache and
 DAT DHT
Message-ID: <arCDRj9ubBwDJ3EK@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918225549.31315-2-linus.luessing@c0d3.blue>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 3GITUZMXKXVKERUIS6ERP5GEE7QE2TUO
X-Message-ID-Hash: 3GITUZMXKXVKERUIS6ERP5GEE7QE2TUO
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3GITUZMXKXVKERUIS6ERP5GEE7QE2TUO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

tl;dr: One of the four suggestions makes sense to me. For 1(.5)
other points don't make sense to me / are overlooking an aspect, imo.
For the remaining points I don't think they are a big issue, or at least
for now not worth the extra complexity / refactoring work needed?


On Fri, Sep 18, 2026 at 11:11:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] batadv: incomplete DAT hash split breaks DHCP snooping and broadcasts
> --
> 
> commit 40cf52e0667d2a02a686b866fe2dc385205cdc83
> Author: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> batman-adv: split DAT cache into DAT cache and DAT DHT
> 
> This commit separates the locally maintained DAT cache and the DAT DHT into
> two distinct hash tables. This split is intended to ease monitoring and
> allow differing properties for cache vs DHT entries.
> 
> > diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
> > index a4be5b2a87d7a..d2a599c9651d7 100644
> > --- a/net/batman-adv/distributed-arp-table.c
> > +++ b/net/batman-adv/distributed-arp-table.c
> 
> [ ... ]
> 
> > @@ -1421,9 +1421,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
> >  	hw_src = batadv_arp_hw_src(skb, hdr_size);
> >  	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
> >  
> > -	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
> > +	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
> >  
> > -	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
> > +	dat_entry = batadv_dat_cache_entry_find(bat_priv, ip_dst, vid);
> >  	if (dat_entry) {
> >  		u64_mac = atomic64_read(&dat_entry->mac_addr);
> 
> [Severity: High]
> Does this fail to reply locally if the node has the requested entry in the
> DAT DHT but not the DAT cache?
> 
> If the node is the DHT candidate, checking only the cache hash could bypass
> local DHT knowledge and trigger unnecessary remote DHT_GET requests.

I don't think these DHT_GET requests are unnecessary. The local DAT DHT
information might (sometimes) be outdated if due to new or vanishing nodes
we are not one of the three DAT DHT candidates anymore. We should
check on the current DHT candidates instead then in my opinion.

Also a DHT_GET is not that costly (at least compared to a
broadcast flooded ARP request, for instance).

(And thirdly, I'm also wondering if in the future in larger and/or more
dynamic or lossy networks it might make sense to check all
BATADV_P_DAT_CACHE_REPLY answers and choose the MAC address with the
most votes. In case one of the candidates might have an
outdated DHT entry somehow. Or if a candidate were generating
corrupted/bogus replies. We've seen broken, bit-flipping devices
in our networks before.)

> 
> [ ... ]
> 
> > @@ -1525,9 +1525,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
> >  
> >  	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REQUEST");
> >  
> > -	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
> > +	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
> >  
> > -	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
> > +	dat_entry = batadv_dat_dht_entry_find(bat_priv, ip_dst, vid);
> >  	if (!dat_entry)
> >  		goto out;
> 
> [Severity: High]
> Will this miss DHT entries that were improperly stored in the cache hash
> instead of the DHT hash? 
> 
> If a node's local client sends an ARP reply or if a DHCP DHT_PUT is saved
> in the cache hash, a remote DHT_GET will fail here because
> batadv_dat_snoop_incoming_arp_request only searches the DHT hash.

The short answer would be: In theory valid but not sure if it's an
issue in practice.

If our own, local node is one of the candidates then other nodes might
loose one of the three potential candidates. But for one thing there
are two other candidates and for another depending on the network size
could be rare. In small networks would happen more often, but in
smaller networks with therefore shorter paths just two candidates
should generally be fine, too.


If one were trying to not loose a candidate (but I'm not sure if
that is worth it for now? Or if that should be extra patches
later?):


Option A)

>From batadv_dat_snoop_outgoing_arp_reply() /
batadv_dat_snoop_outgoing_dhcp_ack() always add to local DHT,
regardless if we are an actual DHT candidate.

Downside: From "batctl dd" we wouldn't know anymore if the entry
came from a local addition or via a DHT PUT. (one could maybe add
a flag to a DHT entry though for the batctl visualization...)

Option B)

Make batadv_choose_next_candidate() consider our own, local orig
address, too. Add a BATADV_DAT_CANDIDATE_SELF type.
Make batadv_dat_forward_data() add to the local DHT (without
sending a DHT PUT message to ourself?) if this local orig is a
candidate.

Downside: More rework and extra checks.

Upside: Currently, also before these patches, if the local node is
a candidate then we might do a superfluous DHT_PUSH to a node which
is not actually a candidate from the perspective of other nodes.
Consdering the own node for the DHT ring, too, would solve that as
well.

> 
> [ ... ]
> 
> > @@ -2077,8 +2077,8 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
> >  	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
> >  	hw_src = ethhdr->h_source;
> >  
> > -	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
> > -	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
> > +	batadv_dat_cache_entry_add(bat_priv, yiaddr, chaddr, vid);
> > +	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
> >  
> >  	batadv_dbg(BATADV_DBG_DAT, bat_priv,
> 
> [Severity: High]
> When a DHT candidate receives a DHT_PUT containing a DHCP packet, should
> these entries be saved in the DHT hash instead of the cache hash? 
> 
> Saving them to the cache hash unconditionally makes them invisible to
> subsequent DHT_GET queries that only check the DHT hash.

Makes sense, indeed a batadv_dat_snoop_incoming_dhcp_ack() should
behave similar to a batadv_dat_snoop_incoming_arp_reply() which it
currently does not. So if the incoming DHCP ACK came via a
DHT_PUT then I'd change this patch to add to the local DHT, too,
in a v11.

> 
> [ ... ]
> 
> > @@ -2132,7 +2132,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
> >  		goto out;
> >  
> >  	ip_dst = batadv_arp_ip_dst(forw_packet->skb, hdr_size);
> > -	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
> > +	dat_entry = batadv_dat_cache_entry_find(bat_priv, ip_dst, vid);
> >  	/* check if the node already got this entry */
> >  	if (!dat_entry) {
> 
> [Severity: High]
> Does this fail to drop the broadcast packet if the node knows the answer
> via the DHT hash rather than the cache hash? 
> 
> By only checking the cache, known DHT entries fail to suppress ARP
> broadcasts, which can lead to unnecessary broadcast storms.

Similar to the first reply: The local DHT entry might be outdated.
A broadcast in that case would seem safer to me.

(Alternatively, with the "Option B)" mentioned above one could
potentially also avoid the broadcast. But still a bit tricky,
as we don't have an orig-node for ourself and therefore can't
simply send a DHT_GET to ourself / can't treat ourself as any
other DAT candidate?)


> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260918225549.31315-1-linus.luessing@c0d3.blue?part=1
