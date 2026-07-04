Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C17C43458
	for <batman-adv@archiver.kernel.org>; Sat,  4 Jul 2026 11:39:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6009284115
	for <batman-adv@archiver.kernel.org>; Sat, 04 Jul 2026 13:39:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783165183;
 b=abzUQaYt1jYyO266MoVX9QoFi/I7u+qg5VuYbvOTkbBj1F5YZlrEgzYVKG7V2q8wu909Z
 Nug5PqsreC8Wka+VGZXP9K/oFk+ShLolmeUaz9+rdVUG2gtwR05UQW8dZlbtrX4b4HP5t9a
 KDZ9/OnP6/ZdYa6rQbpMe2Rdo/BpTJs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783165183; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dzYX6PuiZ/tc6m3J+K/1wMmZdSISipu9/Tmb5WI9Q2g=;
 b=JUpJDHy0GlOEjzEo6tjpHxVvOsEa/YIFb0YKhG2q2JwndaBOt9V2Ce3ZA6AjqE7In7Nrj
 nHHGN+vHxH/P4Bm6UYU12hBI5gBN3W0jzkyQp0AZE21WNBtHCFI44d8aLBJixIp+5aa/Eiw
 GqLQXj7go7VkW2OCfdvp6/Jna0C+XI4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 934B3811BF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 04 Jul 2026 13:39:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783165161;
	b=H/t9/ddzZfwaILzNQ4Im8znH+CcdB+1yK3Crm7c7xtDkLxlnTQb9uG1YjEt/cUSqQPgf3q
	A+62ZEAl/5Kh3zhelZP87xzdnwSnKbDcIZ8b1KOB//FkrTm4sZVgVOOVYkEUBTJ/wiabxf
	pwb0So1aGKPJJAy2U1fQPYnONyGey8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783165161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dzYX6PuiZ/tc6m3J+K/1wMmZdSISipu9/Tmb5WI9Q2g=;
	b=ddcRDzkRl95wzd3xdVq61KC5na0s2APypiXX+c0mmTS7C1rI8Voc7wo3e5fWdtNEA46ulD
	TqC2x2GH2WChNkmqyM9nZjQpC3FEOmio0667WXuiucJAjK50lxNJAz0Er8y1HL2TwFzNOi
	TsUZpkXyIbSeXrQtCVbv2/Q8uovgfP0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IA5QpeyL;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 12C1120378;
	Sat, 04 Jul 2026 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783165160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dzYX6PuiZ/tc6m3J+K/1wMmZdSISipu9/Tmb5WI9Q2g=;
	b=IA5QpeyLB9rWALBehl6sR9GIiBUXEt21uQ5mWAMnjG5UtrJN9pAREY81TdG9ieJ7ydyFnD
	X50b4sb+4217SsWXfqioJkN+JIEqhfW43DY9g7XolGOggA4tzln577Gjugy5Dnw19v2VmM
	t9YVlcrB+NL/a0FoeY+QWzf8QvuLkpE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Jul 2026 13:39:10 +0200
Subject: [PATCH] batctl: bat-hosts: free bat_host when hash_add fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-bugfixes-bat-hosts-v1-1-b85f191fa837@narfation.org>
X-B4-Tracking: v=1; b=H4sIAN3wSGoC/yXMQQqDQBBE0atIr20YJSrJVcSFPSm1XahMjyKId
 88kWT6oXxcZgsLolV0UcKjpuiQUeUZ+6pcRrO9kKl1Zu8Y9WPZx0BPG0keeVovGFepnVQjEy0A
 p3AJ+k9S13d+2ywwfv0903x+MDuTydgAAAA==
X-Change-ID: 20260704-bugfixes-bat-hosts-5e6951bebcbf
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ub1SVMyUQ/JzWD/34eQQfn3D26WrxdlaCWy3DBhwO8w=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkeHx40TO18bLFicUpC7OQDOvWhM18xexkXzmG9V1Zix
 3y9cdm9jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE3JYz/OEUviDl3f755ok3
 h/5GW7q9ucDqzS9Z7Cl08vij47xfVmxm+GdrcVp+b9IsRuW/H1N4ZC5t38NaX7GiouXO+UsZfAu
 6FjMCAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DWX6M5B75ZL3FDE5SBHIQFUV76NZ2UZ5
X-Message-ID-Hash: DWX6M5B75ZL3FDE5SBHIQFUV76NZ2UZ5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DWX6M5B75ZL3FDE5SBHIQFUV76NZ2UZ5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If the hash_add fails (OOM or duplicated entry), then the allocated
bat_host would leak. The user would also not be informed about this
problem.

Check the return value and handle the error to make this problem visible to
the user.

Fixes: c7c76f63c1f9 ("[batctl] integrating batman hash implementation / move bat-hosts stuff into an extra set of files")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat-hosts.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index 6ad8247..160d317 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -130,7 +130,14 @@ static void parse_hosts_file(struct hashtable_t **hash, const char path[], int r
 		strncpy(bat_host->name, name, HOST_NAME_MAX_LEN);
 		bat_host->name[HOST_NAME_MAX_LEN - 1] = '\0';
 
-		hash_add(*hash, bat_host);
+		if (hash_add(*hash, bat_host) < 0) {
+			if (read_opt & USE_BAT_HOSTS)
+				fprintf(stderr,
+					"Error - could not add bat host: %s\n",
+					name);
+			free(bat_host);
+			continue;
+		}
 
 		if ((*hash)->elements * 4 > (*hash)->size) {
 			swaphash = hash_resize((*hash), (*hash)->size * 2);

---
base-commit: e93995999e80513db80eba200ea682b5b15556af
change-id: 20260704-bugfixes-bat-hosts-5e6951bebcbf

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

