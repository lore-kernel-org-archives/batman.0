Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA152C0015E
	for <batman@archiver.kernel.org>; Wed, 12 Jul 2023 12:18:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1B1008230D
	for <batman@archiver.kernel.org>; Wed, 12 Jul 2023 14:18:44 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689164324;
 b=W3CWUXj1v+gKThweZ0169Av3BvLBzeqXkk0NnhG8ddOOqv3jcGmHf8u/YFdpyRBvte/29
 n0GN99qWPq1iThrDn/3UHOMOxL6wJFM6wQ0MSRHLpUSE023BVxtvIBiAbdkJYemirJ3mLYR
 ZhyyHnPb+PL/cUPt/40ah0oJncTUeDg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689164324; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vJr4cpGGwdddE6zNjzVAzDHzgM+zBO70xy9MS9lOZ+U=;
 b=AepBSrVtvQRsiyrMdu3yjyH8Fwh3Syi4egDPLMR2ATuuxhPkhY3kUfXy+RPCE96bGKyLu
 UzF57fYEE6uENLx2wIpkglEdgJyqqnF72r/NQz6pmA5Trm7qzr0tgvZ9yS7QZ8L4CjJAO5f
 IN/tsLDB3nuHU/UvbyKnWBqef9cEFeE=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D25BD80C32
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jul 2023 14:18:14 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: Using BATMAN over ppp interfaces.
From: "Peter Milani" <petermilani80@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 12 Jul 2023 12:18:14 -0000
Message-ID: <168916429485.1040.15229763759954264535@diktynna.open-mesh.org>
In-Reply-To: <10972843.BaYr0rKQ5T@prime>
References: <10972843.BaYr0rKQ5T@prime>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: QFSVHD2FB62EFBQT2XLHSR5RCBNJBENR
X-Message-ID-Hash: QFSVHD2FB62EFBQT2XLHSR5RCBNJBENR
X-MailFrom: petermilani80@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QFSVHD2FB62EFBQT2XLHSR5RCBNJBENR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thanks Simon,

So to clarify, PPP relies on a higher level layer than what BATMAN uses? So you have to create an ethernet layer 2 interface using l2tp. But are more or less restricted to point to point routing in that case which l2tp will be travelling across.
So there's no alternate method you're aware of that can make use of the general broadcast nature of the underlying radio... e.g.. from an application perspective, I can transmit a serial message from one radio and pick that message with multiple receivers?

cheers
Peter
