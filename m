Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D30C43458
	for <batman-adv@archiver.kernel.org>; Thu,  2 Jul 2026 20:12:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E60488433F
	for <batman-adv@archiver.kernel.org>; Thu, 02 Jul 2026 22:12:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783023169;
 b=hp3ahKGsE8fHFXALwU2jkNxSxIzcWaHm7lmXIaxUNSvke7zNKA6ZUPDV91YllyuOnbogd
 LN3TOI+gSW91pmeh6B354L03zludtRp0DmjdZTCYWpjorF4rPoSU6VdbAaA8n7rIDLKT5NC
 p+Mc41QjnBkIcT9PY1w/GWXG9JWe3WM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783023169; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=s6XrM6qEfKEIkY51bfEqdvNqfRZgz7+jXlCw33ex6VA=;
 b=c/rK9xcVvy3w/sqoVYsC3+JmMBIrau6AIXcGQI14JqBrudtHTvIX/5SycIoxSxW/OESUH
 yaPm3WBVGBiE9+fmb+L5M73LBvKEQJ4gZe1s1AOX4pGgLV72K4Z1rrFAC4FqIJYo9Bt4eNB
 6W8W+g/3Zf+9JkWFu96s21pNJKf3sPI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=unstable.cc;
 arc=pass; dmarc=none
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 625BE8145A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Jul 2026 22:12:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783023148;
	b=MJCwN3C/50nqUqLHAbOCdbbPfvQH2VjOMKwAIFyO3qlnSuKCDleEuRaprPiI+beSCivPCX
	MnDk5KXUUiUxv8k19nSoyv1hgHkvrwnr9cRFiC48FfhQcT4ruK9odE0ZTW3JK7XM9cO9ys
	qp9uXiBiXK6zFm1yMcOzuBqksPs2kf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783023148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=s6XrM6qEfKEIkY51bfEqdvNqfRZgz7+jXlCw33ex6VA=;
	b=rOPnQMrgMLC0vWGoPpzKgiljg1/d6+40P77iTZMI2eA00nG7kwO7wWfb6Xn38rTFzkWh0U
	SOnQoG2hKg+H386lh4+pOPKKOJMBMZDmMBaRbRc6vOMjtk3ZNQZY/O3uqp+H7TSSOA2bmo
	hnsyyPRrSTZKZxliM1WYhWI9KQyqfbo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=MBO0001 header.b="BH/j9ZBl";
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 80.241.56.171 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4grp2f0SMXz9thj;
	Thu,  2 Jul 2026 22:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc;
 s=MBO0001;
	t=1783023146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6XrM6qEfKEIkY51bfEqdvNqfRZgz7+jXlCw33ex6VA=;
	b=BH/j9ZBlQZ7UpPiClFV3xzfS4TPRPJ2IucaghVx+L6bc1fQ+S50rMlKeYpYuEJGQRvAxsO
	Ziv/+UDSP/5SLRKXJ9r4L+iBzpxi3nSdT1KJhLi7E7h3rD4aKjwiSO/+pahmlNnB74pHPi
	neMHqW0LgdcJk3XnmTz6Is1W1abjZ19Grw6hm7vY2hJPkehFsSBqzxCC6AhqGnhczKtBDG
	zosVAKTFRDHbWh6/fXyk9qOjeCtetWu5X/BBXSH6y15r5rKZ53QOIDHGvhm6nKIC83O0HF
	6MSPiKJOH/WUO58Ew7n1jeUw5wwKhC+LsFqgc3Lpgz8IBEOK/DmLli8MFMFFxA==
Message-ID: <a3173e8d-d8e5-434d-9d01-5ae6f1f5c547@unstable.cc>
Date: Thu, 2 Jul 2026 22:12:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH batadv] batman-adv: dat: drop non-4addr backwards
 compatibility
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20260702-dat-drop-non-4addr-v1-1-7a7d35ff38f3@narfation.org>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260702-dat-drop-non-4addr-v1-1-7a7d35ff38f3@narfation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4grp2f0SMXz9thj
Message-ID-Hash: CHAIAXCZKJ3OWWNGR4NGNAT3BMKYRPX7
X-Message-ID-Hash: CHAIAXCZKJ3OWWNGR4NGNAT3BMKYRPX7
X-MailFrom: a@unstable.cc
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CHAIAXCZKJ3OWWNGR4NGNAT3BMKYRPX7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 02/07/2026 22:10, Sven Eckelmann wrote:
> The 4addr unicast packet support is mandatory in compat version 15. No
> older compat version is supported and the kernel doesn't need to keep code
> to talk to nodes which cannot be in the same mesh.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <antonio@mandelbit.com>


-- 
Antonio Quartulli

