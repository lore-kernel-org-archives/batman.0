Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCA2C4345F
	for <batman-adv@archiver.kernel.org>; Mon, 15 Apr 2024 18:27:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C034981D63
	for <batman-adv@archiver.kernel.org>; Mon, 15 Apr 2024 20:27:12 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1713205632;
 b=CFmH+2lPOSstynZwk30mCUXIjCdA6Kn3ajLgHL6iTmMIvs5YlyiCzGj1yGBkG6fKbi612
 f5AV3xlUxkMMzbDXHCyZ4ykvyWANWBsFNM6IRKnGSAtUJczXNmg5NfR4+1H4JYdqOC/DPjL
 5nACT8VwTUqNz4lp/BF/0oeTj7/gRAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1713205632; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6lYyPVp/8yWrNP8+BKGJLMCDYFzz3z7YEQLSDcB7bFQ=;
 b=ukjO5reBxDN8n8DDQZ2G0YEJMe9xq8RgbGGf50YuA2KkDo8FMVsff4FaCtUz1Zfv6GPra
 oLWJ3rWgDzSGyU1OoHmna+witA0i6ZPnfWd2FWqelt+4RG3wCqqO39wMduaNmcpLsC/z0Ii
 y5ujrdDjovLWSaXNX/5Tt0qim6bbuM4=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=protonmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=protonmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 88F15800F4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 15 Apr 2024 20:27:00 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: About Throughput in BATMAN_V
From: "Berkay Demirci" <berkay.demirci@protonmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Mon, 15 Apr 2024 18:27:00 -0000
Message-ID: <171320562055.1045.7722851624364822679@diktynna.open-mesh.org>
In-Reply-To: <1921320.Bm8zEkEi59@rousseau>
References: <1921320.Bm8zEkEi59@rousseau>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: TJQMWKTADBCKMWXNGUSPXICJAREFY27N
X-Message-ID-Hash: TJQMWKTADBCKMWXNGUSPXICJAREFY27N
X-MailFrom: berkay.demirci@protonmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TJQMWKTADBCKMWXNGUSPXICJAREFY27N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Just to try different combinations to see if it made any difference, like could it maybe switch earlier. But either way, only when OGM's stop reaching node 2 in network 1, does it switch to network 3.
