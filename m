Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA56EC5DF7A
	for <batman-adv@archiver.kernel.org>; Mon, 17 Aug 2026 09:18:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 22A8B8149E
	for <batman-adv@archiver.kernel.org>; Mon, 17 Aug 2026 11:18:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786958283;
 b=Gahpud72mJIA1X/rdVaAnwiSEyjCKgtR9ijoDyphGWzqXMvT5iTm+r9u7NuCLJCxGIlvv
 ue/gKHFi+xw2SS1bPnXPl30ZmyD8kQTU2Vvf0FF/nnph8y9Q2Jd5Ge6rwA2SiY/60ImmZ4N
 D5C6ug6YlgGX+2PF38XzsZ6bWvHVpJg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786958283; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bcIx67Fbh9+8js56pY025rLngKW6LqFCTkIScQJflJI=;
 b=A9lgIvQjwyr+HR++SzDoiYJFQ2JHorloZKHl0cvM2DF9A3OH0p5EC9MkFzGL/aasd5nXz
 Dp+fXSkCYaGKwD6jSJVeMmrF1x/0nMiaH6XRFhVF8Ez69YJfjrxYOr5LQBYfzTBgRZTmntU
 6+9Sy8YYxpkEXqxsmObtv3OsKepYrck=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D312F80E40
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 17 Aug 2026 11:17:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786958274;
	b=EisggxCFrDFDTAed5EmbwYYxFBReGJOSXh+sEtVDgtWlwyjG6SLTPNwk2PMWE7rIbwCn+M
	pWuWK2b1pmiDWuQty7FSfIHU+tLlQ/6X7MRszT/KdrVZ+2WzrS9nnvDuN4xzAb2y9487Gl
	k5MpjtKDsrGBoG4qGNP0ZueuYRjNloU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786958274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bcIx67Fbh9+8js56pY025rLngKW6LqFCTkIScQJflJI=;
	b=ZY3QxHGFLWax/O7jDqKLVjs7Z4T4AzB0px+UTuCRzg2i3KXJEcJGoYh3hOtlfUVlFRt8z6
	qcByIiVmMiu/kRg54hSOrtg47My6v19HD/zXIwBISxnbV20coEVHjSxmbaqYtERkkiETaV
	hgFYSQsJz9pSm/c7RfYY0oAWNsKdOI4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UA2o3nlc;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DFE4D1FE24;
	Mon, 17 Aug 2026 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786958270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcIx67Fbh9+8js56pY025rLngKW6LqFCTkIScQJflJI=;
	b=UA2o3nlchwDgRh6ZFaKnSp4NqZzsAxuVAwA07ezaQR54iYdWxCF9+8KKYQhp8PX3myZrsE
	Yybh3OdemXsU8hpFWfUk2zCe3czMZ4rvLsg3VU+lwHYLMh55oYUwSavAAyzaBbDk7IF41+
	WCf8NrREd5DfZV9BmifyR+mJIkIfz7A=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v3] batman-adv: reject unrepresentable multicast
 TVLV offsets
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, Kyle Zeng <kylebot@openai.com>, davem@davemloft.net,
 linus.luessing@c0d3.blue, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260817084955.944189-1-david.lee@trailofbits.com>
References: <20260817084955.944189-1-david.lee@trailofbits.com>
Date: Mon, 17 Aug 2026 11:17:21 +0200
Message-Id: <178695824178.1497243.16045312752677179315.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=sven@narfation.org;
 h=from:subject:message-id; bh=UHs6IDBjNkc0HenuR0X3Z46jN92fQ6pA8qmh0JQhhKc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlNF9c5cv1fF271K/Li1eOb51ybeypO8FJ2v+gC1x6zK
 j6xeJmjHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJmEUw/GJacGRZ52vWQKGn
 Nq2zulcZ6q1NMT9151nAWqc52XNqrrxkZDiyyjC0P4hlz9R1fFMbl1otjNwfkqzEbXP/S9zT+e6
 iU1gA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7RSOZUTA3R2GIGWR5JIPIBLPEAJ75RL4
X-Message-ID-Hash: 7RSOZUTA3R2GIGWR5JIPIBLPEAJ75RL4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7RSOZUTA3R2GIGWR5JIPIBLPEAJ75RL4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

> The network and transport header fields in struct sk_buff are 16-bit
> offsets from skb->head, and U16_MAX is reserved as the unset transport
> header value. batadv_tvlv_call_handler() sets both fields from a received
> multicast TVLV without checking whether the TVLV end is representable.
> 
> If the end offset exceeds the field's range, skb_set_transport_header()
> truncates it so that the transport header precedes the network header.
> The negative difference is then returned by skb_network_header_len() as
> a large u32. batadv_mcast_forw_packet() consequently accepts an oversized
> multicast tracker and accesses memory beyond the skb data.

[...] 

> ---
> Changes in v3:
> - Rename transport_offset to thoff so the comparisons fit on one line.
> 
> v2: https://lore.kernel.org/netdev/20260810145754.828936-1-david.lee@trailofbits.com/

Looks to me like you've also dropped the
Suggested-by: Sven Eckelmann <sven@narfation.org>

b4 diff -v2  20260817084955.944189-1-david.lee@trailofbits.com

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
