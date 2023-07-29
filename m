Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B214DC001E0
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jul 2023 11:12:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 35CA982FC4
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jul 2023 13:12:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690629147;
 b=XSgvWP4e1k8pwEcFtQTnj1Ku2KdX8hrw5AG2/nPWVy5O8Of/jnl57IRSEawIDma7V2f7S
 ckGbIXAVZf5LdR7P9c95f2dbs671cTPcwlH+xf4keA6cFkfd/k9Nb+ei7d+fi7APl76Rvcf
 k5UAEyY3q1O5Jged6ZdrqkHDjP3PkLA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690629147; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=V5XVMXA2yLqVH26IrUPDpTN7hR2ALeQ+J3ivNj7nxxU=;
 b=SzIM2U/TEVIhPTN2J+Cd6d9L7uvLUs2V8+eHeR075gcKqRimVgUxBGbKw82PczQi9DZia
 4QlnqAXmuFE1txaJI0RzPitlFV4z66V7Hz3kUNvAUPqKfeBgg52k2JNRv7EO1yOrI8D2sZB
 YkT7u9fwRJ6yI94rmkEryNfmsojaocA=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 492C480964
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Jul 2023 13:11:31 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690629092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=V5XVMXA2yLqVH26IrUPDpTN7hR2ALeQ+J3ivNj7nxxU=;
	b=BrV9PtI6ZQqtXBGZQhZMtYXCRQ9/Jfh2SELqn29a9BYkMFyWvXguMHcvqNdj6g2xkdO5Wz
	gYZ2ThjAzUloEop8cvP2UDR971awOm4kr/Zn/QvUoS3oDtZoNcH9kOxBw1ue2sSQW7InYZ
	GDf6kF1Fh3oR20rjmGbk7yxjDhfUF+g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oQAsFAQa;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690629092; a=rsa-sha256;
	cv=none;
	b=ttKIvoi7jrO/pSnwifSwxz+DqflTrDnYRmU0qyfHMVnTMQqu85pmFggg4Hs2f/Z2AWIuVk
	SvfjqqP2Xv13NhLBZCUvGC9bTW6WdMTu1eT4RnMQO67HJY3k8jW7SOO6I3/jwqpAtv+6i4
	vWWT136QXGn5U3hxW4EZx9daxoPp7j8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690629090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5XVMXA2yLqVH26IrUPDpTN7hR2ALeQ+J3ivNj7nxxU=;
	b=oQAsFAQa/3Hxuxv29kVmA37FycLJqTd7d7zQJqLkyNUyUo0KccL+LlifW5FCLyDxl2mCef
	0QT0lX2JgXluXcl2sSuM5jcPwQc27ED6v+ovaIcWG8SOMifCf610HC+ytjzl/UqQODwjwk
	Hjj0xcu1407ZpgKFKN4ScyvaTSuZZJU=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 0/3] Implementation of a Stateless Multicast Packet Type
Date: Sat, 29 Jul 2023 13:11:28 +0200
Message-ID: <1918354.atdPhlSkOF@sven-l14>
In-Reply-To: <20230720043556.12163-1-linus.luessing@c0d3.blue>
References: <20230720043556.12163-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart45781347.fMDQidcC6G";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: TNCBVPNGZGSCAW3TQLKSL3KPJGBANLLE
X-Message-ID-Hash: TNCBVPNGZGSCAW3TQLKSL3KPJGBANLLE
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TNCBVPNGZGSCAW3TQLKSL3KPJGBANLLE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart45781347.fMDQidcC6G
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 29 Jul 2023 13:11:28 +0200
Message-ID: <1918354.atdPhlSkOF@sven-l14>
In-Reply-To: <20230720043556.12163-1-linus.luessing@c0d3.blue>
References: <20230720043556.12163-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Thursday, 20 July 2023 06:35:52 CEST Linus L=FCssing wrote:
[...]
> The purpose of this new packet type is to allow to forward an IP
> multicast packet with less transmissions / overhead than the=20
> multicast-via-multiple-unicasts approach. Or to reach a lot more
> destinations (currently up to 196, depending on the payload size, see=20
> Wiki documentation for details) than with the default multicast fanout
> for the via-unicasts approach.

Please don't forget that batctl's tcpdump+wireshark also requires support=20
for parsing it. Most likely, this was not added yet to not confuse third=20
parties in case the packet format changes.


I have now acked the various patches and have queued them up for submission=
 to=20
net-next. But it would be good when Simon also checks them.

And we must also first release 2023.2 (including submission for net +
net-next) before these patches can be added to the batman-adv repository.

Kind regards,
	Sven
--nextPart45781347.fMDQidcC6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTE8+AACgkQXYcKB8Em
e0bIQRAAl2WclJsYEpYFphKfOdkT9NInRRmTncbXVALyIDgny4vzOTzgIiepthuh
54/9WP90gvDvht4k4W3a7LpEWtjpK7xF3jw355qLdsocEaJw78z28QhlSogGzPM7
xwebRPDtvWObEHQNLS75x0nq1X9+tzqt1RQe0SQ9YrGaNmXBWBmtriL+IMxnKlAp
I2jrVkmCx7l1wfjaZnuWdzlAtKSOiwNGaboZ0CBEN1EKdKl985dZtOJYFzYuo0eb
yK/9ecEnSeuZGNdc6+x6F9hGXIrtdq2p0qL+UCX542LWyGgDfOOTwP3opaSTqIBD
5S4FVcmz/WMIv/lx9FSSK1tf0C2yR4L9gg24kSMVjpIsOVWHwLYxcOZL7NVo0Gxe
oBTIcql5lSNuIUErbN30nMb3VipYBESzuWo92ro0eg+YTQgrcArVWyQMCd0Wbd5I
22/HXtwD0+W6NTbMlLW1h3FWj7jeDrinITMWCvF8MSIGixAdIBF8yqoLzEdUMWfd
tgeCbeZAS/XHg9DH7+ApalQkzqajDRbthZaPn8BI/VuKXa2nyIHvEinEBsSFJ7e8
W95prAmtikSH/aicyxQ76tpPIHZMvvK2J8JDeJFh/mLLCE8CaT+Re+mKm/FdkT8l
9rHZq6hekI17d/m1LwK6xvjMQr+Dts02NZezgyRrLTtfFUlRYw4=
=vXSf
-----END PGP SIGNATURE-----

--nextPart45781347.fMDQidcC6G--



