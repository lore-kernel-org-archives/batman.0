Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F113CD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 04:54:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8146184087
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 06:54:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780289695;
 b=V4n190cJGBRaA5KMySWTQHCgfrY6qQA64T2oNxnLLQVcy2eMI6tsG9OFWugwWTr619SpS
 UsO17zqlrjO5pWOdipqjUfYGMQgZMC3SslXEL88qOX4aqhUyAGoWVET1vbn1IwrBjopaOB5
 qnpGGh5f9yTf8aZii9J/+LoIs1exZRI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780289695; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uy1FpgU/u778cD9ExkT0yIDmPk3heluGrlSSyb4DUsA=;
 b=PKMRDE6ED8HfUQe1HeK2V/sBqQrZS9UeY0E62A28KH77UuEN9PchMpfsZaCKW/Cx1XrGG
 V2KKOukQpmTVhy/t0XtI9/LbkViC54LrqJ/hECTHOHnCB+S0wXF7JbWXLTHMnnuot73QDqI
 mnDwAlw3sKK/PCKfsYCPhXJoRyUOWH8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AADD1810A7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 06:54:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780289665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=uy1FpgU/u778cD9ExkT0yIDmPk3heluGrlSSyb4DUsA=;
	b=Y2ER4Bv09nEp6Kjmo4c3j7Nbo+/PAOa6qMzWRPylvKD3EX53GyQPcMwMrjWn16XlhZz0SH
	GeBxvyyTIhmIeiM6adpdy/lUbDH7PesEisyAg6iJ0Lzu0wt+Y5bhXbeUwkOwhP+iizJjPl
	Rd8wBA14/FPwbMxBXMkvB7V/VKhl5V4=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780289665;
	b=tIyN+SqZllZGVDI3Hg75u/Y/4DTNZgwhefsNdueklveqbiKjbgm1A2vw3vFAkBtUz5ep90
	8ol8GlN+n+w+JS+OF2Ow69/ACWztcRPnlsKo1VQKuFEZ0s0bxidqhnH5ENoZh9/a27I/wQ
	EHf7qOeoiqv3L1U0/06VriQ4ftMf3ek=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Vex0PSyR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1EB221FEED;
	Mon, 01 Jun 2026 04:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780289663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uy1FpgU/u778cD9ExkT0yIDmPk3heluGrlSSyb4DUsA=;
	b=Vex0PSyRG6OcrOnAXiOGdMoWGEZ4Iav+S0t4/t2aHnIqKSfunkRCxwGuKr4EwY7Tp7oaHn
	W2KmmlkqnAYYiKKe2hVzMtZPWVlxg/NFx5w0Skl0VH0K1OKNaIPCNCtwM8eN3R06FXtCux
	mZ2/bLIQCcnT5PD0qg6Od2z+PwkM/xY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v5 0/7] batman-adv: tp_meter: post fixes cleanups
Date: Mon, 01 Jun 2026 06:54:14 +0200
Message-Id: <20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHYQHWoC/33OwW7DIAwG4FepOI8JG0xoT3uPaQcSSMqkkQoY2
 lTl3UezSzShHX/L/n7fWfYp+MwupztLvoYc1tgCPZ3YdLVx8Ty4lhkK1IJA8nLjydu8Rv4Rcg5
 x4TNYSzDLWQ6Ktbtb8nP42s1XNtpiXWVvv/P8Ob77qTzAx+Y15LKm7728wr7/T08FDnwgtMbg6
 DTYl2jTbEv7+HlNy95R8aicewpywc8TTQ4MKi/HniIPCkJPkU1BbYiUFsIM3V/UQZFdRTWFHBJ
 pLwSg+ats2/YDkoAFzKIBAAA=
X-Change-ID: 20260513-tp-reason-missing-f1aa51f3f374
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2598; i=sven@narfation.org;
 h=from:subject:message-id; bh=JF70AuB+DuoXmzU0ICYYsq1gqLQ2i0uFXHlt8vGyrzU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmyAhUvNj91ORfivETr2pb7h/qy68+t/LpMLZJ5p7+aX
 1TBv9VqHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJdOoyMryV+DxP4OjZCa5r
 H6TOFbbWTF2n1Zny9Ogspv4P73ydeTIZ/opXJOj1XWLUPuHkfPTc/dC90up1nOc/98XvTlJlXRW
 XzwAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JVD5WFINQKRJNRSZOPDE6IE4ZG5SCPYH
X-Message-ID-Hash: JVD5WFINQKRJNRSZOPDE6IE4ZG5SCPYH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JVD5WFINQKRJNRSZOPDE6IE4ZG5SCPYH/>
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
Changes in v5:
- drop accidentally added static (in-function) reason variable
- add patch to handle potential divide-by-zero in batadv_tp_update_cwnd()
- Link to v4: https://patch.msgid.link/20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org

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
Sven Eckelmann (7):
      batman-adv: tp_meter: keep unacked list in ascending ordered
      batman-adv: tp_meter: initialize dup_acks explicitly
      batman-adv: tp_meter: avoid window underflow
      batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
      batman-adv: tp_meter: split vars into sender and receiver types
      batman-adv: tp_meter: use locking for all congestion control variables
      batman-adv: tp_meter: consolidate congestion control variables

 net/batman-adv/main.c     |   3 +-
 net/batman-adv/tp_meter.c | 727 +++++++++++++++++++++++++++-------------------
 net/batman-adv/types.h    | 145 ++++-----
 3 files changed, 506 insertions(+), 369 deletions(-)
---
base-commit: 80ee59dc80a8d6287b2af80dad4e7e1c04d3a2cf
change-id: 20260513-tp-reason-missing-f1aa51f3f374

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

