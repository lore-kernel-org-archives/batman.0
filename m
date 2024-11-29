Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360C8D729F3
	for <batman@archiver.kernel.org>; Fri, 29 Nov 2024 17:57:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A81183F1D
	for <batman@archiver.kernel.org>; Fri, 29 Nov 2024 18:57:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732903057;
 b=uwHWo8eBJjIz8XN/E58UwVISRltwFR3txMSXPQLmX3UanAlIXlBIq6TX2rMAgVb+yFl7k
 i5f4nkf5DhhJ1499g2auk6pTn0EXGOOOxM/7SWriujA2V/r9EZOwoGa8KqCrp6mXwOc29w4
 j6VVfutjeM/AWdXYn2wENO3lFX0EpXM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732903057; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hs2ezfK/XgaqGoCDH48V/aqaxHrbl3HitmxGe9sH+dk=;
 b=llCMIXJhRki77GZl/DYeVM0AzRkaKhVr5tbJ7OXsvGz3ppM7U/LRFmvk6wwyY7Udi1va4
 I9JJxywRVYzwbdCnhOScVEPxa8TMyJYDSmmjQ+hBeOAunbNgU3dwQB+0+esmWIV/VUOGjFA
 sA63ctYurr+5Z+3CtWhfb4fd/ORex1I=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C6DBC80855
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Nov 2024 18:57:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732903037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hs2ezfK/XgaqGoCDH48V/aqaxHrbl3HitmxGe9sH+dk=;
	b=XJRqf4Z26YuuCk4jAACZ6Zv5RVHbeR/9nUsf9d9O7mSJxhCrA1wH9RrGYHBvvww8q4jlgY
	bOe9LSudswEeH2yEkw8FntZ/44grmJ68WeGDSFl+wsJ2oZyoSqRa3i149OmNsRITLp7EI8
	TFBLKA3i3xQ3ZoS3dzJa3eUbt2XoeAU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732903037; a=rsa-sha256;
	cv=none;
	b=JZXSSIxGG65xL0vNn0D9im2BmtlJ4rGL041fJQE3seK6/Bx5mNP/U9Irq+lIHO90C5Hue8
	XvEK0lt9fvzCdAfc72hEUS0OZUWGmwxE83RhZVLhZG46RsU5/gEmtBiHQkLymrGqXQb64c
	1QrRFTpof5l1N//mU2zdtu8vposbjps=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A8A6F541152;
	Fri, 29 Nov 2024 18:57:16 +0100 (CET)
Date: Fri, 29 Nov 2024 18:57:15 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v5 1/2] batman-adv: split DAT cache into DAT cache and
 DAT DHT
Message-ID: <Z0oAeys-9NFCDzhP@sellars>
References: <20240911051259.23384-1-linus.luessing@c0d3.blue>
 <20240911051259.23384-2-linus.luessing@c0d3.blue>
 <878c7f2c-ea78-4f40-b20e-9698c77f887d@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878c7f2c-ea78-4f40-b20e-9698c77f887d@unstable.cc>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: A4ITN34MT7KJKTJ3L3XEFD7LEZEKGVU4
X-Message-ID-Hash: A4ITN34MT7KJKTJ3L3XEFD7LEZEKGVU4
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/A4ITN34MT7KJKTJ3L3XEFD7LEZEKGVU4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Sorry, had overlooked the inline comments in the code. Replies
follow below.


On Mon, Oct 28, 2024 at 02:25:36PM +0100, Antonio Quartulli wrote:
> [...]
> > +/**
> > + * batadv_dat_get_softif() - get the soft interface from a netlink callback
> > + * @cb: callback structure containing arguments
> > + *
> > + * Return: The soft interface on success or an error pointer otherwise.
> > + */
> > +static struct net_device *batadv_dat_get_softif(struct netlink_callback *cb)
> > +{
> > +	struct net *net = sock_net(cb->skb->sk);
> > +	struct net_device *soft_iface;
> > +	int ifindex;
> > +
> > +	ifindex = batadv_netlink_get_ifindex(cb->nlh,
> > +					     BATADV_ATTR_MESH_IFINDEX);
> > +	if (!ifindex)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	soft_iface = dev_get_by_index(net, ifindex);
> > +	if (!soft_iface)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	if (!batadv_softif_is_valid(soft_iface)) {
> > +		dev_put(soft_iface);
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	return soft_iface;
> > +}
> 
> I don't think this function is DAT specific at all.
> Moreover, the very same code (which I think you are re-using here) appears
> in batadv_netlink_dump_hardif().
> 
> I think it'd make more sense to factor it out and create a helper out of it
> (place it in netlink.c?). This way we avoid code duplication.
> 
> [I might be wrong but 90% of the work already is in
> batadv_get_softif_from_info()]

Good idea, will do in v7! There are actually many more places that
have basically the same code... :D.


> I can see that most of the code in this patch is about handling two tables
> (in a generic fashion) instead of one.
> 
> One functional change I am seeing is also that before this patch batman-adv
> would store/cache any ARP information coming from the mesh.
> While now this happens only for the DHT PUT. Am I right?

Partially. For the DAT Cache part, it should be the same. In the
batadv_dat_snoop_incoming_* functions we still add to the DAT
cache table like we did before, unless I'm missing something.


For the new DAT DHT part, correct, there are the following cases
where we don't update this anymore (immediately):

* incoming ARP request: we don't add/update the ARP source to DAT DHT
* incoming ARP reply: we only add/update the ARP source+destination
  to DAT DHT if it was via a DHT PUT
* incoming DHCP ACK: we don't add/update to DAT DHT

However these packets must have come from somewhere. So their
originator should have sent a DHT PUT, too? If they arrive a bit
later, shouldn't be an issue as these packets at least updated the
DHT Cache.

If the according DHT PUT got lost on the way and we didn't have
these entries in our DHT yet, shouldn't be an issue as we have two
more DAT DHT candidates.

The only case where I could see it making a (small?) difference in practice
is if a DHT PUT got lost and it would have changed the MAC address
for the DAT DHT entry. But I'm not sure if that would justify
extra lines of code right now? (For that use-case we should
probably also have a majority vote of DAT_CACHE_REPLY from DAT
candidates, instead of updating our DAT cache with the first reply we get
- but we didn't do that so far either, for simplicity's sake.)

> 
> If that's the case, it means we may issue more DHT_GETs (and possibly ARP
> requests) because we lost a chance to cache a bit more that what the DHT
> stores. Does it make sense?

I don't think we would issue more DHT_GETs, as we at least update
the DAT cache table like we did before. And only if we don't have
an entry in the DAT Cache then we would trigger DHT_GETs?

Hope that makes sense?

Regards, Linus
