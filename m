Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D870AD63920
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 10:30:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DD2783E52
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 11:30:46 +0100 (CET)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732098646;
 b=I2APIS0IeglQmTZa/qMewoXEbzRV889WJeEM5NgLQGcKVnI7FHIMKPW6SXAYc9R3dxZMK
 ySLXQoD9GWXMrvqaFnIsgfA7dXgsAM5fiPRuuFecO+Xvxlf04sORNpUUOiUJ/iMMiY97P96
 ewCjLltbEGYZb7JrY3tOkYW1/b++Vqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732098646; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=81ELSttuwjl5nn2LlybQYeZJZhWhF1coDFq+jCEsCyc=;
 b=MSmJugXahO4xHBkCQ4i0s35vwmwy84T9nqq3VmkdhCscLbzFsshrZNRJGGnYW/LCQ2Ezy
 AjQepcb3HorYklG/iL7yGuYvEYutbMbUJNAE1WFcittoQnX1m0Zr0k6HL21VukqTU7kW4kj
 EbfNKQnUoWorSUIfM74IgjyAWq7ZJkk=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0929482600
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 11:20:32 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: IP connectivity issue at openwrt nodes
From: soanican@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 20 Nov 2024 10:20:32 -0000
Message-ID: <173209803202.676947.2161146905253530996@diktynna.open-mesh.org>
In-Reply-To: <6133886.lOV4Wx5bFT@sven-l14>
References: <6133886.lOV4Wx5bFT@sven-l14>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: soanican@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: Q47SMN6LWYMBQ7DD3RFHCO2NWGVLS6BB
X-Message-ID-Hash: Q47SMN6LWYMBQ7DD3RFHCO2NWGVLS6BB
X-Mailman-Approved-At: Wed, 20 Nov 2024 11:30:23 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q47SMN6LWYMBQ7DD3RFHCO2NWGVLS6BB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

You are right about frame format. Most probably, while converting from 802.11 to 802.3, source MAC address differs so batman is not working with WDS. (can not recognize advertised interface MAC address??)

Now, packet performance  issues arise. I suspect on MTU, fragmentation related issues through cascaded/nested structure of bridge/bat0/link system. Will need to dive into monitoring/capturing (as you also mentioned) this system.
For example, streaming continues for a while and then stops. Simple restart of networking system solves the issue. If you have have a clue, it can help a lot. I will consider opening a thread for this.

Best regards,
