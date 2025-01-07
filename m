Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7208BE77197
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 16:20:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B299383F64
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 17:20:13 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736266813;
 b=WXqeeuyelJe3Y7uf8gJtmQ+yFk3ICbEPlzIt61fuBrQIkVONfP9v3YQlpThqIZ3fweYuf
 O/fMirp11iQmXJaYV4JqBZhn7heffxAGG25BQPv6vHV/HbL032w+atVdrgwj9eyh2ljDWH4
 zUEdpMfOfno7sR9ruRNJy86kBJnWOuk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736266813; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1xDkrRXQuSzOJk2ez2jJiEvDHvLSo1I47JDTHbi48y4=;
 b=YaiWEVsI4wy2GcpkVxOiAZCpIUamOVHXyzEdbFUXaNc+hY2XgdiwBWOnhDwfXSYtf1H/J
 OIOV2C/dyi1idLCNipyzceiR4nktXWwaZ15ar5wI8yoRRv3ZzHJf274Txt3ILQLqP1GpY3v
 Gw7CN8EbmsSB9pojJRBoZotB8H1xGl8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0E9AD83F95
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Jan 2025 17:18:57 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736266738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=1xDkrRXQuSzOJk2ez2jJiEvDHvLSo1I47JDTHbi48y4=;
	b=i/Br7DspMKmD6kur23FN2rIMQZx/G9QKszZVpfIWDJF4T4RMsNptexDnklHKITcuXFkyL4
	B68xjJCN1RRrE9Rdsid1eI4PG3WT9UCUxvC+NQJ/9Dgabge2bnFrpT79tIDR/q5W4DnH2n
	jCCHzQthMayS5Calk8gKk8lSq2uOyN4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Vv2l9sL0;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736266738; a=rsa-sha256;
	cv=none;
	b=Gluhb97niDJK8hbyzpi/l9LLNWJtZwD+1kzWVnkFWAom6jCHXxP7dskDefQefj7e0ShYeL
	8odZsCzk3qHivbHcIdA+qUhmzylO3jx4lm/pb8KCp2vkj/0yEhbyFYTuILm9VB1sEyc1Yl
	qwRzEFqaiMpFjCXqNxm2SoFAxGm5f8s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736266737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1xDkrRXQuSzOJk2ez2jJiEvDHvLSo1I47JDTHbi48y4=;
	b=Vv2l9sL0qN3Sr2e72DA7BDz81a9HL36Fns9fGkRnbOSiV5hGrjFNepkAhIzLSH30uu+8nV
	1shRbBeMDHZ5EMs+Qk6L2hGqTvx8guO+iJEeZW5egoiSKHMnfrid8QDQnqLwNfsGW/pYT9
	l8h7RcA0PQSy4PbHI2m9sUfm+YacUnA=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jan 2025 17:18:54 +0100
Subject: [PATCH v2] alfred: Use mailmap to fix old e-mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mailmap-v2-1-af4e55bb048c@narfation.org>
X-B4-Tracking: v=1; b=H4sIAO1TfWcC/z2NQQrDIBBFrxJmXYuaqKSr3KN0MVRNBqqGMYRCy
 N0rhXb54L/3D6iBKVS4dQdw2KlSyQ30pYPngnkOgnxj0FIbqaQTCemVcBVojXER9ejUCG29coj
 0/pbuj8aRSxLbwgF//qB0r/7+roQSPlpj0XnfD37KyBG39n8tPMN5fgBKGqdqnAAAAA==
X-Change-ID: 20250107-mailmap-a6557fa29719
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674; i=sven@narfation.org;
 h=from:subject:message-id; bh=abo7Zu3tWH7KExHlbLpiRXDSQcwLIrZVUu6cN/uxGV4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOm1we93sklHTkn4sKpkl65Bw4S8N2+uzOXNTHs8j62l4
 0Oynf3EjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEkkIYfrPUvWW48mq+dMJd
 KYa8n9pOxWEvoueFKf054lLj7L2R1ZDhf2Cm4o+G38+sbyikMjXlaUkKpmg8OxbK/XBKmZLsqzN
 XeAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YUMBCC3PFTQVS4YHL2LBPWBHZJBRNSAW
X-Message-ID-Hash: YUMBCC3PFTQVS4YHL2LBPWBHZJBRNSAW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YUMBCC3PFTQVS4YHL2LBPWBHZJBRNSAW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The .mailmap is used by git-(short)log to fix some botchered names and to
map contributions from old e-mail addresses to new ones. It is also used by
some tools to get the correct e-mail address for reviewers based on old
contributions.

The list was generated using old e-mail address changes in the source code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- Switched to Antonio's preferred e-mail address
- Link to v1: https://lore.kernel.org/r/20241231-mailmap-v1-1-df656a7dd34d@narfation.org
---
 .mailmap | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000000000000000000000000000000000000..56bb3301712ae63dfaa48cc0707d5ec67d978617
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,29 @@
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
+Antonio Quartulli <antonio@mandelbit.com> <antonio@meshcoding.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio.quartulli@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@autistici.org>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@ritirata.org>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@openvpn.net>
+Antonio Quartulli <antonio@mandelbit.com> <a@unstable.cc>
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
base-commit: 2b908d04dc181e9ce2277edf59c4e8e8b3bc38df
change-id: 20250107-mailmap-a6557fa29719

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

