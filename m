Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2679DD68B19
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 13:58:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8871E83597
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 14:58:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731592737;
 b=rzzDkdMbCPc0phkjG2qHaLWtUYW0kgW1aFrE4aI00+XSzHldFEOby3NXA9tSzsjlhii5H
 Z0I1U8WSinfDuq+WW0fdOR+pIgbahoKfcctebkGGE9nrcMHTU+oYY+nMcWjk7gng7zYqpGB
 JYs4UpMdy+MG5uWHJ/RxtXm/iKj2DkE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731592737; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qZI1X79KDQQJA2x1WJKPKQaOq0ilpO3R9MCnipjCqWw=;
 b=faotAqJTlcwfYfFgZagasGXT4ItHI/4MC/iYo+AWrDaEnPNkGt8/Gj5cPlwYcQQTN37kN
 JgozVPot9BUuehnNuiK+Qt//WNjP6f30U3WAQmkQx/dtzchLao2Q7+LblzZ/Y7ht+bPSEWD
 i92fb8H3VwjTXb+L65/yCkwFepsExVw=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A2ED98151F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 Nov 2024 14:58:50 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731592730; a=rsa-sha256;
	cv=none;
	b=WNd4UTyqmevxy646yyVBzHX8dswlIakxAEgOtU23FQhpuz3kxcnlqT0PZ3i8Gfzx9jhM3R
	/OXLRW0Ha7lNGYZWhoeaYF4Lw3jMdGaRA8h1LddRLxbT/OdJOGK7BJoEUvpPZwMeKkqnRN
	8rnwC3x7Yft5P+XJ2v3chn28966Feh8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0CJSeYAW;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731592730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qZI1X79KDQQJA2x1WJKPKQaOq0ilpO3R9MCnipjCqWw=;
	b=xfo8o2OYlKddLwDKFQeq2XucZPaAio05nhB84O4hNDgJIZXvaAYxW6KVDI94lTGrJXBsIu
	bRc98XR8ixgCCYDXaqDLiip8Palfgnbm53dwBN3HDRjq92QfwcZqvIcBLrsqpZLpuSFMMz
	WP6AebnyKeCeg2AWySMz3C6gPDGbfvs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1731592730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qZI1X79KDQQJA2x1WJKPKQaOq0ilpO3R9MCnipjCqWw=;
	b=0CJSeYAWeqSRazDvD8XZdY1lmdetJrkQJhZfcw083iK4OE2Ike7sBXK7BlQtTD/epVeiN4
	PMQZjVp7Ay8IT8hvOwF9BJxBj71UyccRUySBwVC6uUgZgVABKEsrHVYXQMNJJbsGmnCLvX
	4UNHvYY1g7W6Dw+YUMbuom6JX6SbxOw=
From: Sven Eckelmann <sven@narfation.org>
To: linus.luessing@c0d3.blue, b.a.t.m.a.n@lists.open-mesh.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Nicolas Escande <nico.escande@gmail.com>
Subject: Re: [PATCH v2] batman-adv: add dynamic,
 bridged-in TT VID detection support
Date: Thu, 14 Nov 2024 14:58:43 +0100
Message-ID: <6100761.lOV4Wx5bFT@ripper>
In-Reply-To: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
References: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4965187.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BBHMYU7SW42CMQJMZWNDY5WVJECRP2RY
X-Message-ID-Hash: BBHMYU7SW42CMQJMZWNDY5WVJECRP2RY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BBHMYU7SW42CMQJMZWNDY5WVJECRP2RY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4965187.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linus.luessing@c0d3.blue, b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 14 Nov 2024 14:58:43 +0100
Message-ID: <6100761.lOV4Wx5bFT@ripper>
In-Reply-To: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
References: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
MIME-Version: 1.0

On Thursday, 14 November 2024 14:48:52 CET Nicolas Escande wrote:
> Hi there,
> 
> We've been running this for a few time and it's very usefull. So is there any
> news on merging this into the kernel ? Or is the BLA thing blocking ?

I am not in favour of changing the behavior of batman-adv. Now everyone can 
increase the number of managed VLANs without any control by the node admin.

And as Linus wrote, it also shows odd behaviors. And Antonio also didn't write 
his opinion here. I have therefore downgraded it from PATCH to RFC (instead of 
simply rejecting it).

[...]
> Or maybe I missed something ?
>  
> ---
>  net/batman-adv/soft-interface.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
> index b61f35918b5d..d7de54734725 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -599,7 +599,6 @@ batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
>  
>  	atomic_set(&vlan->ap_isolation, 0);
>  
> -	kref_get(&vlan->refcount);
>  	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
>  	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
>  
> 

This ref is for the VLAN list entry (just one line below the kref_get).
This patch is therefore definitely wrong.

Kind regards,
	Sven


--nextPart4965187.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzYCEwAKCRBND3cr0xT1
y/g4AQCJJ4odXmKubErvBgqKBUsW0J3BgP+Tzk5+5dy624glmAEAqgmon/CV2o3P
hoylpO7R4Sm0T9dBBdrfEdY4vC9CUgo=
=RHKv
-----END PGP SIGNATURE-----

--nextPart4965187.31r3eYUQgx--



