Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C59C4332F
	for <batman@archiver.kernel.org>; Thu, 14 Dec 2023 02:02:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6C8C282F1D
	for <batman@archiver.kernel.org>; Thu, 14 Dec 2023 03:01:59 +0100 (CET)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1702519319;
 b=L+gQ32h8wtPXnVSAjyrT6zmHudUW1SfGAMqlPlOTYJMgZAn3yeFKNe+gXrOI2WvG3/1MA
 +IKQf2A9F1vqGhGwT9Sy2i0R8FYPElVELo2cor4HuyzjeCzWGIfrAo0MsAexYdyOXXdEljH
 KazIn3DSS34ajuXpoYH5xYrgsnxvqUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1702519319; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jd0fEGQsO+2FYBpyRo9s5bTEudDW4VnHVhOc1yeAlEk=;
 b=onyA0P9C38K29yPd8nEenbPCrHEGy2xrkuJRVERy4oeYs2iL4t11m3Z/eedC1Bp15oAg/
 XtChRNmT3eFEg7DKOQAnof2ae6B4qiyJjwQ+hd8jRsGqVVk1V+eOsbEUFOserd28HrLFCau
 SSfy5O2diwLh7gdTXv/e627TOr/1sWk=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=proton.me
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=proton.me
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 42F3F8043B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 Dec 2023 03:01:54 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: bat0 not capable of MTU > 1500
From: rchase47@proton.me
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 14 Dec 2023 02:01:54 -0000
Message-ID: <170251931426.1041.7429353828197989407@diktynna.open-mesh.org>
In-Reply-To: <1979998.CrzyxZ31qj@ripper>
References: <1979998.CrzyxZ31qj@ripper>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: UVWG4C3D7WTK56TSGHOTBLMXZLSZ6LK6
X-Message-ID-Hash: UVWG4C3D7WTK56TSGHOTBLMXZLSZ6LK6
X-MailFrom: rchase47@proton.me
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UVWG4C3D7WTK56TSGHOTBLMXZLSZ6LK6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Sven,

Amazing. I applied your patch (applied cleanly to 2023.3), recompiled my firmware (I had to modify the package to use 2023.3, and to exclude outdated patches -- your jumbo-frames patch is the only one I applied), and so far it's working great I can see that bat0 is able to take an MTU of 1504, which is what I wanted. 

I didn't try to violate the MTU "space" by reducing my hard-if MTU, and I don't use NC or the other suspect cases you suggested needed testing, but I'm willing to give back and try some additional configurations, if you can give me a list of test cases (and what you want to see).

Thank you so much for maintaining this project, and for your prompt and helpful reply. I'd love to help close this issue, as it looks to me like you likely have created a good patch. I naively don't see any likely reasons why it won't always work. The logic seems right to me.

Respectfully,
Rich
