Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEC8CD4F4A
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 18:09:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D650859D8
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 20:09:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779041356;
 b=k+ScxXnWqlYhl2x6umAWhRMPq3eO7r25+p0kA6nEHtX56gBCO7FDMGxlWXyfAuaw1r50p
 +KZctfuH9hut7HPRrTrXxevXPbdnxNibEusxuZ+iI12pZrYTZOxcA6qv5JTrmOWf3y9zzbV
 u882EWpB0l1bJGB0+z2ciU2ocCy30O4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779041356; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=53DOWufWUCciaBKvvVQpgxjbVFkRWap+iYy67h7nsJw=;
 b=pStuigwYU1OVa/bI7lTQ2AgS+fB33iGI6N6um5oHWrg8DsmB0ewBdkXwmNp+HxQ1Jq6u9
 odskTxkL7P07Fh33TqvT9UN3BLKOnMqLTGI6Skn4ig7EM2lKg5Llj/CJJ3wcr++8uP4zuB6
 TFcQ1B84eqZXz+0XvKzuaL7LogALRvI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 03DDE83E9E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 17 May 2026 20:08:32 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779041323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=53DOWufWUCciaBKvvVQpgxjbVFkRWap+iYy67h7nsJw=;
	b=Wa0osyxx1D0w73I8n89pyI5s9jV7AAVnNFwS6dRbAq5xl1kPqT9PntAjaRWrLtV4UD7YFi
	t+FIcylc5XgGI4USDWUqcAsra5tflDDgmqJAE10YADTIfNy6yk/dAaWdHZnxWdI59U8IoE
	1w3+r8sU9uJx2ywvEEAtfItZ1SsPGVY=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779041323;
	b=rfKlZUH+3J/uYYU4ZFynvgjW+1Z9XSfgzh8fIft0s65y3rmqeh3D1WyGlOgdn/GxsrME7y
	4ChYRj8r0SxGUCvfB8l4QRYUK6oyikPlOESBCRvYSa0P6UN0cXfPtiSejKKp6YUsxCVOa+
	HJK3qK53Q2yOJy5oTtdEzJolbbfi1so=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fyBrmxnX;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7A27D1FD57;
	Sun, 17 May 2026 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779041311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53DOWufWUCciaBKvvVQpgxjbVFkRWap+iYy67h7nsJw=;
	b=fyBrmxnXihkf/NQXcKBTz3xO7fd4dnPM+Qq//bS5UM8ko9NKdhzkHPzH67eudhsSnTSQvw
	V1nxELEvkGAqXW4lw9E1q8YazB/iVKwlqlKs+4Sbt8rwfYx1gwDOSlJ9WoOf1ZrcZQHanj
	dw7cmDIczgEGS59h1lzNyy8CllxN7Pw=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv] batman-adv: mcast: fix use-after-free in
 orig_node RCU
 release
Date: Sun, 17 May 2026 20:08:27 +0200
Message-ID: <3412939.aeNJFYEL58@sven-l14>
In-Reply-To: <agoBLITjEyVPScvd@sellars>
References: <20260514-mcast-rcu-list-free-v1-1-0e20f24faa61@narfation.org>
 <5073295.GXAFRqVoOG@sven-l14> <agoBLITjEyVPScvd@sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3419480.44csPzL39Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XC2AGGIDIEHCLUP2P5F6Y3V4CLTZDJRK
X-Message-ID-Hash: XC2AGGIDIEHCLUP2P5F6Y3V4CLTZDJRK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XC2AGGIDIEHCLUP2P5F6Y3V4CLTZDJRK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3419480.44csPzL39Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 17 May 2026 20:08:27 +0200
Message-ID: <3412939.aeNJFYEL58@sven-l14>
In-Reply-To: <agoBLITjEyVPScvd@sellars>
MIME-Version: 1.0

On Sunday, 17 May 2026 19:55:56 CEST Linus L=C3=BCssing wrote:
[...]
> Maybe this might make more sense as a fixes line then, though?
>=20
> Fixes: 500ea14940f8 ("batman-adv: Add multicast-to-unicast support for mu=
ltiple targets")
>=20
>=20
> I think before that commit we only used these atomic counters in
> fast path?

I don't really care about the fast path. I care about things which could be=
=20
called in parallel and is only RCU protected. For example in 1c090349e2f6,
we have the reader:

static struct batadv_orig_node *
batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
{
	struct batadv_orig_node *orig_node;

	rcu_read_lock();
	hlist_for_each_entry_rcu(orig_node,
				 &bat_priv->mcast.want_all_unsnoopables_list,
				 mcast_want_all_unsnoopables_node) {
		if (atomic_inc_not_zero(&orig_node->refcount))
			goto unlock;
	}

	orig_node =3D NULL;

unlock:
	rcu_read_unlock();
	return orig_node;
}


And here the cleanup code in 1c090349e2f6

static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
					     struct batadv_orig_node *orig,
					     uint8_t mcast_flags)
{
[...]
		hlist_add_head_rcu(&orig->mcast_want_all_unsnoopables_node,
				   &bat_priv->mcast.want_all_unsnoopables_list);
[...]
		hlist_del_rcu(&orig->mcast_want_all_unsnoopables_node);
[...]
}

/**
 * batadv_mcast_purge_orig - reset originator global mcast state modificati=
ons
 * @orig: the originator which is going to get purged
 */
void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
{
[...]
	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
}


Regards,
	Sven
--nextPart3419480.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagoEGwAKCRBND3cr0xT1
y+yHAP9VNkh7SAizUd8sOsf0JMsZ5Cng9wmgDJlAy86oawweGgEAnQorCmWFcspK
3Y30CfdovMQrC7aoidYEDvZlIEXN/AM=
=meKX
-----END PGP SIGNATURE-----

--nextPart3419480.44csPzL39Z--



