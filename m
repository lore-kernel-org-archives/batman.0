Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED93E77197
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 08:04:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 173F3840F0
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 09:04:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736064262;
 b=VBO66jxfHECkIPSu9GjHb7dTm+XQkAtuH/vCFGGSH5YU8pzlAp9wFuTV1iEOXVgT/EZi2
 vha0FiIMvObtoqZHveqcXRVjbk6so/aiJb1zrEvvfaBBRV50L10SDIATCdj9LSV+/3S8ctB
 7oZEm0VSmohlwoyVOYgy/So+FrPk20E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736064262; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rta9JDQ8iy0WLtrFKdcQRJBc5KTdaAkBQA58hKdzb+Q=;
 b=oSq4530A09r1+lP0aSy2oL0YGoF5bb4jmxuvVU2oq+L2BDw3017q0uMoA6Ujw8QD2P2oL
 veVz2o4BDYTUrk6AGJjVYxuMZpa+tryBc9M5qXaAlFuMPOVTxofECQ7qC/EJMsRL4LOgtRO
 LIKvhoQcZGwfgyZn+e4MpLeQ/rBrgM4=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6A41781027
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  5 Jan 2025 09:04:07 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736064247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rta9JDQ8iy0WLtrFKdcQRJBc5KTdaAkBQA58hKdzb+Q=;
	b=uL1taYQ527jb+YNyXYghyvRXeCbhatKS3UcC3HSo7aO1Wm6jcEzUNKyL8AMy/lZpa6hZFq
	QhvOM+QZTYDlVUYzHSiDa5LiailyPBbxyXPnpw9oGGLUNTxcd2Ioh95BZfBbPCzRBW+sC1
	O4Z+/QUqUEfiBFAiYZdjgPzxLNWMxME=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xPwmB7f+;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736064247; a=rsa-sha256;
	cv=none;
	b=yH2c3PvtoLG0Y67vkoyF5nG3HofaV989P+4mU1lbl1jdPmCFeGOXRh0vn64+aoarXPMCHy
	v8S1BwYdpJ/uWQym6EPB2kJdqJzOhuB16TnYWRpyGO0dUtKt/ldS3bcRB3u/uHWItvVXJu
	GsV5n448t2YOfezs5FmcwK3LWx/Ywgs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736064246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rta9JDQ8iy0WLtrFKdcQRJBc5KTdaAkBQA58hKdzb+Q=;
	b=xPwmB7f+/3Ex5L0ySSzg9EnNo22x9yDmGKzImisv1AuS4ChZCqSRgEf/3eRaDFY6KPSvi0
	u6vZeLtzxLF6cicZ0eZ/ZUScnWNYp4wbX9RksqAFF+xcSPMuKCa5bQMgNW0f143sflFQ/c
	D5e/cIm2gdG+loyURHOEG9eM6lV5uSs=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH v3 2/3] batman-adv: limit number of learned VLANs from bridged-in
 clients
Date: Sun, 05 Jan 2025 09:04:00 +0100
Message-ID: <15617211.tv2OnDr8pf@sven-l14>
In-Reply-To: <20241202053511.326-3-linus.luessing@c0d3.blue>
References: 
 <20241202053511.326-1-linus.luessing@c0d3.blue>
 <20241202053511.326-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4519325.1IzOArtZ34";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XWV7H77BBXRHGHMRIGJMND2EBZ5S3LLO
X-Message-ID-Hash: XWV7H77BBXRHGHMRIGJMND2EBZ5S3LLO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWV7H77BBXRHGHMRIGJMND2EBZ5S3LLO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4519325.1IzOArtZ34
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Date: Sun, 05 Jan 2025 09:04:00 +0100
Message-ID: <15617211.tv2OnDr8pf@sven-l14>
In-Reply-To: <20241202053511.326-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Monday, 2 December 2024 06:05:21 GMT+1 Linus L=C3=BCssing wrote:
> +       vlan_dyn_max =3D bat_priv->softif_vlan_dyn_max;
> +       vlan_dyn_count =3D bat_priv->softif_vlan_dyn_count;
> +
> +       if (vid & BATADV_VLAN_HAS_TAG && !own &&
> +           vlan_dyn_max <=3D vlan_dyn_count) {
> +               spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
> +
> +               net_ratelimited_function(batadv_info, bat_priv->soft_ifac=
e,
> +                                        "not adding VLAN %d, already lea=
rned %hu VID(s)\n",
> +                                        batadv_print_vid(vid), vlan_dyn_=
max);
> +               return NULL;
> +       }
> +

net_ratelimited_function requires "#include <linux/net.h>" in soft-interfac=
e.c

> @@ -561,8 +562,9 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(str=
uct batadv_priv *bat_priv,
>   * otherwise.
>   */
>  static struct batadv_softif_vlan *
> -batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short v=
id)
> +batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short v=
id, bool own)
>  {
> +       unsigned short vlan_dyn_max, vlan_dyn_count;
>         struct batadv_softif_vlan *vlan;
> =20
>         spin_lock_bh(&bat_priv->softif_vlan_list_lock);

Missing kernel-doc for new parameter "own"


> @@ -597,20 +615,21 @@ batadv_softif_create_vlan(struct batadv_priv *bat_p=
riv, unsigned short vid)
>  /**
>   * batadv_softif_vlan_get_or_create() - retrieve or create a softif vlan=
 struct
>   * @bat_priv: the bat priv with all the soft interface information
> + * @addr: the mac address of the client to add
>   * @vid: the VLAN identifier
>   *
>   * Return: the softif vlan struct if found or created or NULL otherwise.
>   */
>  struct batadv_softif_vlan *
> -batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv,
> -                                unsigned short vid)
> +batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv, const u8 =
*addr,
> +                                unsigned short vid, bool own)


kernel-doc for addr was added but not for new parameter "own"


Btw. the first patch also doesn't apply at the moment.

Kind regards,
	Sven
--nextPart4519325.1IzOArtZ34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3o88AAKCRBND3cr0xT1
yxyzAP9Pkhab8T/tkW2m0Zo9yryBMVo9yMBceu3M/k1s8t9GkAEA6O50frAz/+bP
8kKuMJu/5pVByf1LEb358X3dNSr9Nwc=
=jXzG
-----END PGP SIGNATURE-----

--nextPart4519325.1IzOArtZ34--



