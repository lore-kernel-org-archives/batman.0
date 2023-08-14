Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA2AC001E0
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 16:06:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ED4E283252
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 18:06:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692029179;
 b=TZcM4qJdnIc/spalSrT7VgmxcNupOuGQuvzCaDshzMqLNWCJoXWFaqvbPPqPy1Z9PVZya
 /44CXvpNProH7qStmQg8iAkvuvM7mL3sn25p4LemD/SMTp7T9DS3ZgfGM6vcI7s2tXVbDm/
 9Nl0uMqoO/Upumku4g7LzIUwvCGH/J0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692029179; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Z0cQ6kNHalqeT75BBCyieclkqTC3Vo7D4qwHMeZ/dvM=;
 b=NzkaR9Z9aWPT0lXMerufY7uXE+gocNa6r4AK6RZg/ijf8ZevTndpz+ynlvXBCMa6y/sOY
 KvAhlMCgym5Vz4/saIQonBS2JIsukuQie8wS4nBPDGgUaccrwm7QhooGj/UrvCE4dvE0aq9
 nkCponqBwEGQkNcD5uMYpAJ/J4ws5m0=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1CEB0807D8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Aug 2023 18:05:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692029147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Z0cQ6kNHalqeT75BBCyieclkqTC3Vo7D4qwHMeZ/dvM=;
	b=RQaWp4E10wrGZFYNrTsMnMeYTASAcpM9l2olYH2yH+iCFozickP2zU5yT9mC82c1YM1URD
	cnzgWh83+7YINSNLd6bS/DlKhwYP3LBds2HLuQftUqo3nday4uSNXUk3iz/Mo3o0R9pJja
	ib4PM3SlBv/TGtpLbFvD4ixfp2pm+WU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=HAAB7Zvi;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1692029147; a=rsa-sha256;
	cv=none;
	b=T0naA9Nv5pQ8kNmRyDrCcwhStL4KuSQhzZ1uqvEMYekpMtc54DOxE+IkpeKZ0Qie/yoBrq
	Yv4IX0O0SkBhlaw70PpMmH9IyAmwVAsiY2Vf1BS2gBhoTwS/+9MkuBrEmHbR4NLRVwB99W
	Q7WtXKrUHBTiQtpXodrbLswwbRnCIRE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1692029146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0cQ6kNHalqeT75BBCyieclkqTC3Vo7D4qwHMeZ/dvM=;
	b=HAAB7Zvi0ehITc7MJu1Qy8MoL+Iy9FaeymNdW7JBeVCS4cELqLTgGwuBq4hu+AbNLXafQt
	bPwEpYGlKcblR378qAR0n89t6qU4h9HE2E+DYm0elmM2KaJSSETv3GkxvMmhzs+fXV3/IV
	862vQCTLmA5skWbwhAG5QjO4S/o9IXQ=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 0/3] Implementation of a Stateless Multicast Packet Type
Date: Mon, 14 Aug 2023 18:05:42 +0200
Message-ID: <12274425.O9o76ZdvQC@bentobox>
In-Reply-To: <1918354.atdPhlSkOF@sven-l14>
References: 
 <20230720043556.12163-1-linus.luessing@c0d3.blue>
 <1918354.atdPhlSkOF@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5710412.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: WWM7WGHP25ERAT7LPRZQ7JWIVYB7G5S4
X-Message-ID-Hash: WWM7WGHP25ERAT7LPRZQ7JWIVYB7G5S4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WWM7WGHP25ERAT7LPRZQ7JWIVYB7G5S4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5710412.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Aug 2023 18:05:42 +0200
Message-ID: <12274425.O9o76ZdvQC@bentobox>
In-Reply-To: <1918354.atdPhlSkOF@sven-l14>
MIME-Version: 1.0

On Saturday, 29 July 2023 13:11:28 CEST Sven Eckelmann wrote:
> I have now acked the various patches and have queued them up for submission to 
> net-next. But it would be good when Simon also checks them.

Just discussed with Simon, and he had some good points regarding the 
readability of some functions (not so much actual functionality problems)

Kind regards,
	Sven
--nextPart5710412.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTaUNYACgkQXYcKB8Em
e0b8wA//XpPLs3kOLwxQYhvysgkdNBiF/szzsLJXzcqOgM9ul0fz1Y1widugUBbl
e2Wl6ThZdnzN8nwFw06NcYa6m5bV+5UY79ROyTBcl0JRjkwoZSENA+ckdO8BNQjW
fyM+sPRkkmNQEfTF07ydsSXYq0eSfbT5JcojnDXE6E/4wWqCxfBQHlSoR2HknZEM
/LWdOvpHT+CZB0oQBYjf7mq46kI9I9lX5U2EQ4omf+pR37Ae+q2Wxs4cE5xNSWwR
YnPnoTF6qD1hg7T4zeCYqkrWkiT/pJCZgJYVfHERUrFkL3d/PVZJFr2cq4rzIlCb
WVsl/p8idSqW/iVS9KPuLHwGkfIwsPkm+3UwkISdWhTtN/6lNtDgSpvyvXWNnEhZ
3cbrcs6n9UjEh8LlJBZpDBPFo/LzD20Nzc4WhoqdH/H7zlm8KkzvJeTRRVY0HgY4
d1uFRoRjfm/akntO+HEhVWqnFuJiPMcj8EqylnMdMyyJqwNPSXvm4exszm+YQyeS
OeB+C2OTdTCoBsvqOCuOaC+PoiGQaA31iRzPq1tNMgJn5BnBoL44GWwF9hx2x1Bk
aIZrJ9ujW3Jq3RFFxuHGEeVg1WLLRWeluLb3UXywPNCR6UEVJaYPpwwmyXXygZ+o
FJjcYueEs1EJlv3i8owB2oFlxhRKaUlrDmrmriLPkx57yT0fQYM=
=6VHP
-----END PGP SIGNATURE-----

--nextPart5710412.DvuYhMxLoT--



