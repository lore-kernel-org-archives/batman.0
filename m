Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B09E77188
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 09:15:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BDC1B83F7A
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 10:15:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735636535;
 b=URCLmh+xbF8V2HWb5RJW1HfOxUxq5o1H32po+UFOoRdWkSqRJFXFhn/oJxJdrFhFUJbMo
 1DTWE1tyJ6ljiX3OH7C5PcUfIYagkBmIddde/M9tDDo1zr5wVJyiMw6ib+2uedOpBeqnVzJ
 kwXOBdTNYjPbfMlWPBnNYXYLlOwI8FE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735636535; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6awsZtBQIqjCwV5lZUqtdwFJrELBq7v8ntzp4XHc40A=;
 b=YPQeSY2NCgVtUM7F7kI67SWlLyjdoFn91Z+CE+RVsWhsqZqMsZ1IR9TQzE2kAinDVB+EN
 O6Euev1RRD0Q1KYjEHU7AH3QrFKSUR92+CwthAdeZMACMcjGmVoCCqygEvewu567FYo/29g
 vicOGNSY6xYlGsFaFYMwbxRHAOnT/FI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7E33483B8C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 31 Dec 2024 10:15:13 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735636514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6awsZtBQIqjCwV5lZUqtdwFJrELBq7v8ntzp4XHc40A=;
	b=GT9PnyQbrqtEFlqYYFi4K30DxlbxDRcQHSgu8fBZTcjoeUrUVY7xc8RXfPqHx5kwhn38VT
	y9UpVsNbxGkcp2FtOssOHNlibhTEDz2m0rqg8Zi1/151Z9fwv1us+UZhCn8qGjg10wZu/D
	ZemKFrHDptppihzKVjYRSP/HTUBX1Qg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mVzEwj6g;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735636514; a=rsa-sha256;
	cv=none;
	b=zhulctV2XpcFe/RQBhU57k9gQDVO5kXjQIB/ETZQNPn/WoV2yNLXpn7quid5IpM07AxuZj
	wxK/zZ+3Lu0EtRINqkzhptM+22v4+6PMEBJ+7echFiKUTnk6E/A7dmgXsoiahaUt7hjKcB
	ShuGKgDuoSpURbJnsjw/ELHSuAqJC7I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1735636512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6awsZtBQIqjCwV5lZUqtdwFJrELBq7v8ntzp4XHc40A=;
	b=mVzEwj6gdSME1k1c6CerggIKuXSbL+A07vDQMkj/P0soq/zTU08j3U8oikirs17oOKlh4h
	wW5GNLQD78RaxczodiNhwYBUwxc5BmpaU8k9xTUF0YKUPHnQXEFbXPn8w3wolGraLKfFhr
	cG2xhlX0lRBc1dIevEvzcRUGW+nurrY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 Dec 2024 10:15:04 +0100
Subject: [PATCH] batctl: Use mailmap to fix old e-mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241231-mailmap-v1-1-11a2b05753bb@narfation.org>
X-B4-Tracking: v=1; b=H4sIABe2c2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI2ND3dzEzJzcxAJdE8MUEzPzNIOUJHMjJaDqgqLUtMwKsEnRsbW1ADT
 lfxlZAAAA
X-Change-ID: 20241231-mailmap-41d467f0db72
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=sven@narfation.org;
 h=from:subject:message-id; bh=tnrs6VrhPGg61jvWufdymOksLrG9MLv90MdHEIcH0s0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnF2ySM/+yzcdjjsnNn/XthtW0Hc/1NH+qk+plM/vRyV
 nHC++awjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEirMZ/vCud3SfzliRV2EQ
 ax7Pcuaem+7/z3optw5tmu/S4hgycQLDb/Z4nVlVf2tvRpT0TNyuVKooKFU3s8ec85/YZubLW6r
 3MgEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6V3IY2QU3PVIFAOS7TA4UNPWZQ7S46SS
X-Message-ID-Hash: 6V3IY2QU3PVIFAOS7TA4UNPWZQ7S46SS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6V3IY2QU3PVIFAOS7TA4UNPWZQ7S46SS/>
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
Also relevant entries for other contributors from the v6.13-rc5 release
were added.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 .mailmap | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000000000000000000000000000000000000..79b29af883289c09124a88df6b34d64633ebdac3
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,35 @@
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
+Andreas Langer <an.langer@gmx.de> <a.langer@q-dsl.de>
+Andreas Langer <an.langer@gmx.de> <an.langer at gmx.de>
+Andrew Lunn <andrew@lunn.ch> <andrew.lunn@ascom.ch>
+Antonio Quartulli <a@unstable.cc> <antonio@meshcoding.com>
+Antonio Quartulli <a@unstable.cc> <antonio@open-mesh.com>
+Antonio Quartulli <a@unstable.cc> <antonio.quartulli@open-mesh.com>
+Antonio Quartulli <a@unstable.cc> <ordex@autistici.org>
+Antonio Quartulli <a@unstable.cc> <ordex@ritirata.org>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@acsom.ch>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
+Linus Lüssing <linus.luessing@c0d3.blue> <ll@simonwunderlich.de>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
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
base-commit: 60ff59118fd7f007adae1cc77ce9b268e3c977ce
change-id: 20241231-mailmap-41d467f0db72

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

