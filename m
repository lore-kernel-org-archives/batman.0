Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0CAD75E5D
	for <batman-adv@archiver.kernel.org>; Sat, 23 Nov 2024 18:36:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D8E9183CA9
	for <batman-adv@archiver.kernel.org>; Sat, 23 Nov 2024 19:36:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732387007;
 b=rgugAvWWELFCbMQYbsLEu2dy2uXK0xirnB9ngwBqxlQ1MGAMM1mIUJXMlaBzTjvlGu3IS
 HWw6+u86SYBTfyUFbx7806mgeFEycd1CSkV7pyjG+Y0C7BDhYUEoOfWKHEbKLldJx9c0/VM
 6U7sLG4+2/KP14D9TXSPnH7xNyciOJY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732387007; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=noteSHP2dFO5iA/47VR/fxo6APjL/tLYqvodr0CQfxw=;
 b=VczDx7SEd/oFokVNQJX62xz56S3b65RBENHg43zL8Hf0HRb3Qs8jqm23bDFjwNhK3/JAf
 uSEXqh13jmd+FkczyCOQTDwz6rRt/XVISj1YD3TM5Jv1hC8zDN6WNociC78VgWronTzoiAM
 SLba6PfAv3NwDui3gysJWxn66KuJFmI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1EA22817AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 23 Nov 2024 19:36:35 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732386996; a=rsa-sha256;
	cv=none;
	b=DGr0cSCFhlNrnH+sFXqbi7uoewf6hOLtzdQI0or/4i6W6+Bzu8PaVVO+hRlafBoHDNNC7Z
	oC+Ee1iz1AmKQt0iOXxjvYkj8fESzIIi7x9RjMiv58H8THy+V/wX2wd7p6GkVe820VSLtl
	+eNJ3rR+3m3lZG0ILC/31YErDMBH8YU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=udjK6Xf9;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732386996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=noteSHP2dFO5iA/47VR/fxo6APjL/tLYqvodr0CQfxw=;
	b=1DlsAXn1YWDsvUgZCBoxuEHP+lr0e54OCg8/zn9amYumPIeobZxKRWRjz1bOSjbbINrewU
	ljkjADqyP7DWnyarPqGMi8l1CX3L628qOPGX9ipv6o+nwFN3N3DPIPkRB9j7D4ZD5lfsOn
	LlgOFAiortwUaItcyzk2M3OIy+1FuKw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732386995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noteSHP2dFO5iA/47VR/fxo6APjL/tLYqvodr0CQfxw=;
	b=udjK6Xf9+ewLR4a7wEQD7Wq7EUGfAEF/4GPzi0RgLbHBl02iriqVOligyX9vvoJ4NHd9UX
	uWKJKGjRZbJTkdQJIYO3CHlN6763o+bj1qf/guLa7rmNjSnhxrFoia/IGdvZ+wNkXuxK3u
	gB02i/enZm0LaT9WVV1vhSpnz2x4Nm8=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
 Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v5 1/2] batman-adv: split DAT cache into DAT cache and DAT DHT
Date: Sat, 23 Nov 2024 19:36:32 +0100
Message-ID: <2320571.iZASKD2KPV@sven-l14>
In-Reply-To: <878c7f2c-ea78-4f40-b20e-9698c77f887d@unstable.cc>
References: 
 <20240911051259.23384-1-linus.luessing@c0d3.blue>
 <20240911051259.23384-2-linus.luessing@c0d3.blue>
 <878c7f2c-ea78-4f40-b20e-9698c77f887d@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2017237.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 3GH2BSXRAIAIXPPADA57V6IBT7BR5BVP
X-Message-ID-Hash: 3GH2BSXRAIAIXPPADA57V6IBT7BR5BVP
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3GH2BSXRAIAIXPPADA57V6IBT7BR5BVP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2017237.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 23 Nov 2024 19:36:32 +0100
Message-ID: <2320571.iZASKD2KPV@sven-l14>
In-Reply-To: <878c7f2c-ea78-4f40-b20e-9698c77f887d@unstable.cc>
MIME-Version: 1.0

On Monday, 28 October 2024 14:25:36 CET Antonio Quartulli wrote:
[...]
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
> Moreover, the very same code (which I think you are re-using here) 
> appears in batadv_netlink_dump_hardif().
> 
> I think it'd make more sense to factor it out and create a helper out of 
> it (place it in netlink.c?). This way we avoid code duplication.
> 
> [I might be wrong but 90% of the work already is in 
> batadv_get_softif_from_info()]


Looks like this was never answered and also not handled in the v6 version of the patch.

[...]
> > --- a/net/batman-adv/types.h
> > +++ b/net/batman-adv/types.h
> > @@ -1231,8 +1231,11 @@ struct batadv_priv_dat {
> >   	/** @addr: node DAT address */
> >   	batadv_dat_addr_t addr;
> >   
> > -	/** @hash: hashtable representing the local ARP cache */
> > -	struct batadv_hashtable *hash;
> > +	/** @cache_hash: hashtable representing the local ARP cache */
> > +	struct batadv_hashtable *cache_hash;
> > +
> > +	/** @dht_hash: hashtable representing the local DAT DHT */
> > +	struct batadv_hashtable *dht_hash;
> >   
> >   	/** @work: work queue callback item for cache purging */
> >   	struct delayed_work work;
> 
> I can see that most of the code in this patch is about handling two 
> tables (in a generic fashion) instead of one.
> 
> One functional change I am seeing is also that before this patch 
> batman-adv would store/cache any ARP information coming from the mesh.
> While now this happens only for the DHT PUT. Am I right?
> 
> If that's the case, it means we may issue more DHT_GETs (and possibly 
> ARP requests) because we lost a chance to cache a bit more that what the 
> DHT stores. Does it make sense?


Looks like this was never answered.


Kind regards,
	Sven
--nextPart2017237.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ0IgsAAKCRBND3cr0xT1
y7kGAP4hWF2fuKO/ktwC0053Yr/Htjea45Az7AEws5u6ZGLbigD8DBoL25cv8JXv
U8IZvRNLmAJAxOvFFenCpWKULIzbOAA=
=BZsa
-----END PGP SIGNATURE-----

--nextPart2017237.PYKUYFuaPT--



