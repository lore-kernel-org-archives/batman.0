Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD07BCA0FF2
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 15:09:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2BC6583E1F
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 17:09:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756652972;
 b=Ifva/glyQi9YF8K2QjUycomxN25Bo05poBjtq55lsbVOEN4AJN1CdWDa9SP6pwlP9W6Q5
 nSXT/dbtkzAde6tjlvt9wuikI1XBsOHdDHui5D6VtQuBPanNTdIBhfDh9IBPa38FGvn9Z9D
 5NC9u2JiNkmUjWQqFbR9spK4ybNA0IQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756652972; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=crdcp8etfaKPi7nRe4woJB6Vpl8jxEOkT9Rr52gb7aY=;
 b=giOr5k/LZAfE8q9Iq91GL87hgVSK21PXS+kcJylg/QVEDLYZCqxx754mJdQDSBqx6RTeZ
 nHA4tilBRYwt0/KXER8SYKrHjtf+YGjz7xuUtdUphpNlazivvkUCa+fBW6fE2SqsHXfS6S3
 7E4BnK1pMim9SBGbmPk5qslSfRG1WuQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1CA4C8211F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 Aug 2025 17:09:12 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756652952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=crdcp8etfaKPi7nRe4woJB6Vpl8jxEOkT9Rr52gb7aY=;
	b=kqQqlhZV13Y3bXbyQ1WL3IzxOEMlCgxFVEtzphXv4oRRJgCt9dAXWuZJC5+MshNJKPIVM/
	7k5MSZzJ3r95nTUbeN9sEvHZ/jKT6yngDDuw0cqf9clx2Nm/Sp/CfrQNc2XnUzVSrvyOmm
	v7S5VXPx2b707rYQfHiIv6OVcrNbwJs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JisNLMvg;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756652952; a=rsa-sha256;
	cv=none;
	b=iuxhN87vVddAJSl0colaDszj55QyQ53aYj2gdkKdjjtj7HWWJnGk8SmGzztLgTpcODxl2X
	3bLkz9Lzeqi263/NeAiGdSjbsrVTMz/nL29wb7f4laXYW7jW6NcDDbuhBfwJdH8mfN9gdQ
	Y5dABtvJRktR4joybdKN1DRHsK/e9Ww=
Received: by dvalin.narfation.org (Postfix) id 3072A20000;
	Sun, 31 Aug 2025 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1756652951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crdcp8etfaKPi7nRe4woJB6Vpl8jxEOkT9Rr52gb7aY=;
	b=JisNLMvgegqS02gjV+g9EXc8bgjlZdE9sARjfDMbMkT5xnm1AZEmM3wb1ykqFd2EWAAgCe
	LA+z4LE7cJcNmBrmR9OsJl5UNqrPxXoDWA97jYwvfu36QBm2heBXPc970cRTacnSS4vixJ
	ECF1b6HEhrLZeegFEBkB0D7GK4W2R08=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org,
	Stanislav Fort <stanislav.fort@aisle.com>
Subject: Re: [PATCH net v2] batman-adv: fix OOB read/write in network-coding
 decode
Date: Sun, 31 Aug 2025 17:06:38 +0200
Message-ID: <175665260151.58639.6084959400627208281.b4-ty@narfation.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831145623.63778-1-disclosure@aisle.com>
References: <20250831145623.63778-1-disclosure@aisle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ERAMZJT7QM5X3VWF6EYEFLHMEOQVPSJ7
X-Message-ID-Hash: ERAMZJT7QM5X3VWF6EYEFLHMEOQVPSJ7
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: Marek Lindner <marek.lindner@mailbox.org>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, disclosure@aisle.com, stable@vger.kernel.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ERAMZJT7QM5X3VWF6EYEFLHMEOQVPSJ7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Sun, 31 Aug 2025 16:56:23 +0200, Stanislav Fort wrote:
> batadv_nc_skb_decode_packet() trusts coded_len and checks only against
> skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
> payload headroom, and the source skb length is not verified, allowing an
> out-of-bounds read and a small out-of-bounds write.
> 
> Validate that coded_len fits within the payload area of both destination
> and source sk_buffs before XORing.
> 
> [...]

Applied, thanks!

[1/1] batman-adv: fix OOB read/write in network-coding decode
      https://git.open-mesh.org/linux-merge.git/commit/?h=batadv/net&id=d77b6ff0ce35a6d0b0b7b9581bc3f76d041d4087

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
