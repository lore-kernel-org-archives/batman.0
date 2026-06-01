Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFD4CD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 09:17:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D50B583FF3
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 11:17:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780305447;
 b=oDeotColthV/wy7xokHM3lVarNr3NjTEz1+Bvsdgr2uXQHX8Xdo3CekfBSodqB0JL7MGO
 16IYaikXIsrviuSkzYp78SXr3EIBb6p4g7N0EO9+YyAVlEaNRhJN8zVubWXKGcYJw9d3VN5
 TUit1rMITOCfDtP7RdgWb1MvO4tT90k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780305447; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=liMJDMT5500RRnLHH86u+joLoEkWNQ3ZArD6cOt1f/w=;
 b=bz5+RB6H2hrlVDheg4a6KNxWubvL9OlKeaqZRhY9XzVfkjgPYWe56DFr1FyPFo9JmxTE5
 7SGPbzIeOCqMwrs/D7A8pGrOKjipfO7snszc+rMHmsfmBL2os5QGj3fXuY4AdZmPfvTOabz
 eNYnjOnBItFa8YSdtbtZHsUPM9wrQRk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B85F280C14
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 11:16:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780305417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=liMJDMT5500RRnLHH86u+joLoEkWNQ3ZArD6cOt1f/w=;
	b=BfjrPqiPbfRoFJM6ZCvJSM7e9Ha6PckpXK0VQQ0Nsrv6LWy8Hwi1eBNuH0dpbyhEt5xDQA
	ORVeJFwnBXe9gH3UoRzgcZApVcRVzHbe7TpcVKgFmFLfE1namz7i6rTE0URDdsFEDF3fAH
	3evKNg6GMhHPR7mAATNHzvEUlzaJgZs=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780305417;
	b=o+6KfZlKL6ETn/Gxhajgz8wS9XPsAVD7AIqBnGsfMXRi82jNI8mcFhQ4LyhOn/Iw5pzJcq
	jb41ypCx68lpRjRP+1/962Blw9ie1jeenWm+eX6cTLWj+K03f4w4+0NdZ+Dw7+Pi5SBTU4
	3SItZrNxtBhBg5Co5tlUuuCFtSa/X9A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kfCJotxd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 638331FF27;
	Mon, 01 Jun 2026 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780305406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=liMJDMT5500RRnLHH86u+joLoEkWNQ3ZArD6cOt1f/w=;
	b=kfCJotxdhR+Zw1QxAxkA2M5X8P2bwiPkQdqys8hj8sSl028cN0650URvh+I05i2VkneOtk
	7+rMYp2/SyxLH9DwZu/pwQ+L+lOKda6uAUlJn2wO1Wc6Q0fFNrkPDmiXtneWaieMCz9KSp
	mNJG6uQ2u66Os7xQqAkMnuEoXjmqcpg=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Jun 2026 11:16:41 +0200
Subject: [PATCH RFC batadv] batman-adv: tp_meter: fix fast recovery
 precondition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-tp-meter-fast-recovery-v1-1-eac204f20e67@narfation.org>
X-B4-Tracking: v=1; b=H4sIAPhNHWoC/yWMQQrCMBBFr1Jm7UCSQgW3ggdwKy7SyUQj2JaZG
 JTSuzety/c/782gLIkVTs0MwiVpGocK9tAAPf3wYEyhMjjjOtMZi3nCN2cWjF4zCtNYWH5o6Ri
 CaYna6KDKk3BM3z18g+vlvG29zz4UuP9v/fQvprzFYVlWy3hFpokAAAA=
X-Change-ID: 20260601-tp-meter-fast-recovery-1c7dd03cc3f2
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=sven@narfation.org;
 h=from:subject:message-id; bh=stI3DiHrgMhMdoFVK/HMp8q0HXUnhi98tWCuNhJUcbs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmyvj/bmU1For2N8hjSF/yYeMN9h7LtMwVHG5UdEfIBK
 RkCXpc7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABPpeMzIcG2ByEMFi109Tx7d
 eiUWny0snrBzZlIye4fFZDatDnuZR4wMJ4o0/rx8/OSL3NUsNquA4l16NUVJltZBFxlvPjymbG7
 IDAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SKL3U25JUJLZHLCVWYGDWGFT7I3KP3TG
X-Message-ID-Hash: SKL3U25JUJLZHLCVWYGDWGFT7I3KP3TG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SKL3U25JUJLZHLCVWYGDWGFT7I3KP3TG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The fast recovery precondition checks if the recover (initialized to
BATADV_TP_FIRST_SEQ) is bigger than the received ack. But since recover is
only updated when this check is successful, it will never enter the fast
recovery mode.

According to RFC6582 Section 3.2 step 2, the check should actually be
different:

> When the third duplicate ACK is received, the TCP sender first
> checks the value of recover to see if the Cumulative
> Acknowledgment field covers more than recover

The precondition must therefore check if recover is smaller than the
received ack - basically swapping the operands of the current check.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sending as RFC because I haven't actually checked this in detail. See also
https://www.open-mesh.org/issues/436. I will most likely adopt it for
the "batman-adv: tp_meter: post fixes cleanups" patchset when there is some
consensus.
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index aefe7572..71655afd 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -730,7 +730,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (recv_ack >= tp_vars->recover)
+		if (recv_ack <= tp_vars->recover)
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */

---
base-commit: 761c9ff88caff7975be7a7f532b16957ecb8a16e
change-id: 20260601-tp-meter-fast-recovery-1c7dd03cc3f2

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

