Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B2606A6B9
	for <batman@archiver.kernel.org>; Sat, 28 Nov 2026 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=mjCl4xiS
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A48F8841F1
	for <batman@archiver.kernel.org>; Sat, 28 Nov 2026 13:40:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795869657;
 b=pjl7XB0GpBBEL7Ex/feqGl2Xfmyk1ySrc+uYGryR+m56wAEdUuI8tcH7KxlZXY2eQoTgX
 GHWe0L6dGD0H1U3poVuPDHkA2GWcAO9MosZClCzfndSh8ulh/pA2ro1/5IuvevVyjne8N+K
 6CKMaYfRoJzwCULATbqCPaEhSZYPFkA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795869657; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ujv1kSfTTgCoyDmTvMc6PP6R2VbjCFSCsTF85WvCzUI=;
 b=K/Fl4XnxLwLScS9eB0tz1HoT27aiq1Y5Dbi953eqtdDm0/xdt/rG0YqmTY+cMjggTBB3Y
 xwpj56k5c76hQTlAgLqQdya2iW8h0GVtesg8JqoLHDinq5iTIt2QfD3orRuZQWRu/r1UsB0
 0d7+V1bojMwtd/dF4zoeMn8QfxKO1Gs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E74BD80816
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 28 Nov 2026 13:40:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795869650;
	b=zN/Ygg4ub7BEWqyUENeoCpKZ4NdRsmH+YberKr0+peDtD5ZqaGTzIus9D4fYwsAPECFqFK
	T3Rb2XYdSz2CPtcGWwTLjohbccuAPAAgxvuSDvuGzU1UWu7WjrAga63u8jaEAFjixjVNsg
	bv35lMUmOmZ4eFBOni+EwOgJYtj/104=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795869650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ujv1kSfTTgCoyDmTvMc6PP6R2VbjCFSCsTF85WvCzUI=;
	b=MloRwRM4XJS49pNZL+YIEidNfU/ER2sSPO2hV85wCsg55IxsZ6ya0Ho1jeCg0sCc4mf5hT
	2+zFgA5kJGKb/DV2QrRd0eQivWo2Dx8DK6wsvm3VviA2tPLFO2o1JUl7u8NnIzIqCyvLB+
	cGMfrEC1sAG9DtD1xrcFZOo5aQMPyqg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mjCl4xiS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 19B551FEC4;
	Sat, 28 Nov 2026 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795869638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ujv1kSfTTgCoyDmTvMc6PP6R2VbjCFSCsTF85WvCzUI=;
	b=mjCl4xiS29UJryXGCoXSu/Pa35tZ4MYNgs7319/drXou6FsXu6KpyVhbaBfztGK0DohgKW
	4nme6AFwMK3FOVn/v+vqCWS1MCDZVXbuv4USwFA3bfEucvqyW2WvICEqKiD4yVqylYXpvc
	y/7ln2O2Tm4hu9IQ03kEfQdkMZY6h0c=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 Nov 2026 13:40:31 +0100
Subject: [PATCH batadv] batadv: tt: fix return value of batadv_tt_init
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-tt_init_return_value-v1-1-9272a496a8be@narfation.org>
X-B4-Tracking: v=1; b=H4sIAL7LCmsC/yWMQQrDIBAAvxL2XCFKsZKvlCJqtsmGYsu6SiHk7
 7XtcQZmdijIhAWmYQfGRoWeuYM+DZDWkBdUNHcGMxqrtXFKxFMm8YxSOfsWHhXVZbTozja56Cz
 09MV4p/dve4UYJMwNbn9fatwwyfcJx/EBjqUJV4AAAAA=
X-Change-ID: 20261128-tt_init_return_value-706e846c8b86
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=sven@narfation.org;
 h=from:subject:message-id; bh=FTOqub/FdcvFzVM3OpKurr5v+0tNCGLWSt+ziZAcg+I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNlcpw8pGdx3uPfQ5NiS+ONpT3M/7E01y+P+LHY7+BDTl
 qlOSTN1O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATmWrNyLDOd13dnISau41Z
 ESwmU5s7L71QSPxfI/7u39duKe7J37wYGbYfnWt6NsWK++wUPiGhLNO63Z8lN1xWtKi2fX8lYeq
 yEmYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MYH73GD7VMDTZ2RRE52DKAVZYFNSDJYB
X-Message-ID-Hash: MYH73GD7VMDTZ2RRE52DKAVZYFNSDJYB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MYH73GD7VMDTZ2RRE52DKAVZYFNSDJYB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel-doc document a return value of 0 on success - which the code
contradicts because it returns a 1 on success. This doesn't change the
overall behavior because batadv_mesh_init() only checks for negative error
values to detect problems.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e08bf88b..eb9bdffe 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -5461,7 +5461,7 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->tt.work,
 			   msecs_to_jiffies(BATADV_TT_WORK_PERIOD));
 
-	return 1;
+	return 0;
 }
 
 /**

---
base-commit: 11431b38d0cd787a2e988416e7086dc1cf225055
change-id: 20261128-tt_init_return_value-706e846c8b86

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

