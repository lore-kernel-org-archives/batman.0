Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAB8C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 15:56:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96FB483B1B
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 17:56:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783267004;
 b=gg1vf7GbeXwLzSsQphZbSwhmk56iD7tsaxy6OM0Qmprlrg2yYsN5c3UqIFColKAK4UDFG
 6kdijv2D4P3jTIS7GKhpVCx+YmpyLFG8MsPYDBvPR4k2/7S4U8C0XmUfLI0L9v95d5SpunX
 7v+TkLV2dgsD1r99evUWhbmDu3299Do=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783267004; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m2MvIrFC1JWM962Nn0sDBtutlrYF4V2CQxPKHmsj+zw=;
 b=n9XZGc/ukmkrW3oDYLUCY0ZxF7r/d3oeNlqHXR0rP40ntONlXeZgBlpS0M6ltDvnbkoR0
 Y7OfGuZF4FuDgvZjdvq/v890Vufte251Cel2TUG7r+yDAhdJVb04UkgJ7An8amWy+OFVrqn
 Uyf1Ur0GIRKX0NP8lkGV2YD+UfYfKwg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 89029810D1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 17:54:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783266856;
	b=cMk5Z4naKuGrgq/lqEtchmrbOBkUGmKGPDGgWhetqIXq9tiSpGBgTivWtUVE7ujRxyZSnd
	ikxuKaoKgFSAIGZPaHMLtf32KhLNFJsplI1ZzkwSZTuWDSjAlzk9qQxBCaZcCQLg2Sekl1
	3w6acl5pwPqzORt4S+ZbXG9e8tLNdMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783266856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=m2MvIrFC1JWM962Nn0sDBtutlrYF4V2CQxPKHmsj+zw=;
	b=top8PAfnaNE0g4exs8jr1bm1B5QuC1KRLk2bBXD3fOKidQ0k32TaB+2jRx7ErzniBraIBk
	UO1pfB3Mp0ssERs1i3ICRQu+DYQjQgG2XgtRKnDcmZXj2UNl5HRDbyCU5827CHSDd7I7+I
	C/mCqtWfOZBSNpeaXJWCdcJm5twyhno=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0K2iysPj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C55D6203F3;
	Sun, 05 Jul 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783266845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m2MvIrFC1JWM962Nn0sDBtutlrYF4V2CQxPKHmsj+zw=;
	b=0K2iysPjTuwXKN29mTzzkMyZWXBYNma3mOaT38/4KVSfUrLGH1HjC2wBovM7ROT7kahy8W
	sO7eJf904a/ODOx6WppliBHAjjNgT8ebd2qscYAiFkP0irRdkp5ARay5nYeofVu/Hm4twn
	YqSstQACpYUT2d4PnrL0j1QhlTFKcyk=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/5] batctl: genl_json bugfixes
Date: Sun, 05 Jul 2026 17:53:34 +0200
Message-Id: <20260705-bugfixes-genl_json-v1-0-8cc79129012c@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP59SmoC/yXMUQqDMBCE4avIPjcQbY3gVaSUJhnjikTJNqUg3
 r1pffxg/tlJkBhCfbVTwpuF11hQXypy0zMGKPbF1OjG6E7flM1h5A9EBcTlMcsalfFXA9t67Yy
 nEm4J/0nphvtpyXaGe/2e6Di+t4t6wHYAAAA=
X-Change-ID: 20260704-bugfixes-genl_json-6d36eb5d0c6d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=sven@narfation.org;
 h=from:subject:message-id; bh=b87Q4V2slIrjL7ptZy5iXUv+i+PglKAvY/PSizbBJNU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFledXznjz84tsqX20zGT/W329ZZ7dtT0+ODs/cxOpz/G
 sk1ldm1o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARxTkM/0MfOT5J8pX9+4Wx
 +8HRDRuvmx2fvUzqxEWRRR/O1shoHPBlZPiyQCZV6b77QqGTG5a2X/fWnt17xuJjwnvFVYUssxh
 uTGYEAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CT3ZXU2RKW7UQ6B47JNDY3J57DUTLIBY
X-Message-ID-Hash: CT3ZXU2RKW7UQ6B47JNDY3J57DUTLIBY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CT3ZXU2RKW7UQ6B47JNDY3J57DUTLIBY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I have now splitted the bugfixes for batctl in topic branches to make it a
little bit easier to review. Similar to the "random bugfixes 2026-06-21"
patchset, they are just various (mostly minor) problems which should be
tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (5):
      batctl: genl_json: avoid negative chars in sanitize_string
      batctl: genl_json: reject unknown options in handle_json_query
      batctl: genl_json: don't return negative error codes to main
      batctl: genl_json: escape non-printable characters as valid JSON
      batctl: genl_json: drop leftover network coding log level

 genl_json.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)
---
base-commit: eb9597d4ca6db17c579f5ae9443c51b013e2fe65
change-id: 20260704-bugfixes-genl_json-6d36eb5d0c6d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

