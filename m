Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7962CD6E55
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 09:02:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3587D8556C
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 11:02:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780477356;
 b=W+W0TE2/RTRv1YCrcBXZ2B3cXdor38XCgPEXUPqPxgDmh46cl6tGx/Uoq8M+Btbx1Ubfj
 ToCdiP3P+YQJs9+81KE6yEZg+WUjMFa8GpFky3yQRJR42wc/ARK0RJIx+M3Q0rRF/PtrnFq
 CT4jLTdD2xHzQvhxN6skZX/wHRKyrw8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780477356; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=K0GOSa7pR1jJR5EBKpCSaPddlA99w+oFdD0eiBfewGU=;
 b=eujEeXwY/8kFHc+aw2l6a9JPHu2pXFE0G1VoYAWS+fdlkVm/gqJ8cS7XLgwmp2JELP32l
 9ATzdgCdKynxm+ONFlQ8o+EHetHdoDmn9d6ZP5W5rhI9wjXo+PyMuwJ1ODLXv12yTfWtp7e
 rp2aZs40RG+64LEyD9NBNlk6UlxI6Y0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 53BEB8447F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 11:02:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780477347;
	b=oBzA7jPhgt8UrAVYaOK3sfMA2qfm/b2oEnLGnWXThxi9C1CHDV+dRNqStSxCtwSKM3PII6
	T8hzPyXQ7NWDaMWeTR+Bk3BzcSmi1jTKN+qM/cmw5y9gP1YQUHqVEERMNUHSzxIWVclOUg
	pNcshxCCZwsyzndY2xMeLRXoT+3dpJQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IO2Dej4j;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780477347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K0GOSa7pR1jJR5EBKpCSaPddlA99w+oFdD0eiBfewGU=;
	b=yyOMLyFdwU+sdcQzc7RoCysPsEh4CJ627b6r2Jtt8ulAa9qf7gA6e0Ez7An9x3dV/AWhz+
	yKpb1VCDA0eM/xfMajmHWhR0CR0B6Yux98R2hls2r2M2sE0Vu9H6wduK3RdWOVi5o72M4+
	hZMe3rC2ClQV3UOxc9PnMtCEqjDmaPM=
Received: by dvalin.narfation.org (Postfix) id D8D672023F;
	Wed, 03 Jun 2026 09:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780477346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0GOSa7pR1jJR5EBKpCSaPddlA99w+oFdD0eiBfewGU=;
	b=IO2Dej4jiDjYqggV8MHOmM3Ky1qiwgZLzy3Byeso0dLqda/EQKjzepBnA22QpjdMEd1vqR
	5BcvBBF83MqRErYFzzTIi+kSINaZYgrc78FwKF0MD5eUV2/30oPBRbNVp02nZcuG5NkVNw
	o/GJ+mc6QhDcRp3vlNfJZTDynU6mMv4=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: sw@simonwunderlich.de, marek.lindner@mailbox.org, antonio@mandelbit.com,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv 3/3] batman-adv: use GFP_KERNEL allocations for the
 wifi
 detection cache
Date: Wed, 03 Jun 2026 11:02:23 +0200
Message-ID: <2275479.Mh6RI2rZIc@ripper>
In-Reply-To: <20260603045118.0625E1F00893@smtp.kernel.org>
References: <20260603-wifi-cache-cleanup-v1-3-d5ed08075c96@narfation.org>
 <20260603045118.0625E1F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3760743.R56niFO833";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: G3A6BHS2GJAH2XKFTU672EZOD2T6NMBU
X-Message-ID-Hash: G3A6BHS2GJAH2XKFTU672EZOD2T6NMBU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G3A6BHS2GJAH2XKFTU672EZOD2T6NMBU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3760743.R56niFO833
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Wed, 03 Jun 2026 11:02:23 +0200
Message-ID: <2275479.Mh6RI2rZIc@ripper>
In-Reply-To: <20260603045118.0625E1F00893@smtp.kernel.org>
MIME-Version: 1.0

On Wednesday, 3 June 2026 06:51:17 CEST sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but while looking at the
> rhashtable usage in this file, I noticed that rhashtable_lookup_fast() is
> called without rcu_read_lock() in batadv_wifi_net_device_update():
> 
> net/batman-adv/hard-interface.c:batadv_wifi_net_device_update() {
> ...
>         wifi_flags = batadv_wifi_flags_evaluate(net_dev);
>         device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
>                                               &net_dev,
>                                               batadv_wifi_net_devices_params);
> ...
> }
> 
> And similarly in batadv_wifi_net_device_unregister():
> 
> net/batman-adv/hard-interface.c:batadv_wifi_net_device_unregister() {
> ...
>         device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
>                                               &net_dev,
>                                               batadv_wifi_net_devices_params);
> ...
> }
> 
> Can this lead to a use-after-free on the bucket array?
> 
> Since batadv_wifi_net_devices is initialized with automatic_shrinking = true,
> it can be asynchronously resized by a background worker at any time. This
> worker frees the old bucket array via kfree_rcu(). Without an active RCU
> read-side critical section, couldn't the RCU grace period end while
> rhashtable_lookup_fast() is still iterating?

Would be nice if someone else can double check this. But this doesn't seem to 
be valid:

static __always_inline void *rhashtable_lookup_fast(
	struct rhashtable *ht, const void *key,
	const struct rhashtable_params params)
{
	void *obj;

	rcu_read_lock();
	obj = rhashtable_lookup(ht, key, params);
	rcu_read_unlock();

	return obj;
}

So, rhashtable_lookup_fast() takes rcu_read_lock() itself. And the returned obj 
cannot be freed because all functions mentioned here are protected by the 
rtnl_lock().

We are therefore also fulfilling the requirement from the 
rhashtable_lookup_fast comment:

 * Only use this function when you have other mechanisms guaranteeing
 * that the object won't go away after the RCU read lock is released.

Regards,
	Sven


--nextPart3760743.R56niFO833
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCah/tnwAKCRBND3cr0xT1
y8ZzAP9vEh68cW1+QPtnKyDD9MMkyFWwasYaKYcXBTLuiIysuAD/Sju84BZx5nyk
qg4Z7ALt19w7SiOWotndBC/9ROpIMwU=
=Vaaz
-----END PGP SIGNATURE-----

--nextPart3760743.R56niFO833--



