Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E63CAC5B0
	for <batman@archiver.kernel.org>; Thu,  2 Oct 2025 16:39:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1AD51847F0
	for <batman@archiver.kernel.org>; Thu, 02 Oct 2025 18:39:24 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759423164;
 b=g82fc2OKb3p719YV1DMgZZ2VbHaxilawzF8RgaJhryFDV1EMkDHq+W226ERt2PwiBeWGj
 ATIE9tnLrT8ofIk1HJLtII/S/6Q+3nQdMg3KgoWfPfeynOc+ZvpLzFwtJUaMgyDTb4BETAX
 k09u5WWXFMCWLCJo0dEnVU0bpWt+rto=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759423164; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XkC4zU//s0rJlfPd9EDTc+E81Gz+qmOuchMTuCmYdb0=;
 b=P7JZSd17HPUeHc2DRYxYrfuw25T8HOiOmFsemaQDVVD9duUHrY3PxMskD0iFj0kHLHXux
 Fij9Q8+fpmNdIrzbjzHBcWlxFFK4H47+laQhH3qpDbHKEaMjLaA7ajNOOqohyjIuj5uKmZ5
 L6Vv7qzngykL6+E/JBn37DR+tmDRPgE=
ARC-Authentication-Results: i=1; open-mesh.org;
 dkim=fail;
 arc=none;
 dmarc=fail header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5D8BC8074C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Oct 2025 18:39:14 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: =?utf-8?b?2LTZh9in2K/YqSDYp9mE2KPYqNmI2Kkg2YHZiiDYp9mE2YXYutix2Kg=?=
From: jibl3azzmenusa@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 02 Oct 2025 16:39:14 -0000
Message-ID: <175942315438.1531.12295323852545158485@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: U2QF5ZFMW6UGLBLGESNCEMCFPIDWFJ7F
X-Message-ID-Hash: U2QF5ZFMW6UGLBLGESNCEMCFPIDWFJ7F
X-MailFrom: jibl3azzmenusa@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/U2QF5ZFMW6UGLBLGESNCEMCFPIDWFJ7F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

شهادة الأبوة في المغرب
