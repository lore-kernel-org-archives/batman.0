Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031BFC7EE2E
	for <batman@archiver.kernel.org>; Sat, 10 Jun 2023 10:09:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CC0E281863
	for <batman@archiver.kernel.org>; Sat, 10 Jun 2023 12:09:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686391790;
 b=Erl2Xl56ETpy0EfTa3O71qGgkRuoi9LwKlfS63RBwflZGfnHDfX4Js8Os/4iwkVHYg3zx
 /MN67nHLOd/aGnAGFICE+QVKd7wXw40YJHZaOdjSv/bDYX0jYkzSFRHt5zviZI7Oly9vWNe
 89LO13/rpTwtIYir/fgv3Y0d0oju9o4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686391790; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=l99H/Kb5c4Petfujj7yVvPkPuoaJBOWiwge7voY9vSM=;
 b=JmvOOrvFiYTZ8Rq2k9D/9V+XZG29ecLEwp+fpKXKG4qKWawBfPddJYozHEqooLGfRm4E8
 32kPrqTo4MSss5iVJDVtJDqJ8fNKI7jMwP16iHvK4Bmna9eRYZTjVocg6ADX9AT6BB/9w6/
 I+DQDeLemoYoDSSi3GQ4VYixSbQ/mpk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 13CEB80236
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 10 Jun 2023 12:09:48 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686391788; a=rsa-sha256;
	cv=none;
	b=YmMf3N9eqRcfoBkQb9W5/Qqx0JPgpglzjclreezFaNCpQM5jgtlpQ0FySPrr9l8W4rAtbs
	OsIaUNJyui9Kd3ichIoXVH3u6tEX9YbJmYUGksEBVDRYJUWubibif3UtAP2693VSJc7YuU
	ZGFhMNjf0erEkPzR/aNvSOz4jiyf8ds=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=q6XXead5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686391788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=l99H/Kb5c4Petfujj7yVvPkPuoaJBOWiwge7voY9vSM=;
	b=vLGXc1cJCX13NOqnumkvzSl9ltEHWB5sdcrFtNrqlNCYs7oJEiV45kKdQyCxe9w6iUYOni
	pvOKOzKlGI9Qn5JqvlcLLLmhbb+xYTTXYUgYuhqQjlmJZ60R6huCHhn8ha8Q2uQnyTUCM9
	xbiiaxd+iOBbc+amJ4fTP/aVPHuWZsM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1686391787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l99H/Kb5c4Petfujj7yVvPkPuoaJBOWiwge7voY9vSM=;
	b=q6XXead5XkXixmdgfte0gTHDdnlyaiaNNxn6xN0jAHBEeLgEbIFTlVb6YECX2HQFPXH1aB
	mXwgVl61HsvXUSKnY13P78dmu+dt0+5ohvKW7UiTNlR1kWqZvSQpB6xTl2ElSuVPL7F1s0
	xptJKBPzrrHrcWRH6C7vEhUgp5/OtuY=
From: Sven Eckelmann <sven@narfation.org>
To: Mark Mundy <mark.mundy@draeger.com>
Subject: 
 Re: Error - mac address of the ping destination could not be resolved and is
 not a bat-host name
Date: Sat, 10 Jun 2023 12:09:44 +0200
Message-ID: <4515269.LvFx2qVVIh@sven-desktop>
In-Reply-To: <168633692419.986.3016729917435716783@diktynna.open-mesh.org>
References: 
 <8229391.T7Z3S40VBb@ripper>
 <168633692419.986.3016729917435716783@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2312176.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: J4MYCWET7VADKW3MSJIK5QX37IXCVBSZ
X-Message-ID-Hash: J4MYCWET7VADKW3MSJIK5QX37IXCVBSZ
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J4MYCWET7VADKW3MSJIK5QX37IXCVBSZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2312176.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Mark Mundy <mark.mundy@draeger.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 10 Jun 2023 12:09:44 +0200
Message-ID: <4515269.LvFx2qVVIh@sven-desktop>
MIME-Version: 1.0

On Friday, 9 June 2023 20:55:24 CEST Mark Mundy wrote:
> I think I understand this to mean that I should remove the ipaddress, netmask configuration items from the bat0 interface, and create a bridge with bat0 and eth1. 

Nearly correct - the eth1 IP configuration must also be removed because you 
configured two conflicting IP addresses (with the same subnet and metric) and 
in this process broke the routing table. 

> Something more like this for 10.1.1.1, and similar changes for 10.2.1.1 where it is actually the bridge interface that contains holds the IP address info
[...]
> allow hotplug eth1
> auto eth1
> iface eth1 inet static
>         address 10.1.1.1
>         netmask 255.0.0.0
>         gateway 10.0.0.1
> #        dns-nameservers 1.1.1.1 8.8.8.8 8.8.4.4

Why do you configure an IP address on eth1? It is part of a bridge and the IP 
configuration must be on top of the bridge. But you already have an IP
address in the same subnet configured on br0. There are ways to still work 
around this configuration problem but it would be weird to not simply fix the 
configuration.

Btw. this has nothing to do with batman-adv but is just about basic (Linux)
networking.

Kind regards,
	Sven


--nextPart2312176.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmSES+gACgkQXYcKB8Em
e0bALg//ejeXSU15OVqmx5Ude3MiFgPpaSnC4ju2WzUPKjSaKZtnXPH5lYmQFh+U
CmhzUb/HnTUe1t+XVv2tzFTdwkX2+tEfdI4G/NK+5eMxWwoi24GJVDi3+9lY6daq
HyfOZr3aEjsJj1Cad4H5rMYrq5d9HPb+CrmcoX0G3f/zDM2EGoDhAcwBTbe2FAwE
cTVtJEeoiU6GHIm3i6zyog7ck6BL1v7r7R88DITh/H2rgfKK9peZZqS3bxr7DkXJ
SYDI4b8q5iE0oHATZwkgXF9cKAFz7V9WNhd+yIaeEMO7UFJgw5VxWwKiedMn59GC
mEXC/DkvgwuGDi9wjvykREIvBeJB6tqiC8LnOHhpeeuLqcWLmj4cCi43mHcEI7pv
of2Gu1QpJM0UynUJh8IuMXJzxdLT9c+LP4YqLv7zm3qdRg/A+SBYmPzGWbnCeibz
wzyLmeB0NO2Sw4aCFlySkPzTmXckwWdUIUBSWe45o9cXWZrUivkV+JBcIJKqRUnt
to05O2ge6R7+zJKoqKAoyNGJhTv6x89PpZ2Vtpy43G/iTEvGqrT6VfslEMUSNQ2e
FDdmQy0Tr9/GeAMiBT/u910dt2NWbp4csdkGPFz4aHYsO7+LsWINU/supGBmElPD
FnhPIcDfvliVrzj5x3aPFhX/thXLkqxZwNDUnYweAAtjWqsXAYE=
=i9IV
-----END PGP SIGNATURE-----

--nextPart2312176.ElGaqSPkdT--



