Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58B5C02194
	for <batman-adv@archiver.kernel.org>; Fri,  7 Feb 2025 19:08:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 42E6283E48
	for <batman-adv@archiver.kernel.org>; Fri,  7 Feb 2025 20:08:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738955298;
 b=Kbl/KqHaw9zMGFipvLssvvx8pIhqs+irmxxOPbW/81tepQhx9zphYIBCPuYcdW/SmZPcl
 1Q/r8VRuFoTkDE1am9a2uznGoAFmvj/1YL6msGTwLxvxjQ0gT111QhWZOI9LXv2VXy6pO6+
 pVrLfH25BxRW9uUi8lF1ysW+iHSgljU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738955298; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zUQkJgKSJlWHvd7U1ERqNOF5uBNhv3tn2ye9Ff9EuYo=;
 b=KQMcxGwDXk20M1EarnDN1e3olrf00ce0vzjdD7VWyHZ9k8DFwpFW5IZBf4JDFiORTydhC
 0mItv4MxEuUoA7Zxl82FWXz63V6bS1+IuGIT31kuArR9gaTPiUiAeN+HZF4eDjsaFkCmpQF
 WvTbN/3X3kyFuj7GcOyNHDUHcsfhsdE=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5FFCF82509
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  7 Feb 2025 20:08:09 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738955289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zUQkJgKSJlWHvd7U1ERqNOF5uBNhv3tn2ye9Ff9EuYo=;
	b=s1aNiPoA5aUjfHcfndOJxtJBrNRIkib9p+QV8FO2KgNF2rsrrh/IBcAQQQFigbmt7SqwDM
	C2rFbI8B2VNsEJDsZwgOCEk/OccJiJWRYdNrWFXDL7GsZxUWqWr6wlYVcmRE8hYQVU7jHA
	mK28ky4ksyMtLp1T1jXY/JsoQ/CK0pA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Bi4V7NLb;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738955289; a=rsa-sha256;
	cv=none;
	b=D5Y8rIAqBlAU0qeI2gbdBwrixFfawF1SKnfP64sggwPeO9VX4GFnnlfkFweogs2sJAg174
	qNIdBDBNSivoLpgHH1oGbSp+igmaa+PuYJhA0PABFHH6X6qIIzBI7KL4iS1itbRfG3504M
	I8UCUJFL1gORe2GgDjI1OF2BQrkpKU0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738955288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUQkJgKSJlWHvd7U1ERqNOF5uBNhv3tn2ye9Ff9EuYo=;
	b=Bi4V7NLbZ9t5sxDZuJwEmTs/lUlho4DtG8Z4vNNpF4UhK2NjXbC4hhDuH7G89/BW0xvRSh
	gfWBIg7pMoXjX2AH0kCtC/4db2/WJHKO1HEjKl6dFLkLI3YM58nPW3Iy0NtoHwxJU8DDn7
	5x/npOxqF6HnCoU9Swnr7FDBsxNh2ZM=
From: Sven Eckelmann <sven@narfation.org>
To: Jingwei LI <marscatcn@live.com>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: No Connection Between Two Specific Nodes in a 4-Node Network
Date: Fri, 07 Feb 2025 20:08:03 +0100
Message-ID: <2365930.ElGaqSPkdT@sven-l14>
In-Reply-To: 
 <OSZP286MB15101558B02308C9DDFB940FD5F12@OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM>
References: 
 <OSZP286MB15101558B02308C9DDFB940FD5F12@OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4967099.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: RDVD5VQPXKEP6JSGCDBH4DAM4P6JBQW3
X-Message-ID-Hash: RDVD5VQPXKEP6JSGCDBH4DAM4P6JBQW3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RDVD5VQPXKEP6JSGCDBH4DAM4P6JBQW3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4967099.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Jingwei LI <marscatcn@live.com>
Date: Fri, 07 Feb 2025 20:08:03 +0100
Message-ID: <2365930.ElGaqSPkdT@sven-l14>
MIME-Version: 1.0

On Friday, 7 February 2025 14:21:47 GMT+1 Jingwei LI wrote:
> [B.A.T.M.A.N. adv 2024.4, MainIF/MAC: rax0/90:15:64:00:0b:ee (bat0/22:f9:67:7c:cd:e8 BATMAN_IV)]

Please make sure you update to 2025.0. 2024.4 had a bad regression in the OGM 
TVLV handler and I would like to avoid to start debugging things before 
applying a fix [1] for a known bug.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/b10d75d994ee49ead8c87a3f26417c666dfccc82
--nextPart4967099.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ6ZaEwAKCRBND3cr0xT1
ywPVAQD4/a96j8qpDoy8HnPDA4AFvB51bAWregUiXkMoAC8BlgEArreKjzrzgHEh
FzKEEfmrXrAvkQoZqH4YA7b3KrWyEgQ=
=GvU6
-----END PGP SIGNATURE-----

--nextPart4967099.GXAFRqVoOG--



