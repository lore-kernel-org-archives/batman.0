Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62FBCA5FE6
	for <batman-adv@archiver.kernel.org>; Sun,  4 Oct 2026 08:29:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 24C1A83E9A
	for <batman-adv@archiver.kernel.org>; Sun, 04 Oct 2026 10:29:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791102584;
 b=prL2+hh27tAg1V/Y2bzo1MVw6ZGA0czLPYyxd+ZOcarjTd+rZrlnKQ2Y5faoGm3QFXa47
 hQZtNfrgr8PaJ2XJkowdcAKixNwBOF5ogQq9GJ52TGkyZpoKH3pP63zP9Pd/37BaEl8/9Yl
 3JN3RqBNBp+hJye9hInF8NkWqjX730Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791102584; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Yhdtj+Zop4nVx22i1DK/A6uasyESbVUg2t27aDM9qcI=;
 b=tgqhnzNNApwoCaZmhwBZN02E1NvRcv6O7mDRkgdVxDjPMshb6caScydz/2sGSAqWd1iE8
 bPV/frRheBHD7QXDh4rkpFf+GBaDwSgzzlPmsO2ewxDI5X15mGkD0g7sytJ9ZuOdaCv4IaB
 a979hNlg1g0Nn39skvvwQgwem+6/xHE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 86F4380F6A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 10:29:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791102577;
	b=Vc4LfXqYki3XWuMAKzNFxlKMK3M3UWwK+q9UwBgHVUjZgBFvKqkpC2BuaFP22hUwBHxhiN
	Xx6lX5N39PvypWmvUX1IvHbIqFcAFfL85a7wpigHWFHyM5dQnYWx+m4RXHvErEszIn8I7r
	xEjR1KLE1tHAno/cOC6FbaFSN5KtaSU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791102577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Yhdtj+Zop4nVx22i1DK/A6uasyESbVUg2t27aDM9qcI=;
	b=A5pY04YxUoby3KXzQ7apIBmez4aZnZMtrVU6MZihihDdDBO2J273BrXj0jlomIY5/FuJ4o
	0ONQNlzqMmYYkgyAJ/ttKET3p3PZhjNWrzYvyfGZySt+jOrgT+4M7SKKOKMtajW1zlIk9P
	SKGPVi+lPNV0KW8vLRpKvBP2FN4U6FM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MBjIwd6n;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6C72020131
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 08:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791102566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhdtj+Zop4nVx22i1DK/A6uasyESbVUg2t27aDM9qcI=;
	b=MBjIwd6nH7JurPspYizwkgnNP5yXF3Z6eaJbFaNNCBx/peD23MVnWNUsnWU3kqX+TjJ/9q
	AbzUsk84sun1ENFsvwrsS8ED0hNSlVRU+LGa0x/wifmduD8snZcHRd37ff/pIPyo5rPV1w
	PSle5hlvHclpWBIPAOPULh6DeNxnq6k=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv] batman-adv: dat: initialize purge work before hash
 allocation
Date: Sun, 04 Oct 2026 10:29:23 +0200
Message-ID: <13341984.O9o76ZdvQC@sven-desktop>
In-Reply-To: 
 <20261004-dat-uninitialized-worker-v1-1-c34745e83f1d@narfation.org>
References: 
 <20261004-dat-uninitialized-worker-v1-1-c34745e83f1d@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6393628.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: TEP5W5SBX3PFDT2Y5QL56NN46EADYL6O
X-Message-ID-Hash: TEP5W5SBX3PFDT2Y5QL56NN46EADYL6O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TEP5W5SBX3PFDT2Y5QL56NN46EADYL6O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6393628.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 04 Oct 2026 10:29:23 +0200
Message-ID: <13341984.O9o76ZdvQC@sven-desktop>
MIME-Version: 1.0

On Sunday, 4 October 2026 10:21:58 CEST Sven Eckelmann wrote:
> batadv_dat_init() only initializes bat_priv->dat.work after the hash table
> was allocated successfully. batadv_dat_free() unconditionally calls
> disable_delayed_work_sync() on it.
> 
> This is currently not a problem: if batadv_mesh_init() fails,
> batadv_dat_free() is never called. But as this might change in the future,
> initialize the delayed work before anything in batadv_dat_init() can fail
> to make sure that batadv_dat_free() always operates on an initialized work
> item.

I think I will reject this patch because it is a little bit too defensive. 
Instead, I will simply reply to Sashiko that this isn't reachable. Similar to 
the batadv_v_ogm_free()'s mutex_lock() which isn't reachable when the alloc in 
batadv_v_ogm_init fails.

Regards,
	Sven
--nextPart6393628.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasIOYwAKCRBND3cr0xT1
y/jsAP9CicGvD5Hpmbe0JqC9AuvDEGdNtOVx1iBrvJo4VkmT6wEAlGeMwbQBFpRM
k8NHVQdjDOOqZd+RiMbqmfb2jGgkvwM=
=femJ
-----END PGP SIGNATURE-----

--nextPart6393628.DvuYhMxLoT--



