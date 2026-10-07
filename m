Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C534CA5FED
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 01:08:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7987684138
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 03:08:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791335306;
 b=TXhRHdkXgthiqOmHnFIZM65RaUBtzv1pYxqdj3UfCHzG2z30E4G1yNYokyELqfatwFWq0
 F4UO07dusj05wN2oifmHmWZUaH9hFqajjm9pZrYr/39M4YD5AnUi5cRqdYl1ArZwXSzBNY/
 lx1sd0FOMARw0raD4jeFe00x6KQPpzo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791335306; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nezMUrqU44GmwLkwicYkQA/j2YxlOJnI+fI+zUzzkjk=;
 b=b4iMhAJF+2hWXidR7cQaMXcMoZaHy9woEvWNx/rIOuYHQIo5QeNEexMBY1sCYzcRe95HH
 CW8+iC2FmfyUJhGHKncHB673Rp4fxQjITcaCsPKz2XQB9lUcjixcEAx8imY2K18DKBeyUyt
 3IPLWmgi3JpK9dMW0on/MDaOyOZRUs4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8B34F83413
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 03:08:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791335297;
	b=eelHbiM8YXCMPF9Nq5vrbsqt0kWCwFGxB0fktcnqZtbtBXXMXJhOC2usR4/hxt5x6ZBad4
	mhuowkSQ9yv3/S7vgtemXorSCZ58vROmE/ArbBT2vKgaOjt3cORbcH24LrBdx1th8eOIDm
	pWUydG75LaVnwUW6bgOxlXTCOVGEOwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791335297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to; bh=nezMUrqU44GmwLkwicYkQA/j2YxlOJnI+fI+zUzzkjk=;
	b=Hwj8tcXpNxXMas8eKNB84ZUxUvQwwfBWtSXc5sXvcEFIs30GhEkNzzgJGecHpO5ja2pyH6
	5dWQC/vXU1UXGrHtGGopwEnE8/fdvAmE0XWFFSfJlNV95m0yv6zlSIi5nKZ9OQw2nBvoU5
	2sJiFvB3Heg6IOglD1pDhT1hM6C3Sjs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C2FC920649;
	Wed, 07 Oct 2026 03:08:04 +0200 (CEST)
Date: Wed, 7 Oct 2026 03:08:03 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org, sashiko-reviews@lists.linux.dev
Cc: sven@narfation.org, marek.lindner@mailbox.org, sw@simonwunderlich.de,
	antonio@mandelbit.com
Subject: Re: [batadv,v14 5/5] batman-adv: avoid superfluous DAT DHT_PUT
 additions to local DAT
Message-ID: <asWbc64vRQgTKt9E@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006185037.27163-6-linus.luessing@c0d3.blue>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: K5IYMROSVDW5SDYPB3GUIMNRIAZX4JRH
X-Message-ID-Hash: K5IYMROSVDW5SDYPB3GUIMNRIAZX4JRH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/K5IYMROSVDW5SDYPB3GUIMNRIAZX4JRH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Oct 06, 2026 at 07:02:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] batadv: CPU exhaustion DoS via O(N) candidate selection in softirq

I think we have this situation already for ARP Replies, even without
this patchset (though limited to the local node)? And avoiding that
seems like it would need quite some rework.

Besides, at least in Gluon we have ARP ratelimiting via
ebtables anyway, as we've had some devices, probably some funny
mobile apps, scanning the full /20 IP range, leading to a lot of
ARP traffic:
https://github.com/freifunk-gluon/gluon/tree/main/package/gluon-ebtables-limit-arp
So we wouldn't be (that) affected and I think any larger and especially
publically accessible batman-adv network should configure such
rate-limiting via netfilter anyway.


> - [Medium] batadv: UAPI source compatibility breakage via reserved field rename

I would have thought that for a field called "reserved" it would
be clear that it'd be subject to change in the future.

Or should I introduce a "struct batadv_unicast_4addr_v2_packet"?


> --
> 
> commit ad436b7e22433bb29047a461fbcafbd08d11c4a3
> Author: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> batman-adv: avoid superfluous DAT DHT_PUT additions to local DAT
> 
> This commit adds a flag to DHT_PUT messages to indicate which pair is
> supposed to be added to the local DHT. This avoids populating the local
> DHT with unnecessary entries that will likely never be queried.
> 
> > diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> > index 32436560ecc8b..2a7928fa5195a 100644
> > --- a/include/uapi/linux/batadv_packet.h
> > +++ b/include/uapi/linux/batadv_packet.h
> 
> [ ... ]
> 
> > @@ -445,13 +445,13 @@ struct batadv_unicast_packet {
> >   * @u: common unicast packet header
> >   * @src: address of the source
> >   * @subtype: packet subtype
> > - * @reserved: reserved byte for alignment
> > + * @flags: packet subtype specific flags
> >   */
> >  struct batadv_unicast_4addr_packet {
> >  	struct batadv_unicast_packet u;
> >  	__u8 src[ETH_ALEN];
> >  	__u8 subtype;
> > -	__u8 reserved;
> > +	__u8 flags;
> 
> [Severity: Medium]
> Does renaming the reserved field to flags in the UAPI structure
> batadv_unicast_4addr_packet break source compatibility? Any user-space
> applications referencing the old reserved field name might fail to compile
> after this change.
> 
> >  	/* "4 bytes boundary + 2 bytes" long to make the payload after the
> >  	 * following ethernet header again 4 bytes boundary aligned
> >  	 */
> > diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
> > index 0acb129cf4c5f..3c96c42153685 100644
> > --- a/net/batman-adv/distributed-arp-table.c
> > +++ b/net/batman-adv/distributed-arp-table.c
> 
> [ ... ]
> 
> > @@ -562,6 +565,20 @@ static inline void
> >  batadv_dat_dht_entry_add(struct batadv_priv *bat_priv, __be32 ip,
> >  			 u8 *mac_addr, unsigned short vid)
> >  {
> > +	/* Happens if a new node just beat us as a candidate, an old node
> > +	 * does not have the more specific candidate selection enhancements yet
> > +	 * or if future protocol enhancements, which this node does not have
> > +	 * yet, added new/other candidate selections. For compatibility reasons
> > +	 * do not bail out here.
> > +	 */
> > +	if (!batadv_dat_dht_check_self_is_candidate(bat_priv, ip, vid)) {
> 
> [Severity: High]
> Does calling batadv_dat_dht_check_self_is_candidate() unconditionally in
> batadv_dat_dht_entry_add() during the receive path introduce a denial of
> service vector?
> 
> Looking at batadv_dat_dht_check_self_is_candidate(), it calls
> batadv_dat_select_candidates() which performs a GFP_ATOMIC allocation and
> iterates over the originator hash. Since batadv_dat_dht_entry_add() can be
> triggered from softirq context when processing incoming packets, could an
> attacker send a flood of DHT_PUT messages to exhaust CPU resources and memory?
> 
> > +		batadv_inc_counter(bat_priv,
> > +				   BATADV_CNT_DAT_DHT_ADD_NOT_CANDIDATE);
> > +		batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > +			   "Adding %pI4 %pM (vid: %d), although we are not a candidate\n",
> > +			   &ip, mac_addr, batadv_print_vid(vid));
> > +	}
> > +
> >  	batadv_dat_entry_add(bat_priv, bat_priv->dat.dht_hash, ip, mac_addr,
> >  			     vid, "dht");
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006185037.27163-1-linus.luessing@c0d3.blue?part=5
