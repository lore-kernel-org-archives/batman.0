Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C18EC54E5D
	for <batman@archiver.kernel.org>; Tue, 12 Mar 2024 18:26:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AC76B81A52
	for <batman@archiver.kernel.org>; Tue, 12 Mar 2024 19:26:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1710267961;
 b=T2LSW21wG+b4+/Qk81aEL6fV8k/7FWQyYOHyfVfJXU7uOqKPLsk3RldS/BN9L5V/DRdgE
 UqHu//TMuu77/UkkAaST99KZfPorCS4H3m7g01eRjL/8r0nDpVE3J8nvpR6D/Eyy3LJw3Jh
 lY4naPkIokO99dXcGIU1ZO6xxxS8BoM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1710267961; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DEL4cjEyuWba9hd0VuaR1DyNAtm+hNflQGQLLZ9qcC0=;
 b=czplrTtspud9VU6b2m8GnE/9lTDhkJ39L7MaV07R5hSU577C02TdTxzMpuKs+nTY/+wJq
 SmwxVkZ7R27rdrRrxTJ9lb9d0ZjwrjGt/OuJsUWwuDjXIaS4dqDOFiHqSIc2H29KZ9ZIFD6
 xI4oZC2QQsaD1PWriC70NfAWITGBGuM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 31F3080E39
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 Mar 2024 19:25:55 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1710267955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DEL4cjEyuWba9hd0VuaR1DyNAtm+hNflQGQLLZ9qcC0=;
	b=C3hCPX+J5lZtXNqTun9o/TfdAh1rdLZb504EfRcGyDPs6E1JQzL6Pm8BOwDXPrm9mn5hbf
	ivNlkQmK4xqUdoMsG3gp1bKnLXpQx4XEHuWSGAgRjzGdmVAdo/rAZKdtaRuExNUkHtrW8C
	JxXeFYTkLqdUCHfcKTyHWnTFkaavDJY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="gBui7r/c";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1710267955; a=rsa-sha256;
	cv=none;
	b=q2x96BiCF96zUGnD5iGtmCgVToKWgCWVivmvFmkPYIvCGCCbEGkzpZbuJwv2af385g+lja
	Kx2oZQ3LZVoBqslUFsPHwndUmNway4YxhKoCPRSeWaRcBgczdDqHi3lf0WdOlN43GV2FfD
	f+kV/RUXuTgZhiEPJpgK4sxw8s/WGjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1710267954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEL4cjEyuWba9hd0VuaR1DyNAtm+hNflQGQLLZ9qcC0=;
	b=gBui7r/ctXj3eu4a/QMGKWEfJHu6zzn2OMqHmMlXf91K0tteGcwhTd0QlEdgYVmjLYZUZd
	924r2x9JX0Pg9cMbrxWgDuUUs/plVf8KM4UR7BrJxfRzEVDr9jnavhpt97v9uEFnqCbpem
	hzbbNyj5ND9/O4OxMCo6eLcOUOlV11Y=
From: Sven Eckelmann <sven@narfation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: 
 Re: [PATCH] batman-adv: prefer kfree_rcu() over call_rcu() with free-only
 callbacks
Date: Tue, 12 Mar 2024 19:25:51 +0100
Message-ID: <3554205.iIbC2pHGDl@ripper>
In-Reply-To: <20240312181628.2013091-1-dmantipov@yandex.ru>
References: <20240312181628.2013091-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9250623.CDJkKcVGEf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: HAGEHQGLVDWJOJTO2S5GWRQPI4IFNVLT
X-Message-ID-Hash: HAGEHQGLVDWJOJTO2S5GWRQPI4IFNVLT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HAGEHQGLVDWJOJTO2S5GWRQPI4IFNVLT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart9250623.CDJkKcVGEf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Date: Tue, 12 Mar 2024 19:25:51 +0100
Message-ID: <3554205.iIbC2pHGDl@ripper>
In-Reply-To: <20240312181628.2013091-1-dmantipov@yandex.ru>
References: <20240312181628.2013091-1-dmantipov@yandex.ru>
MIME-Version: 1.0

On Tuesday, 12 March 2024 19:16:28 CET Dmitry Antipov wrote:
> Drop 'batadv_tt_local_entry_free_rcu()', 'batadv_tt_global_entry_free_rcu()'
> and 'batadv_tt_orig_list_entry_free_rcu()' in favor of 'kfree_rcu()' in
> 'batadv_tt_local_entry_release()', 'batadv_tt_global_entry_release()' and
> 'batadv_tt_orig_list_entry_release()', respectively.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Ah, SLOB is gone and now this is possible.

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven
--nextPart9250623.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmXwni8ACgkQXYcKB8Em
e0ayBw/+PY9ZT4UuSHO7g9WrUayT80ugNYy7kfyMMw4Ft730jLh5bGq3ckVrR2Vb
/qaKgKMO/1//pYbxs9f73Ql3UQErr8kL0EZnkAXoCWGmmByPrx8TFltJGYdqwJcC
gz9Fb8soul84hxe92+EErr66a7AExZgV4/Z12ift+bwflUNXGxPiBdwwZv8RmgkM
NnWrmxNnnYsfpMNGtSbDFQGO8Ubv1/Q2Vq9bbbSAC1FqGcsFLrsfL0pgmscLClSC
A5CvYgkT3ZGGKsiZKSPTEmb8Nsy+0GCbhLTp93mb9CHaIZcl/ydFp01K8vXGYMz5
nv0mYABhnV0Bi9erXyHQTcHFrNCIxW0bq4HY163YmN42e8PDXLXa/H7QmWYmKDOQ
TM85Fxk6idvWqejBELm6ZwuV8I9bH71lXfgK5dOzURS9/y2DTCIzzbYr/n9RuuRU
2tZYsg95SPtvLxnC4Ctf6MMfI13M3v3DhMeO4sBhm8j9Ui+vTt98ubz6kRWxxImd
Ea+8IGmWtwBYVKR5xrrQxyzNVG2hRKZ/amE1OytmfuKqJBDTv0jXjchjK+z8ldLP
edvy+8GtvXO1/um2W4V5Opqe5CJ8tXRsje8bszErWu2AABqgS4Tb9On7atfBFdqa
NRfMvFc080ep2NYg4Yeyg6FwJ4ymUWUvFZkCxhdhv9au3mniJmM=
=dCS4
-----END PGP SIGNATURE-----

--nextPart9250623.CDJkKcVGEf--



