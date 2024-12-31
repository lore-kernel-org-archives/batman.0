Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631BBE77188
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 09:07:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9D4E983F6C
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 10:07:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735636065;
 b=YfgaGvw6cprJh0DcgRvPVV0mVju1kKL0GDSLSE0OE8kF1yFp7Fd8NtDZztpjcJ4PQCmm9
 VY1LxgV1lqYtN8yLT1QPFHwDYUQ3DdlBLK6X4MVyKVSc3ZdUcYDi3QE7KNcZZr37TfXDmQh
 m7YC9dkLPWokAGh1HTYCCyV2iu+skpk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735636065; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TdWOix+mTzf5IwAbXlA/ChBR0BA0Fs/pR6yefIbeKGc=;
 b=psY5N8UbtXGCARroQeJI1WXAfELF/mfbCkfPBJZs/xX5iJyGSS4y/U2EAQqcCIiUgnyrw
 Z2p3xtP0Prn2d0UNE58O223yyo3Fe7yU18/gj8nRhBH+jMieBSEjppxgQaJtCwWyCVIcaNX
 YVrvOc2WSi6E08KGJC7LQ8fx6e6N+8w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2338D80F5C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 31 Dec 2024 10:07:25 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735636045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=TdWOix+mTzf5IwAbXlA/ChBR0BA0Fs/pR6yefIbeKGc=;
	b=gUj2ISASgp7yzArthQVDXYzL7Rsepeu4TZ2jaBZjC78XT8B7kYJWEVdpFAmAq96ol0h8jE
	iu1st6XipeHyKWGNeMbmfHdwuTmmYSjr3MOIQgqpcu2/cwxJCvXdf0pHtsbSYUidS8E2bu
	9HYZB82z+bELSKKQtofvvZwtslVN4D4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="g2d/w9TX";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735636045; a=rsa-sha256;
	cv=none;
	b=eoI86731sWXc2Y6Oi7N1J/ihEylwYjjlI+i7gYPrMUPHJw7x4IcHVK5Pq+w0kVdyON21qo
	4Ap/HUt1V+DdVU1Uakg8PraOD6SDXSuNosFXhSKsJV81KkvBVK2oVDuhcACqYC8jI6zW7X
	Tq0G1JgJ1zignHC4gLYn4v1zpAuiFIU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1735636043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TdWOix+mTzf5IwAbXlA/ChBR0BA0Fs/pR6yefIbeKGc=;
	b=g2d/w9TXrHiVSoemlzS1ZsZlAUEsqKZA9+pDZD05qAINlftWGvzrLRrVbPmdWtHOOSAoOn
	zHeC6lOUv3Vrbl8Kq9frHxa+V9ko7sVpPS8CAh9SjPFz8LNXJ4osp8aArcB0Onh4EvVWYS
	CTg1P7NT54HAnAkDnp70iKkQh92yNg8=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 Dec 2024 10:07:17 +0100
Subject: [PATCH] alfred: Add mapping of old e-mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241231-mailmap-v1-1-df656a7dd34d@narfation.org>
X-B4-Tracking: v=1; b=H4sIAES0c2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI2ND3dzEzJzcxALdlCRzy+RUy5RECyMjJaDqgqLUtMwKsEnRsbW1AME
 Dh9BZAAAA
X-Change-ID: 20241231-mailmap-db79ce9da822
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=sven@narfation.org;
 h=from:subject:message-id; bh=7YvXPBxsQuAtniZuYuFGGG+MPNpgSTtzUoV1try/IzY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnFW9wZrZXllDOc672V/oiJcyqe5wzVVra6lXHtxtwTU
 zKTdxl0lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACbicprhr/Tqc6z/2d9bcoq/
 b06MNfXYt640c/oU/m8rXR43nXs4O4+RYVvlgq1/s7m79jEuY3n5ZP5kjUbnwBOG6+bK6gVd951
 nzQEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WXHBPMJ75JRF6KMUFCZGSMGEDBDM2VUG
X-Message-ID-Hash: WXHBPMJ75JRF6KMUFCZGSMGEDBDM2VUG
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WXHBPMJ75JRF6KMUFCZGSMGEDBDM2VUG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The .mailmap is used by git-shortlog to fix some botchered names and to
map contributions from old e-mail addresses to new ones. It is also used by
some tools to get the correct e-mail address for reviewers based on old
contributions.

The list was generated using old e-mail address changes in the source code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 .mailmap | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000000000000000000000000000000000000..dac1793fa4f6e931155882f26d3df5a9b83f8fe6
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,27 @@
+#
+# This list is used by git-shortlog to fix a few botched name translations
+# in the git archive, either because the author's full name was messed up
+# and/or not always written the same way, making contributions from the
+# same person appearing not to be so or badly displayed. Also allows for
+# old email addresses to map to new email addresses.
+#
+# For format details, see "man gitmailmap" or "MAPPING AUTHORS" in
+# "man git-shortlog" on older systems.
+#
+# Please keep this list dictionary sorted.
+#
+Antonio Quartulli <a@unstable.cc> <antonio@meshcoding.com>
+Antonio Quartulli <a@unstable.cc> <antonio@open-mesh.com>
+Antonio Quartulli <a@unstable.cc> <antonio.quartulli@open-mesh.com>
+Antonio Quartulli <a@unstable.cc> <ordex@autistici.org>
+Antonio Quartulli <a@unstable.cc> <ordex@ritirata.org>
+Marek Lindner <marek.lindner@mailbox.org> <lindner_marek@yahoo.de>
+Marek Lindner <marek.lindner@mailbox.org> <mareklindner@neomailbox.ch>
+Simon Wunderlich <sw@simonwunderlich.de> <simon@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@s2003.tu-chemnitz.de>
+Simon Wunderlich <sw@simonwunderlich.de> <siwu@hrz.tu-chemnitz.de>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@gmx.de>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@open-mesh.com>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@openmesh.com>
+Sven Eckelmann <sven@narfation.org> <sven@open-mesh.com>

---
base-commit: afcd2daa79a87b217773bdc8a27d90fb81723c80
change-id: 20241231-mailmap-db79ce9da822

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

