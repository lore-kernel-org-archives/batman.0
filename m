Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED9C624D0
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 18:15:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 48822821A9
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 20:15:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788286510;
 b=e8t4eBK6zHfPZUwTx67VBnJstCX8N4jqbaM6HvwviXIwL20AKuYbKQVpA7p+bova4VTBA
 2NUr57HfO9qhpSaGSo9wFWKUuBgxyCBgOP/6pnaSaJu7FnbeVwAKiaMJDXro1+ra3BvFMIv
 yVjdc7HQX/23Vn0UxUJVLds3GqXusJ8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788286510; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OVKLuxjWTOyErIPOuRo9M8ikjLwSjXWNwjxlJDxKYJw=;
 b=eMM5T6TiAWJTSJou4QvOy0egpoMmrF25767QI7+NP/P9s6saCDlazLaR3imqHvdjDboC+
 nMCl8Tqve51itCDx8SrAuiQxf7+AVRcn4IDcuCCq0Guzeh0L9HrZxdYMiJVppyw0i7jIGnZ
 7xi8wZjnNg2YRjwp2qd5lLA4I4dcgKA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2E7A180CC8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 20:15:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788286503;
	b=bbQGcNdP1tYSWmyAogsMBLqgbL8uvmRn656aAX6RbaVMeBAqX37/9Y+HQCNVXAl0VF+uc1
	YISQX/fPEYoRCQYoaaO8b5xBT4XoxG3bI+S7CKOXj1NO9ydsabQ+ZaK0Bfdq4d3A0wBjaH
	Kk3V4d0wDaD0OzitpmOFtS+qFemwT6o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788286503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OVKLuxjWTOyErIPOuRo9M8ikjLwSjXWNwjxlJDxKYJw=;
	b=xsTZqoDSX9+JmxUTTC7UStRGoo676Uow6Po0xrZU5odZ6jF53LA8+kujHq0zhdmwrwYBOF
	x8plXBQzvAnQ1EchIx/W3WXD0dA1gbQ0rqzIorU+zuFDwTyQTafvOOQSgY6jdNczb67DpS
	kgUX2vWHvTLaLLnsrEMoHIR4MrjvNlk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lK+BvUpG;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 45383203D9;
	Tue, 01 Sep 2026 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788286498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVKLuxjWTOyErIPOuRo9M8ikjLwSjXWNwjxlJDxKYJw=;
	b=lK+BvUpG0IRjdGJB4UrUW/KlCrXQp/05w3gtNmjVIFEBwA/YGmiqVq7ElSGdRjDwaOD8Ua
	+ZZwkKqzRgC4Djo8FjY3MzGqTSIF93ujtujCj33Syjlwz0XBSmIVasLAsv2ipGLWVHp+O+
	lxm/wwtrKrEkbGBUe1C9/L67cX37PMQ=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 09/15] batman-adv: tt: extract code handling a
 roam on
 add
Date: Tue, 01 Sep 2026 20:14:55 +0200
Message-ID: <2865163.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260831135117.574836-10-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-10-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12980698.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XPLSHEE5GPQWGCNX3MJT3VZH36RL65IE
X-Message-ID-Hash: XPLSHEE5GPQWGCNX3MJT3VZH36RL65IE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XPLSHEE5GPQWGCNX3MJT3VZH36RL65IE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart12980698.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 20:14:55 +0200
Message-ID: <2865163.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260831135117.574836-10-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D9


> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug introduced by this patch, since it is pure code motion, =
but
> now that the sequence sits in its own helper it becomes more visible: is =
the
> check-then-act on tt_global->common.flags in batadv_tt_local_add_roam()
> racy?
>=20
> The test and the update are separated by the ROAM_ADV loop, and no lock is
> held around either:
>=20
> 	if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
> 		return;
> 	...
> 	hlist_for_each_entry_rcu(orig_entry, head, list) {
> 		batadv_send_roam_adv(...);
> 	}
> 	...
> 		tt_global->common.flags |=3D BATADV_TT_CLIENT_ROAM;
>=20
> The rcu_read_lock() here only covers the orig_list walk.
>=20
> Meanwhile batadv_tt_global_add() does a non-atomic read-modify-write on t=
he
> same field from TVLV processing:
>=20
> 	common->flags |=3D flags & (~BATADV_TT_SYNC_MASK);
>=20
> and batadv_tt_global_del_roaming() also sets BATADV_TT_CLIENT_ROAM. There=
 is
> no common lock between those paths at this commit.
[...]

Please look at the next patches to see how locks are introduced.

Regards,
	Sven
--nextPart12980698.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcWHwAKCRBND3cr0xT1
ywoqAQDIPV8uj0iioqhCBBo+tFp1GDSYvPvIcNf5AkUJc6mgOgEArz5eo9eikxsO
Qy3JKz7VoanpMJ+70ozFWs1IXj4GhAY=
=vMsJ
-----END PGP SIGNATURE-----

--nextPart12980698.O9o76ZdvQC--



