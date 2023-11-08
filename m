Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C44C4332F
	for <batman@archiver.kernel.org>; Wed,  8 Nov 2023 14:25:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 55D8A82EF8
	for <batman@archiver.kernel.org>; Wed,  8 Nov 2023 15:25:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1699453547;
 b=fznaqSB9v7Oj1JIjyb9LX2y75Tvx7C6n+eHxas6n+Y5nk57NfJ+CIMucRPdL87wmSeuS0
 yNYJCThA4w/N7nuk+8oy//cRABdqr277z3HL0DEV4Ob/Gs7Rw4oBwlAphxh2KcsmNU40Awh
 k/9M3DGTweQs+/C0oc8p1GysXKz8RIQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1699453547; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=e8UGZhlGIm+Uwo/Wk0kWNyvqLgPEMgT9rTh9oyB61cs=;
 b=SIHQ1WulcwvZ44wRBC3L8H5r+8IUBD78tDe5nc3ngrWS/NlrERUxysFoVuanivmVRG4uM
 AFGHs3sixLwRY7Mpv2kP9FgAxbMQwYiPRAjT/KzMFaZdvWR3+LDsAK3JgC5/Jre8rGTAzrQ
 lbZMv/tLfvMRMn8NtxfzkkLCJOBZuJg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 31D8A80DF0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  8 Nov 2023 15:25:43 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1699453543; a=rsa-sha256;
	cv=none;
	b=JjlJUAR9tBXfnq8BigCrKv/c8IFjWb2RzX1CuxIputx8woIhEZG/QpwCk4kFn3HsowjMfb
	kJ4twPBcIstm2/Ex/v5XO7ivx4QTpsjmsdJeKllrKLKUCKE5S5LoS3zXvAbKABpsp/5GBs
	kDjbjORqJXXpvH9SF3yPp5nfFyRn+Lo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1699453543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8UGZhlGIm+Uwo/Wk0kWNyvqLgPEMgT9rTh9oyB61cs=;
	b=e/POFDDdG+N2SwU0jq6tOBrUSyw8xAO2SxklIVYAWGfX0+oGcgObqe/mpZQex4ZbIQ3oXO
	YLfj9D39KLiNK1Yus/3zSRbvoCGqRBOuoFdQ6IQ2i+09OWQBWWqvM483oBb2XDaU1pG0s5
	78mmwk7W6Jlb+juXsHgO/g2IRpM8y+8=
Received: from prime.localnet
 (p200300c5970AD6D80adF04972f270538.dip0.t-ipconnect.de
 [IPv6:2003:c5:970a:d6d8:adf:497:2f27:538])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6481CFA7DC;
	Wed,  8 Nov 2023 15:25:42 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH v7 0/3] Implementation of a Stateless Multicast Packet Type
Date: Wed, 08 Nov 2023 15:25:42 +0100
Message-ID: <1801046.3VsfAaAtOV@prime>
In-Reply-To: <2193621.Icojqenx9y@sven-l14>
References: 
 <20230907010910.22427-1-linus.luessing@c0d3.blue>
 <2193621.Icojqenx9y@sven-l14>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: EMQII3MVWTMQRNKPKYW36ZCD52L4RRQ3
X-Message-ID-Hash: EMQII3MVWTMQRNKPKYW36ZCD52L4RRQ3
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EMQII3MVWTMQRNKPKYW36ZCD52L4RRQ3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sunday, September 24, 2023 12:47:34 PM CET Sven Eckelmann wrote:
> @Simon, can you please also check the remaining code changes? To quickly
> identify modifications, you can use
> 
>     pipx install b4
>     # in you batman-adv repo
>     b4 diff -- 20230907010910.22427-2-linus.luessing@c0d3.blue

Sorry for the delay, this actually slipped through the cracks on my end ... 
thanks Sven for reminding.

I've checked especially against the points I raised last time. I think 
batadv_mcast_forw_shrink_pack_dests() looks much better now. 
batadv_mcast_forw_scrub_dests() is still quite hard to comprehend, but better 
than before - and good enough to be adopted in my opinion. We'll make sure to 
direct bug reports from that to Linus in any case. ;)

So I'd give for this series:

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Thank you!
       Simon




