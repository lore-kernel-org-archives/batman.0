Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19598D743C6
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 19:46:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 760BA83F8C
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 20:46:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732131992;
 b=BKAfQv0hXvMLH+7Q5hpJJPH9Q+6sppcgGTULPdSPYIPNmEy0F7suTneVK3q44B2ewdzhA
 60rACafzQG8WOaJPuCrniS2wkwa8hqYBZ6Uc1JGUGKjsj/5o/b4I+Oct+69JAlm/n8bWHVL
 3szAcA4IQI48Glw625m0BCCCZAKOOx0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732131992; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7SScqA2cST7Tm3Lj+CmQdR13kOKzXfmzixAgtZi1AKY=;
 b=khdbNVos6J/WBR3N37yi2L/9hR0+88gIQjletdCssUtZaJZuZ2SsWjnjrLlcsL254j6TF
 RcmrfWZWTwkW9cjaEc32wTR5QakqOe3QzsymjxbjxmuuQ9HHSpCqlTEO19WtCJj8j4TdukR
 RNBHE8rZV4VSaf+l+jLdIO+PcY7P6pw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 25B2C80855
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 20:46:19 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732131979; a=rsa-sha256;
	cv=none;
	b=lGyv1DNhNKGKL4Es8tlmcB/N53PZzo7TVPHQhjc4SO5hp+hBsL14Ns3YPr2RKIRcucRyyR
	WE+SCOhjOm9H4U0yT5oq9VlHBvOM2+Ar26H0JQlcvX4nnnCUe4wa2pnOHtokhBd5kdoz/C
	R3OOKXXjfRmSVeCCEWqitnMdDRrdjp0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kfJ3M0XJ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732131979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7SScqA2cST7Tm3Lj+CmQdR13kOKzXfmzixAgtZi1AKY=;
	b=lJKsNryhXMBWJPKrWnlz4hLdUMGyrcnjk/ZLBeFbRohk3XL5SbKj/66swhJ3Y8H65uhx10
	Hhe1/uz2QcbRJBruvXrZUgmqc5XQIw7NqTQS0HxYmrXhi6ZFSOsNv2k1cJzgHqbfGO+kgy
	BA8ZkKm+QbfjZ1sc8KPuBk/7fO76Txk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732131977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SScqA2cST7Tm3Lj+CmQdR13kOKzXfmzixAgtZi1AKY=;
	b=kfJ3M0XJMJ5PEocUJOU7iFAyX4EMBJIdoxwJaaI7S+zlgOYPh5Uptf7JD/hDs0esECqpYe
	e2TnLDwHQEoNbXUz+psnjb2EtEg/kjfr+VMpg6nsIwJXdqWEEVSS8v2/qomUxxd1nxTHp5
	oAdGaBvmfGI3he6bEE2j2ZV1YnJb7N0=
From: Sven Eckelmann <sven@narfation.org>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Remi Pommarel <repk@triplefau.lt>
Subject: 
 Re: [PATCH v3 0/5] batman-adv: TT change events fixes and improvements
Date: Wed, 20 Nov 2024 20:46:12 +0100
Message-ID: <4969949.GXAFRqVoOG@sven-l14>
In-Reply-To: <cover.1732124716.git.repk@triplefau.lt>
References: <cover.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1936453.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BDAM3DMI7XUYD3XLJIGLU2TW55ATCNIB
X-Message-ID-Hash: BDAM3DMI7XUYD3XLJIGLU2TW55ATCNIB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BDAM3DMI7XUYD3XLJIGLU2TW55ATCNIB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1936453.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Antonio Quartulli <a@unstable.cc>
Date: Wed, 20 Nov 2024 20:46:12 +0100
Message-ID: <4969949.GXAFRqVoOG@sven-l14>
In-Reply-To: <cover.1732124716.git.repk@triplefau.lt>
References: <cover.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0

On Wednesday, 20 November 2024 18:47:13 CET Remi Pommarel wrote:
> The first three patches are actual fixes.
[...]
> 
> V3:
>   - Fix commit message wording
>   - Update outdated comments

Antonio, can you please review the patches? It is important that we get the 
first three out early (to avoid merge conflicts when sending the second part). 
So maybe you can have at least a look at the first three.

Kind regards,
	Sven
--nextPart1936453.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZz48hAAKCRBND3cr0xT1
y85lAQCXoHNCiKBwOgQzavFTAC/Czg1SS+RAM7bPyOMqj/9MGwD+NdV8jB3+gDva
Msih2710jJoiqlv+whkLwJpw+O2H2QY=
=y1hY
-----END PGP SIGNATURE-----

--nextPart1936453.tdWV9SEqCh--



