Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6F0CD8C88
	for <batman@archiver.kernel.org>; Sun,  7 Jun 2026 12:28:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7C66B84350
	for <batman@archiver.kernel.org>; Sun, 07 Jun 2026 14:28:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780835326;
 b=gPBV7AWxnKKVZfjGL0lFqjF05D8QHawXdVFDuG0hJqPB/Bkm+bHVWIC7i2wJn0s7EE1Mr
 61m3AckypgtCltlXQThaxfsVyztwlFcyPSLsKAX6Rk4PAR2hyyccGrRzfN56Y0myxXWQXYh
 tFS+J8DPgQ061EqrwBDOQmQxIEwffGM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780835326; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1mgDVCnNo/xxfdR2Gv7VW5wGpCf/y2GqYmx2lBRHAUM=;
 b=byZgkSF2UC8S2pywloiq0b/xYVUV42Qxo5iEbqACiW5hz8JS500y6wGgK5ndyQ7VDwdd9
 saJJ+JMpAYmIN0Xl3zet4V6dgZL6LHELqI8CbS8OSy7oITxEer5UxcRWFiOGfefGG5VsuDU
 +gi4Kx6c7Dp1dQk056WghePYZNwN4P0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4E2983E70
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 14:28:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780835301;
	b=2c3x8Zn1xLY9sC4K3IY1UFkbm8U+ojYOnBUAXlYkX7rjMOP6+o6F7hRRGBmwd2202bKiXm
	DRJXwBWINZ/ilfoZjrrWaqVnpaRPilF1xzNBy9EHjcIMcppqI1iBQoLnMoFnCYdBeaFblf
	737Z1mg27HNGsZx5gCXiOc0vosUtYYM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rpy6EcVm;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780835301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1mgDVCnNo/xxfdR2Gv7VW5wGpCf/y2GqYmx2lBRHAUM=;
	b=4IeM/pyCmmkHjVCmFJ+aSXWpZ+By3OIYVZIHeox3AzEOk79PWMwD1SedwfPAu5o8XT6sUE
	j5Pnofbdqcn14p2FQhDji/Cq0cM1yGqPR8dPnsLNXSQz3kUc5MDAhCczqBDc1QNCMdfRPp
	u3SczTEkwItmNVFIt1c6jq4SS0RqtZw=
Received: by dvalin.narfation.org (Postfix) id 051411FD9C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780835291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mgDVCnNo/xxfdR2Gv7VW5wGpCf/y2GqYmx2lBRHAUM=;
	b=rpy6EcVmH95Dg56HzRMLZY47yJqxOeY/57kjqDleBTmLiwvdWamOI4oCR8VKdnATjWkG1G
	095zfI1ioZ1zJr8OgtBaNRvieSDj1YasYvu8oL7XjNLwi5cO/+TQ3GmH4CEz4wjo/aTAUr
	XEr484pmO5yLg6DzcPYVdsttjpQdTsQ=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv v4 7/7] batman-adv: iv: drop migration check
 for
 batadv_hard_iface
Date: Sun, 07 Jun 2026 14:28:08 +0200
Message-ID: <2859324.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260607-drop-hardif-list-v4-7-ade2931db295@narfation.org>
References: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
 <20260607-drop-hardif-list-v4-7-ade2931db295@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12932711.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: NH32H5BKHDQCNZVUADAEBB7X2LLGH4F4
X-Message-ID-Hash: NH32H5BKHDQCNZVUADAEBB7X2LLGH4F4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NH32H5BKHDQCNZVUADAEBB7X2LLGH4F4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart12932711.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 07 Jun 2026 14:28:08 +0200
Message-ID: <2859324.mvXUDI8C0e@sven-desktop>
MIME-Version: 1.0

On Sunday, 7 June 2026 13:54:01 CEST Sven Eckelmann wrote:
> With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
> for "changed" (or NULL) mesh_iface is no longer necessary because and
> batadv_hard_iface can no longer migrate from one batadv_mesh_iface to
> another one.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index d9e4d023..89803a8a 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -407,11 +407,6 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
>  	if (WARN_ON(!forw_packet->if_outgoing))
>  		return;
>  
> -	if (forw_packet->if_outgoing->mesh_iface != mesh_iface) {
> -		pr_warn("%s: mesh interface switch for queued OGM\n", __func__);
> -		return;
> -	}
> -
>  	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
>  		return;
>  
> 
> 

This should be added with the next revision:

diff --git i/net/batman-adv/bat_iv_ogm.c w/net/batman-adv/bat_iv_ogm.c
index 89803a8a..43440ccd 100644
--- i/net/batman-adv/bat_iv_ogm.c
+++ w/net/batman-adv/bat_iv_ogm.c
@@ -395,15 +395,11 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 /* send a batman ogm packet */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct net_device *mesh_iface;
-
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
-	mesh_iface = forw_packet->if_incoming->mesh_iface;
-
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
 

--nextPart12932711.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaiVj2AAKCRBND3cr0xT1
yyIaAP9ZluB/fd7cCl4rbdLQMebdZnuyV9DWMx7zcf2YaAIyTgEAuLS5L7wKtlca
OD6boJfoLBx5Xj2CRgOyj2LxBZ7e7Ag=
=ZCug
-----END PGP SIGNATURE-----

--nextPart12932711.O9o76ZdvQC--



