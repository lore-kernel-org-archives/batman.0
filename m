Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F4C43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 19:21:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 064A3853C4
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 21:21:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783452061;
 b=mlevlxc4hvB3X8/cWo+nrtf4YyC3Ydv9slp4+RIkJa7OFZhWUCBaTwZlfjLJPA7jISUlJ
 8U6Ubd8aab3mEqf6BraMW/9yO6VpKWa09cZQLsYNfgr3kVz8CzqOo+WRmpCNwttdJ0nczNr
 fE01nh/oH5va+/54iaP0cXvlwdQe9CA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783452061; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8WbFQzsnASkb3oaPa/TaO4kNLVZifbOFlOOZDSFZP7g=;
 b=KVsTN5yCfnfld+tipjYaigKno2duZzhjR1SP/nb00j9b08LBQ6PHu5DkTQ88CZO+ECxwV
 n3mcCvzI3A/rTI0fU3bhzsEFXLYjF/mmW+Ke3bqwoYVBXMEEJ0UN7M98MXahYwAgG3FBGD0
 zc6TCY5RpsRiIXSUl52R9mIhkrj6q34=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AA0E3846A3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 21:18:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783451882;
	b=39zN0yBuorKcfic/rM6HAt421G/y/OjiaGsFx9U5C5CzVTIuOJlUSUGFVimHFzgIDHcu7F
	JKFidDiOIKKXXfE9189U2Syc++eVEB/WBolROGmGjW6olPcd+HzUlEbceIUGtUzk/6raqq
	FCN5ub/6F21f1i4nKxcDj8jw6lXAdiM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783451882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8WbFQzsnASkb3oaPa/TaO4kNLVZifbOFlOOZDSFZP7g=;
	b=iU9bHFEOL4+BR5lqPcms/ue2iuGaVTN3le9aHuAp3Tggm8XPOaKzpBX7Ak+L0prdp6uK6p
	sLdC3boZypSlF1Rt5ZINhCg6PxpLmFcicUk29yE1K+T+xgupRD2SMGEgwVF68MOapDgknm
	OqdtRLHfCZmNqnFJQ/khMBU0+Ad/A8I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fxIodI6E;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0DCCC20442;
	Tue, 07 Jul 2026 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783451882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WbFQzsnASkb3oaPa/TaO4kNLVZifbOFlOOZDSFZP7g=;
	b=fxIodI6EE2Dn2kO62Lfiz3YS0llPN3LvATKnWFp6yzXTaAzS+CPLDLh9nPdXNEJQDsYE1U
	IFdwzDb76w9olFlUQJgBsLB6GKpEsLwTxOq8Uyhzvwgp9IDZWD1NvpEPA8MJE51cQQgDbE
	sW0Qz6qmW0m4jIwSyB7Rp07YMZUGRb4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 21:17:04 +0200
Subject: [PATCH 5/5] batctl: tpmeter: don't cancel test from the signal
 handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-tpmeter-v1-5-78d96fb7b36c@narfation.org>
References: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
In-Reply-To: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=sven@narfation.org;
 h=from:subject:message-id; bh=cWO+vPlTb08ylkak6OYCudyfbWzQRYHw3mvFVoojgKE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+Aeu5HcRD1e6o8x5t8FxxesVLjovT/CQOu8YoBM354
 3lu8my2jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEzLIY/ufZev3R9noVHtNz
 4d3/mvmbz+vNakg0tJk9OeOxYrVV8DuGv0J/5uQ4aZ7MXF26SO/1j+KZwjd3/P6z9+kNH3PjM4v
 U+BgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KT7S4EHX4THJNF5BSIG3ZR5OLYWXG4CW
X-Message-ID-Hash: KT7S4EHX4THJNF5BSIG3ZR5OLYWXG4CW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KT7S4EHX4THJNF5BSIG3ZR5OLYWXG4CW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

tp_sig_handler() calls fflush() and tp_meter_stop() directly from signal
context. tp_meter_stop() allocates a netlink message with nlmsg_alloc() and
sends it via nl_send_auto_complete() - none of these functions (nor fflush)
are async-signal-safe.

Let the signal handler only set a flag. tp_recv_result() now waits for the
result notification with poll(), which is not restarted when a signal
arrives, and sends the CANCEL request from the main flow before continuing
to wait for the (then canceled) test result.

Fixes: f109b3473f86 ("batctl: introduce throughput meter support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 throughputmeter.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/throughputmeter.c b/throughputmeter.c
index 6799c93..dbb88f6 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -17,6 +17,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <net/if.h>
+#include <poll.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -34,6 +35,7 @@
 
 static struct ether_addr *dst_mac;
 static struct state *tp_state;
+static volatile sig_atomic_t tp_aborted;
 
 struct tp_result {
 	int error;
@@ -194,8 +196,15 @@ static int no_seq_check(struct nl_msg *msg __maybe_unused,
 	return NL_OK;
 }
 
+static int tp_meter_stop(struct state *state, struct ether_addr *dst_mac);
+
 static int tp_recv_result(struct nl_sock *sock, struct tp_result *result)
 {
+	struct pollfd pfd = {
+		.fd = nl_socket_get_fd(sock),
+		.events = POLLIN,
+	};
+	bool cancel_sent = false;
 	struct nl_cb *cb;
 	int err = 0;
 	int ret;
@@ -207,6 +216,23 @@ static int tp_recv_result(struct nl_sock *sock, struct tp_result *result)
 	nl_cb_err(cb, NL_CB_CUSTOM, tpmeter_nl_print_error, result);
 
 	while (result->error == 0 && !result->found) {
+		if (tp_aborted && !cancel_sent) {
+			cancel_sent = true;
+			tp_meter_stop(tp_state, dst_mac);
+		}
+
+		/* wake up regularly to notice an abort even when the signal
+		 * arrived outside of poll()
+		 */
+		ret = poll(&pfd, 1, 1000);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			break;
+		}
+		if (ret == 0)
+			continue;
+
 		ret = nl_recvmsgs(sock, cb);
 		if (ret < 0)
 			break;
@@ -295,8 +321,7 @@ void tp_sig_handler(int sig)
 	switch (sig) {
 	case SIGINT:
 	case SIGTERM:
-		fflush(stdout);
-		tp_meter_stop(tp_state, dst_mac);
+		tp_aborted = 1;
 		break;
 	default:
 		break;

-- 
2.47.3

