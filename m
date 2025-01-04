Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A188FE77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 08:07:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1314083FF2
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 09:07:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735978073;
 b=NCBJjbWPBNCXhHDpo4CmC9rG0US+HfIEmmwgPG5TaemQcafmTTC/zJB2gMezWos6tSJLj
 8o8dEBbIXvyYKBoDNHevIOaolissOSPxtkzo8pHp6JSjnDNRgAx91aTeR9GPChjfFGD0onS
 oc6wEVNxf6fj1ENvgnEV7tEEDEPfX5Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735978073; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eFWCVAW7Vrt7iUCb8s890tVXDTbLJAQu+U/nNHANpZg=;
 b=kDHRBoeL+8V30nuePJHJPemRzkxo/0jrXct7nVAtqCilXt3qBDjI5XKpsbXhcEYEGwl0d
 B4+WmnamanHZTfqMSX8lUczmIil/MDLG83e7w80zgCsllERmsD0gLellRNtk40Y3rKqPO4C
 OR5Ra+pwJMSL5GkyfrNoh38y3mJo6Pg=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4B56183CE3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 09:07:38 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735978058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eFWCVAW7Vrt7iUCb8s890tVXDTbLJAQu+U/nNHANpZg=;
	b=nFwEnYUF/V+YLlMbCo3bTw3+P3qaWVNBWoKOEBSODIWRovTPu3lpskISroy1XhdulSLunI
	T25MqcyRWFvbyqO9rwrK6mOtZI7y0yjFyPpGZHzGNmJFfrW2ZX3KyrtemO6NOZGAzdy0di
	MVHBUmLQT/9bLP1XJsUvNfX891MGo6Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0lctKn+G;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735978058; a=rsa-sha256;
	cv=none;
	b=BIXJW1xsZjRI5KtmSowYDbVoOeJVZn6uwX+Ey65ZsXN+/zuXA3y2LCyYcUGtP3FEUDgyJt
	mhc82VHsh21pZDcTAGWQ8RSxZFCpIO11YKeEgI5/4pV8kfRus0uLXOlgQ9YDtouEZjIIeD
	RQeAzZgE1x4gs1vZxfAnRwp+DK+tGC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1735978057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFWCVAW7Vrt7iUCb8s890tVXDTbLJAQu+U/nNHANpZg=;
	b=0lctKn+GJfcUFP0WfUBbyxAIv3Szx4JbrDI/2XI6rOBfcCMWxfGydlKi/93fVm4NxgFNPh
	k35R3gvdOO7DrjW7BGpL5VM7LPoVGhJUfTl58oQGI60K9IEmO79wqc5mZ/FwOwy0xPaC+R
	V/R/4siMmvibdf7Ge/0t8TDS4TOoYio=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
 Noah Peterson <noahbpeterson1997@gmail.com>,
 Noah Peterson <noahbpeterson1997@gmail.com>
Subject: Re: [PATCH] batctl: ping: Add subsecond precision to ping interval
Date: Sat, 04 Jan 2025 09:07:34 +0100
Message-ID: <3510805.5fSG56mABF@sven-l14>
In-Reply-To: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
References: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6260655.MhkbZ0Pkbq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XLCERC5ODUADLBTH63CGGBJV5XEEOUSA
X-Message-ID-Hash: XLCERC5ODUADLBTH63CGGBJV5XEEOUSA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XLCERC5ODUADLBTH63CGGBJV5XEEOUSA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6260655.MhkbZ0Pkbq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 04 Jan 2025 09:07:34 +0100
Message-ID: <3510805.5fSG56mABF@sven-l14>
In-Reply-To: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
References: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0

On Saturday, 4 January 2025 02:36:45 GMT+1 Noah Peterson wrote:
> @@ -58,12 +59,16 @@ static int ping(struct state *state, int argc, char *=
*argv)
>         struct batadv_icmp_packet_rr icmp_packet_out;
>         struct batadv_icmp_packet_rr icmp_packet_in;
>         uint8_t last_rr[BATADV_RR_LEN][ETH_ALEN];
> +       struct timespec loop_interval =3D {0, 0};
>         struct ether_addr *dst_mac =3D NULL;
>         struct ether_addr *rr_mac =3D NULL;
>         int disable_translate_mac =3D 0;
> +       double fractional_part =3D 0.0;
>         unsigned int seq_counter =3D 0;
>         unsigned int packets_out =3D 0;
>         unsigned int packets_in =3D 0;
> +       double ping_interval =3D 0.0;
> +       double integral_part =3D 0.0;
>         unsigned int packets_loss;
>         struct bat_host *bat_host;
>         struct bat_host *rr_host;

The code doesn't build:


    CC ping.o
ping.c: In function =E2=80=98ping=E2=80=99:
ping.c:77:13: error: conflicting types for =E2=80=98loop_interval=E2=80=99;=
 have =E2=80=98int=E2=80=99
   77 |         int loop_interval =3D 0;
      |             ^~~~~~~~~~~~~
ping.c:62:25: note: previous definition of =E2=80=98loop_interval=E2=80=99 =
with type =E2=80=98struct timespec=E2=80=99
   62 |         struct timespec loop_interval =3D {0, 0};
      |                         ^~~~~~~~~~~~~
ping.c:110:57: error: =E2=80=98end=E2=80=99 undeclared (first use in this f=
unction); did you mean =E2=80=98send=E2=80=99?
  110 |                         ping_interval =3D strtod(optarg, &end);
      |                                                         ^~~
      |                                                         send
ping.c:110:57: note: each undeclared identifier is reported only once for e=
ach function it appears in
ping.c:77:13: warning: unused variable =E2=80=98loop_interval=E2=80=99 [-Wu=
nused-variable]
   77 |         int loop_interval =3D 0;
      |             ^~~~~~~~~~~~~


Kind regards,
	Sven
--nextPart6260655.MhkbZ0Pkbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3jsRgAKCRBND3cr0xT1
y38gAQDCUyuC/lBvie+rO+yJAgLpf9RF4s790AIRbBYeMs10kwD/fnA1XhQYRnn0
bDrrPvv+PMxLLQfqLo228aoD0yqhagI=
=HK/N
-----END PGP SIGNATURE-----

--nextPart6260655.MhkbZ0Pkbq--



