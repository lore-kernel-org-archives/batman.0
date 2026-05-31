Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB7ECD5BD1
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 08:33:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9F66E8421F
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 10:33:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780216426;
 b=BhxDvNnqSgp8kGcYQH48dyYojy5zcWmfOUSwqPfhPlkk6WfQ2nGTx/kYVXKgoEcCd2k5g
 YIMAKLvqGLkRKjPmswD4IYh2XyMP/U2+6+XR1TjzrM1+KRGsF6jbwzCxl842Gt1Ac++73uS
 EVSdHCLzxU4ZPAy+eFFzc9/qM3McET8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780216426; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1BRrqqIgSVGv5iLWhlzLyQcQyif02bKPhWK7oTap8lg=;
 b=auijUcAaz2AzxDCDjwI0gNJ210loin2z9tUn0QBmfistXS/+c7ouiFzP72pNFtJKRnh6T
 6isQ3lZZIQXS2M98sVTJQn1ok+5hGefLFmNM6wykekIrNmaR4oK5y6KU2GkJ/+lFv35KBj2
 3k0sAjE/19+gdXEZFHDbyvyWkbtGack=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D38A5821AE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 May 2026 10:29:18 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780216168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=1BRrqqIgSVGv5iLWhlzLyQcQyif02bKPhWK7oTap8lg=;
	b=fEHHSw6BXIF5ZACrBUmYYQfLlu1EYRLCk69EwyJODUmCIGjODmIxNOk5rxYMPPE+Nc0Dr9
	Tahyh9zyZq+kFjOSWcGR+hZNHMBZRJ2DSbAUDYQ//lIWHPwjP3CnNtZMXV8PHFh0iRqy0s
	JkLRfX3pMJiNSspDOJMHDNIn99XRd4c=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780216168;
	b=b4WF6utOa70UJG/f3Tkf5VGrrHjQTwllweKFs/Xnk4wgcs0zJ6Tvt6gOphNA9Nz+ogWoDj
	SeBlVng0ivownsBnJYEYGdsXU4qYXxrzmOLDUlfQbmT7AaYp4lIwIyWjGaP6N46MzmAAXr
	B8ElcXFx/3F2NlM4DmfqOrv9k9aMeN4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=h37IJqps;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CD1981FD9C;
	Sun, 31 May 2026 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780216156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1BRrqqIgSVGv5iLWhlzLyQcQyif02bKPhWK7oTap8lg=;
	b=h37IJqpskLqun4z7DYz7SBSiTRyP4H1bOd/VlPbPm19t4jgb3f+f/4Fu3K1PlWwFz2MU2U
	V5w3Ic4fkbpU5oP0+/l4AulIlSMLQyM91zIRLPtjP4t6Gt/bYknDR22r8UaCNUeGsKwdiH
	DAtPEwF5PNP1JPq3U5Gi8zG/RqgFSHY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v4 0/6] batman-adv: tp_meter: post fixes cleanups
Date: Sun, 31 May 2026 10:28:50 +0200
Message-Id: <20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAELxG2oC/33OwW7CMAwG4FdBOc8odpo2cOI90A5um5RMWoqSE
 DGhvvtCd0Gi2vG37O/3QyQbvU3iuHuIaItPfg41NB87MVw4TBb8WLMgSa3UqCBfIVpOc4Bvn5I
 PEzhk1uiUU10j6t01Wufvq3kWPWcei/j8m6db/2WH/ASfmxef8hx/1vKC6/4/PQUBodPExlA/t
 sinwNFxrh/v5zitHYVelcOWQiDhMOhhREONVf2Wol4Uwi1FVYVao3XTSmm6t1+WZfkFur6gM1w
 BAAA=
X-Change-ID: 20260513-tp-reason-missing-f1aa51f3f374
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=sven@narfation.org;
 h=from:subject:message-id; bh=Me1z+9nyw11t1Ufr2ByQNrydoDs1roMMmjQ4yQuGyHo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnSH8Ot7t7UONdybENt+rzDzOyMrslWVVIdLZcXv9TLO
 3muKNmuo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCR5ZMYGSYFTDjDuEXv0bGV
 15aw2sV0Z4a8lqvSzF/uK/LfzTkzIJ3hn6X7mYUqP29/mMM296uuTMKE414GS9aEH39ffvWG1s9
 tXxkB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DNUUBDCCKBHXG2ADCZHLGXOHNXHXNAH3
X-Message-ID-Hash: DNUUBDCCKBHXG2ADCZHLGXOHNXHXNAH3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DNUUBDCCKBHXG2ADCZHLGXOHNXHXNAH3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

After most of the problems regarding the role confusion were fixed, we
should use the opportunity to split the variables completly. This can
prevent some of the confusions and at the same time reduce the memory
consumption significantly.

Since the sender variables are separated from the rest, also clean up the
congestion control code. Make sure that everything is in short blocks which
ensure that the reader is aware of the locking and the results of the
calculation. Which also means that the actions (sending) are extracted from
the congestion control code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v4:
- rebase
- add patch to fix unacked_list order
- add patch to initialize dup_acks explicitly
- extract batadv_tp_avail fix to separate patch
- split congestion control variable patch in "locking" and "structure"
  patch
- Link to v3: https://patch.msgid.link/20260521-tp-reason-missing-v3-0-26855460087a@narfation.org

Changes in v3:
- rebase patches
- fix receiver cleanup "put"
- add patch to cleanup the congestion control locking
- Link to v2: https://patch.msgid.link/20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org

Changes in v2:
- fix send_result kernel-doc
- rebase patch
- add patch to avoid role mixup in search functions
- add patch to split sender and receiver sessions
- Link to v1: https://patch.msgid.link/20260513-tp-reason-missing-v1-1-752a882bd61a@narfation.org

---
Sven Eckelmann (6):
      batman-adv: tp_meter: keep unacked list in ascending ordered
      batman-adv: tp_meter: initialize dup_acks explicitly
      batman-adv: tp_meter: avoid window underflow
      batman-adv: tp_meter: split vars into sender and receiver types
      batman-adv: tp_meter: use locking for all congestion control variables
      batman-adv: tp_meter: consolidate congestion control variables

 net/batman-adv/main.c     |   3 +-
 net/batman-adv/tp_meter.c | 724 +++++++++++++++++++++++++++-------------------
 net/batman-adv/types.h    | 145 +++++-----
 3 files changed, 503 insertions(+), 369 deletions(-)
---
base-commit: 80ee59dc80a8d6287b2af80dad4e7e1c04d3a2cf
change-id: 20260513-tp-reason-missing-f1aa51f3f374

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

