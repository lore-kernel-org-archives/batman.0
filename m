Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30FAC5516D
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:20:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2A0B583FBA
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:20:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785439237;
 b=O9QVBU5cmH7kAeARvripBWrsnGrWW22Wi7QRbkehx3hTaT+uBUEn4QMV2PX1IuAADLy10
 +OR4wkBbq+SMF/NLiv4pVteiaDxxGXUytJUvHrIsEv14H0lmYY6oC67gVodeLck9IyPhaKZ
 yZ03AwuuCvKURFinMAQFvg4aFgUdYLQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785439237; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Moof/ql17TMpK6RfzAsnav2yjDC/8HSnNq/sdTbZWwU=;
 b=GveswxVpcuBGacIPX9zVMMc07RZExi3geRZF2gDGq2Ta5iMzw0qL9qZ6I2VKBIhaXigPg
 nxMl7VDcfl0Rvdx7E6D1JYre8F4wSPFi610waeszHmNpltNgoxN5az6TdK6BwtSBjhwbLzc
 fZId6x/JMVy994MIuNJBHhonhpgOSA4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1487083E4C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:19:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439172;
	b=pEGJTMVNL/CgWtq7kaDh/SV1ExPQuUXQK1TE18QzgRN1xmp7FvX3oEIeOc7ZdLmXCjwCO4
	aTP3kF748G52zZ6sPDXE3dlEbDKKztTw1nDw1x5PDGN7sk8oc5eGWjqbY97bLtWSfUw+hN
	eenvsLZyNUQjGjw2vFfFifBkPtEdn0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Moof/ql17TMpK6RfzAsnav2yjDC/8HSnNq/sdTbZWwU=;
	b=1fN7apY2n/o3sR0YC6Ko4NQIrs5Vgtz/HJkx66OOfXcyJH4M6syasLwunIw5hUHAnqYHL5
	lXlqYXAxGlxxIQ8bcDmBjWF0C+yAXGkPVrAKDVynRxK21QjBx66CxkR41pAXlfb9ZbXwbR
	2Exl51UsO+K84+pCJbE80A+ZeUfghAA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=K++LpHwv;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CFA6820CD9;
	Thu, 30 Jul 2026 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Moof/ql17TMpK6RfzAsnav2yjDC/8HSnNq/sdTbZWwU=;
	b=K++LpHwvNsZdtV4ciQlVzQm8bMcTi1c4BPKV++p8Jph95sVAFYioZ90ZOTH7L+uN28vU0x
	6w531kOJp25fLJOGWKzrRrUGQN15QBa6vTvtmpoSos2vumd+ZQfY4MpgBj+PpMq1ywCen8
	qYkMcQeBodQOtJDl94baurAYaog51wo=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:18:55 +0200
Subject: [PATCH 1/2] alfred: Use _exit() in the update command child
 process
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-notification-v1-1-d7cf675220e2@narfation.org>
References: <20260730-bugfixes-notification-v1-0-d7cf675220e2@narfation.org>
In-Reply-To: <20260730-bugfixes-notification-v1-0-d7cf675220e2@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=sven@narfation.org;
 h=from:subject:message-id; bh=XV1L9ubOV4Ekm8YFwlqK5+Ebz8BO/vmWrnZJX6dnbew=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZixdkz9be+JqZ6WcWL7vS5QM8R+oqHKrs2p7HWh67L
 sJyt+NTRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAidwUYfjGdzjG5cnJ92nZ+
 X4Gy6bNO/OsOKrr5UqCNxeYnzzXeDdcY/ofkes/Qufy8KZ3N0GdaQmtKo8sz9eBLWQF7LmtLXwm
 /ww4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZIHSWW3LGQ5KL6HMGEW6GP3NSCNNRCWI
X-Message-ID-Hash: ZIHSWW3LGQ5KL6HMGEW6GP3NSCNNRCWI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZIHSWW3LGQ5KL6HMGEW6GP3NSCNNRCWI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

execute_update_command() prints a line to stdout and then fork()s a child
which runs the update command via system() before terminating with exit(0).

When alfred's stdout is is buffered, at the time of the fork() the buffer
still holds the just-printed "executing: ..." line along with any other
pending output, and the child receives a copy of that buffer. Calling
exit(0) in the child flushes its copy, and the parent flushes the same
content later, so every log line still buffered at fork() time is written
out twice.

Terminate the child with _exit(0) instead, which does not flush the stdio
buffers inherited from the parent, leaving the buffered output to be
written exactly once by the parent.

Fixes: 4ae4c749c0a4 ("alfred: Add "--update-command" parameter")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server.c b/server.c
index cb3fcfe..47613fd 100644
--- a/server.c
+++ b/server.c
@@ -364,7 +364,7 @@ static void execute_update_command(struct globals *globals)
 	script_pid = fork();
 	if (script_pid == 0) {
 		system(command);
-		exit(0);
+		_exit(0);
 	}
 
 	free(command);

-- 
2.47.3

