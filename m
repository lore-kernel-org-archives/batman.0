Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A46C43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 04:48:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2952E83ED2
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 06:48:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782622135;
 b=tc5uYoa/UNkBqVQwaQWar3Lb+XpU4CIAcgytFeVgeyaDn5B8vO+B/q/rYTnHX22szyNTf
 B8dW+7MEkh9Llqh8X9skkFushQeBbKjBw1GwDvJJ+F3L8CbR5tw0V//kC7tBONHdjoIhLGz
 9YoyEgR9iBk4FQktVhwpldUZ/pyZjYo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782622135; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gp1aunLY4MC/a0Zn+kTuixZYk458uLrU1eNpIe9Y3sI=;
 b=4NMDfKXyRjrJISgTwFeIr+SHfyJ8rLPS9YmpQ+NQwQwz55tPrD8bOz2Q6ZWXVCzvk1kYQ
 G4tl5vVzm693H/3qhz7XbZluVJQvsx6xmqWwNv/ZG22FmNl3uv3HL4iaeKvV3GvXP/1nxFg
 CIShZijM5A0j3dPUGjnsham6xHjjdg0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 392A6811DF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 06:48:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782622114;
	b=Mpy54GIWtLwX10/2J2sQwan3t/mFz8zkXKBh82Dp/fLVrVv1KyYWo9+moLta9fMxyP2Bw3
	pSnZYJWNpKL5qXRwQW9eu4+tRhA4DSEryvUk7ve9LYHrJxzLfF18NX6bBNiqWmgB+DY69i
	4CzqFf3v8UOrNXT60r/cfhGiRuWPH3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782622114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=gp1aunLY4MC/a0Zn+kTuixZYk458uLrU1eNpIe9Y3sI=;
	b=AArlN4NL7traZWhU5w9/Baif2MGDTiHfspPworhpllk+EEGXrrM9Sb0TYsL+gpZKkDeKmT
	+lGAIt9rijl8BUAwjs9qXeqhdCxdg3UIIAPf7hizT9mR9vWIVYWwtUoqJ+gtfmiZ+na2Mm
	/DYaYdhsmt2dkDBaWdrfZr9bxJI+bZQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lN+ua4ju;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 64CC91FF41;
	Sun, 28 Jun 2026 04:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782622101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=gp1aunLY4MC/a0Zn+kTuixZYk458uLrU1eNpIe9Y3sI=;
	b=lN+ua4juX/eUX1jd6omrB9Iqa3eZZIrWj9ACE8mLT8VPW+QWrP3FSJhenPFK0J0HFg4EaE
	tGT2+L7ibY6YmX2XJ2OkRxEExAufszjdIew8BabaWhHOBWOBT+QkdMYoFPmfNx3HZbCuXN
	SFbL2AOZ/C2lrB16J2wm8IK6zidR4yw=
From: Sven Eckelmann <sven@narfation.org>
To: WenTao Liang <vulab@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Fwd: Re: [PATCH] fix: net/batman-adv: batadv_interface_kill_vid:
 extra
 batadv_meshif_vlan_put after destroy
Date: Sun, 28 Jun 2026 06:48:16 +0200
Message-ID: <2572903.ElGaqSPkdT@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5239390.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KWKY33ONNAIJJIU2RWNOBR56TX5LB5BH
X-Message-ID-Hash: KWKY33ONNAIJJIU2RWNOBR56TX5LB5BH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KWKY33ONNAIJJIU2RWNOBR56TX5LB5BH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5239390.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 06:48:16 +0200
Message-ID: <2572903.ElGaqSPkdT@sven-desktop>
MIME-Version: 1.0

----------  Forwarded Message  ----------
[...]
New issues:
- [High] Removing the final `batadv_meshif_vlan_put()` call in `batadv_interface_kill_vid()` introduces a permanent reference count leak, preventing the VLAN object from ever being freed or unlinked from `meshif_vlan_list`.
[...]
--

commit 0818db7c27664fbdfdce2f408c5630f66e16ed4d
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: net/batman-adv: batadv_interface_kill_vid: extra batadv_meshif_vlan_put after destroy

This commit removes a batadv_meshif_vlan_put() call in
batadv_interface_kill_vid() to address a suspected refcount underflow and
potential use-after-free.

> diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
> index 44026810b99ce..e39c9c0ffe46e 100644
> --- a/net/batman-adv/mesh-interface.c
> +++ b/net/batman-adv/mesh-interface.c
> @@ -693,9 +693,6 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
>  
>  	batadv_meshif_destroy_vlan(bat_priv, vlan);
>  
> -	/* finally free the vlan object */
> -	batadv_meshif_vlan_put(vlan);
> -

[Severity: High]
Does removing this batadv_meshif_vlan_put() call introduce a permanent
reference count leak?

batadv_meshif_create_vlan() assigns a base refcount of 1 representing the
list's ownership. In batadv_interface_kill_vid(), batadv_meshif_vlan_get()
acquires a temporary reference, incrementing the count.
batadv_meshif_destroy_vlan() then drops the list's base reference.

Doesn't the caller still need to drop its temporary reference with this
second put() to reach a refcount of 0 and trigger
batadv_meshif_vlan_release()?

>  	return 0;
>  }
[...]


--nextPart5239390.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCakCnkAAKCRBND3cr0xT1
y/pxAPwKLuASbUUctnhbNEKgDJQBAsRZ5D+qL9b3ry21tDzDAQEAhXHuPdkO1DMp
0BVy2i/S2qE1sDmx0cHLra0c9c8HhAQ=
=wiGu
-----END PGP SIGNATURE-----

--nextPart5239390.GXAFRqVoOG--



