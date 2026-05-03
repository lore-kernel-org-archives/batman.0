Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A7ECD3424
	for <batman-adv@archiver.kernel.org>; Sun,  3 May 2026 16:21:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 01C1685A55
	for <batman-adv@archiver.kernel.org>; Sun, 03 May 2026 18:21:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777825294;
 b=B9hoXNNOIkFNgN97ak55sllW4sQeE7vJbKmmSF39partqcgp4MOspRHkU+PSkj99cXtQ/
 3uGgjJj3sQr2FbVSTuxg2lCjxeNA/kPtneBiIZeNtq800sKD5XXZbpEUtVb9nUKjQmKQxxy
 j7fDNUk48P9RNGMj/0ltuDoPFXYIB70=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777825294; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jU5aJyiyfGB+51pfUmhZEIA6N0XDQb57hbB2PJcu4Dw=;
 b=qg8cGpPeIjCxHdfwnINcttc6ayzVK+YxD/TUrPrXjSMelCov76Vqmaz/pq0ELnjcd/XGE
 E3xgY+5KGpB0KvDvWFnWJcJvhzYrFSMxY2Yf/8vfXTmv6GunL/0MqFhpjo70ZtTpkd/ak0E
 37ubd9WQZBLfek7XygQ7HI2dHjmzE7Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass header.from=mailbox.org policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 74E7684604
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 18:21:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777825282;
	b=tQfQdCWw74FFqI2lkJGxidrZB6H3XcHEjcf+1/75/gmR8cBkW+c7Ui/S0Sk5I2Jt75a1CM
	NS9lHYzlnM9u+YqA8XC5LAzDDBMr0p/gWNS8fb2NPenmriEiEI3F3M3Brc7Lpj3sKsIQwX
	2Ypi1tFpuVB1GOLaN3rKziybtR2vfrQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=uHuhWnH8;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 2001:67c:2050:0:465::103 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777825282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jU5aJyiyfGB+51pfUmhZEIA6N0XDQb57hbB2PJcu4Dw=;
	b=3bskxJdYcEQDi7U6X/h1xF1VUZ4TUosfvph7/ma05Aj4UYR1gkchrrAu51XU/UV8Pyhgsf
	gm/ymDIeituyeo+le930E0snU7HSN1UtBOhyPsYc19w0ZPSod0pqla7LWNJ1DpRK5ZHN9/
	FcOt4Gvm8vBvWS6j0vw8Owt8iX/BRCQ=
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g7qlR39FHz9skc
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  3 May 2026 18:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1777825267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU5aJyiyfGB+51pfUmhZEIA6N0XDQb57hbB2PJcu4Dw=;
	b=uHuhWnH8w9jX26XIIQSUH6Z9WOfOJUdX8/ZaAuDLyzozWoDzGBM/pRGBlioeH29LPMX17t
	ppsrCiGZkbY4Uwoiam6TlPlglTFH+/Uq966LR35+ws1sFax87gAjlt6G5JU3u3NS9tGwwN
	gHzdnsffDs2iwkCjdKExD+xpvSOOaze/9eR37BemWXh/e306PMZrAxBvLBNe4T3VVcI85J
	jAkxnTypS11spDLyZQThLLAWoz2L0WLxXXQcv/ux5yMs6EN5tEPPx4OfKNYoI3md4qdGPT
	Lz6n3qVl5ym5G2E5f4ZMv73wOdYoRqjkltEXTj/WzEDRLOiBE3NSmvwRBZfRWg==
From: Marek Lindner <marek.lindner@mailbox.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: maximum observed performance?
Date: Sun, 03 May 2026 18:21:06 +0200
Message-ID: <6738959.vzjCzTo3RI@voltaire>
In-Reply-To: 
 <CAA_JP8XEx6OrY9GV3xLFfyiECZK=cuHSjxWAqFFCVbjQwSdyFQ@mail.gmail.com>
References: 
 <CAA_JP8XEx6OrY9GV3xLFfyiECZK=cuHSjxWAqFFCVbjQwSdyFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-MBO-RS-ID: 9c6a7ffe03b06812aa0
X-MBO-RS-META: dg6td34m75qr95z88n4st6sar1fgnbi5
Message-ID-Hash: HMRBBCKUP7YOVIXPR3LVGJUS62HFMRZE
X-Message-ID-Hash: HMRBBCKUP7YOVIXPR3LVGJUS62HFMRZE
X-MailFrom: marek.lindner@mailbox.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HMRBBCKUP7YOVIXPR3LVGJUS62HFMRZE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sunday, 3 May 2026 17:36:29 CEST dan wrote:
> Anyone have any first hand examples or a published doc showing
> multi-gigabit over a layer2 batman-adv?  specifically ethernet
> interfaces.  The RF layer is separate layer2 bridged and can handle
> iperf of ~2.4Gbps+ (Tachyon and Wave Pro radios).

What is the MTU configuration on the underlying interface?  Are your throughput 
streams getting fragmented? 

You can read more about fragmentation here: 
https://www.open-mesh.org/projects/batman-adv/wiki/Fragmentation-technical

Cheers,
Marek


