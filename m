Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E37E77188
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 16:15:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AE58E83E5A
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 17:15:52 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736871352;
 b=iBkwl27jWueC2KnLCemCmm8Z70yjUHR4+SgTqqbp+ZgJ8aVXHvI+VJ2Di9qL1GB+SVvXw
 YymKUhcTWHEr1rHh7wsPcjkeakYzVrRz/n9odtTg0KzbwrJhjg2ONEYCmMYWOrg8kCQGrDv
 gNi5F5vSxC458HZX5j8ES4Ywbqktrv4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736871352; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=i3h/UA+4X7dAPV994kNDjjq9E4lmPAa1mDF8Vdi76AQ=;
 b=25EVD4Uhn19Lqk0lna7aOdpL70+0bXgPYJtCZ7MZiFJXPEeWTT6+nyfhFo+2MHWoUaeCB
 DzYrtoQ9MwnSUV6f2K+PtsiHMvpuQhZPu9v1NtjbVgaOVmgth+XYP3GlF/1Uw9g4Fb8a1v3
 3Q51w5UGY5Mk5rvSA/9j067Tg9FDs4M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9C04280A73
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 14 Jan 2025 17:15:44 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736871344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=i3h/UA+4X7dAPV994kNDjjq9E4lmPAa1mDF8Vdi76AQ=;
	b=3pYUROWgvzkrpwt8LA+q0B9p9pRvOqzfxPmTlUGfzveSzse1QzzO8MINr8FU214xKFb97o
	ErVPj/9AgWsawQjujAlkH/Ed4owrQZqD/T960Ibq0eGWy7Zm+D9k3a54OlJbCKk3WMGNgE
	Aset1L7K7GrfvGE24A/IJVkF3gL7UgA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0gmmAQe1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736871344; a=rsa-sha256;
	cv=none;
	b=YF5VIpUGGnqU1xYI3hh31XDQBmflR6kQ5qe2NyCuDzfltnDyYPoup/lmvvgT1lTXgXrAxr
	smMMEJ8B6j0uqSH3qgYn5C5P/ZE+rKi11U/Q0l4dlaHmLYsav6DqUrT+abn/7zTd6P6usy
	ALHYy//zNyvdq1Duiek7H591ETkCwVc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736871344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3h/UA+4X7dAPV994kNDjjq9E4lmPAa1mDF8Vdi76AQ=;
	b=0gmmAQe180radoCbUGBxD/GUCYEuHsl+XHE0N1sH1BGimsT4T7vW97MAKRZLEyq+9MjmqK
	n6edgLKRQP3+iMmFWDh18pIqJjlbk6SZwcdjwiSqgYqRnI4KdR0KxRQZcFpQuuZv3FLc/9
	6QH2x/yVxrKKSKwi7Q+Mpqqyvf2m0eE=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH v8 1/3] batman-adv: netlink: reduce duplicate code by returning
 interfaces
Date: Tue, 14 Jan 2025 17:15:41 +0100
Message-ID: <2295906.iZASKD2KPV@ripper>
In-Reply-To: <20250113200510.18681-2-linus.luessing@c0d3.blue>
References: 
 <20250113200510.18681-1-linus.luessing@c0d3.blue>
 <20250113200510.18681-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1991786.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: R65OIESMLVVMHEWMZ5HCN7IT2Y3T6D5W
X-Message-ID-Hash: R65OIESMLVVMHEWMZ5HCN7IT2Y3T6D5W
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R65OIESMLVVMHEWMZ5HCN7IT2Y3T6D5W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1991786.PYKUYFuaPT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 14 Jan 2025 17:15:41 +0100
Message-ID: <2295906.iZASKD2KPV@ripper>
In-Reply-To: <20250113200510.18681-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Monday, 13 January 2025 20:31:39 CET Linus L=FCssing wrote:
> +       hard_iface =3D batadv_netlink_get_hardif(bat_priv, cb);
> +       if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) !=3D -ENONET) {
> +               ret =3D PTR_ERR(hard_iface);
> +               goto out_put_primary_if;
> +       } else if (IS_ERR(hard_iface)) {
> +               /* =3D> PTR_ERR(hard_iface) =3D=3D -ENOENT

No, this would mean that the error is "ENONET" (Machine is not on the netwo=
rk)=20
and not ENOENT (No such file or directory). Is this a typo in the comment o=
r=20
did you actually wanted to use ENOENT in the rest of the code?

> +                * =3D> no hard-iface given, ok
> +                */
> +               hard_iface =3D BATADV_IF_DEFAULT;
>         }


Kind regards,
	Sven
--nextPart1991786.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ4aNrQAKCRBND3cr0xT1
y0hqAPsGPVuV36wBp4UtMvNgSPK7zm6m8OqfXq1girkydJgKsAD/Xh1hA1Jr2Wws
0ujUgWghIoQtgYUz2cigCbpfyh2LRwY=
=yRbk
-----END PGP SIGNATURE-----

--nextPart1991786.PYKUYFuaPT--



