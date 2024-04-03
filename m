Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32B7CD1288
	for <batman-adv@archiver.kernel.org>; Wed,  3 Apr 2024 12:56:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E82AE81AD1
	for <batman-adv@archiver.kernel.org>; Wed,  3 Apr 2024 14:56:38 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712148998;
 b=YALSEpbMbE/JzQilRJB6DMzCPM+Nq7gacnbNnzkDwG5d4RMIJW1qpKA7eo0Cu+FxyEx6R
 VPGI4ZABo5LP9iNnWrajJAE8HMrRNaPbjfNAvsZYGK7wmOmV/gCicfzi2kuVimHp4JA4XaJ
 x0gpAPV2gnFTcLTx8oN3Xibv8molXCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712148998; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aYD8zGpzHjdK3D3Xpok2JV+7zN6UFyXMqxaCH1ZPQkQ=;
 b=eANXlTHYzfi5rTRo9ItX24+YjBxhuXf8JdwxwtqPkm2RH1awc5lueuaQI8tr5fFjcHYLy
 kyC21c5/Q4qzBrf7y53pL7tMYGgiroQsqGgCZSpU6POmwz/E/md3gQU7hYCKV37Keh0lqHr
 +5/6iUAnntQXQDCvUzgjQtiU+T3vxfg=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=protonmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=protonmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DF2ED8022A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  3 Apr 2024 14:56:31 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: About Throughput in BATMAN_V
From: berkay.demirci@protonmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 03 Apr 2024 12:56:31 -0000
Message-ID: <171214899190.1066.4170379207726418942@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: JUA4VDB2NIDVEFXYGCTAR7EVHWQJ6KFM
X-Message-ID-Hash: JUA4VDB2NIDVEFXYGCTAR7EVHWQJ6KFM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JUA4VDB2NIDVEFXYGCTAR7EVHWQJ6KFM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

I have a question about Batman V's behavior about throughput. Batman doesn't seem to calculate throughput properly so we set it manually with throughput override, but then even when actual throughput of the active interface decreases, it doesn't switch to the other interface because it only considers the overriden value.

It only switches when the active interface stops receiving OGM's completely. I think if throughput was calculated properly this wouldn't be a problem so i want to ask why it's the way it is. Batman already has a tool called throughout meter, shouldn't it be used to continuously check the value?
