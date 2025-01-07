Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A951E77197
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 16:19:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C36783F30
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 17:19:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736266758;
 b=O4CtJpYJXvCN8LclXcvb4rZBIIpP3cZ85RBpjc/AI7WMFVS1SrbBy8Lj95qrJYGrZ/Ud7
 F84jKxD/Uv74vQGDr7kOmH2gX+G3EF/X2Fr9g/Y/xTc10DHNMQ/Z65vCZFDfyme/K0ThQq3
 QyOJKsTzDYEIZ2mkJV+Yd88urwdtBdw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736266758; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dyMMfcxVbDU9Os7v1j5aKFBl4U0Fq3J0NhfVtQJPT1o=;
 b=2GiUZzVwmHqhtYRaBS+sww+Jkw5M+TTXwkYVhyo58HrP+yrCFnxMc2AlOERLBvZbQ+v8O
 0tvqOA18uUBmlE/xKyHarS0jmPXCwXGP6GgVYZ0vFTHvvi2392quO9+Ns7nX3oGcNgCQZYU
 xvODTOnOdATef34OLpCXB17eOeHzxbE=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 158A481B6A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Jan 2025 17:18:51 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736266732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dyMMfcxVbDU9Os7v1j5aKFBl4U0Fq3J0NhfVtQJPT1o=;
	b=4RbhJgxv+BBhqsoxzjSbf30qhPUoEhcZ7ZrgsN0Hd+3oV83RkXoLj2Uexv0GvlHO3jLLQq
	aD1UAqqW80I3QXWGjcGDDJ2Y11hsHy0B3FfDve/0VgIRMksEZdXXyeK9Gqkj+ltHlw+0Un
	YxN5EHdOvFXkACM7riGQGmfIm3KO6po=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=jHHjZ82V;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736266732; a=rsa-sha256;
	cv=none;
	b=JbkDXKVqb73L2t9lkwmaQM/RUDTiS7ceYnIl6XuU7DLF978mPT/8j+hxwhtKABDNkVCE9z
	uQaLtUpBZMTncAMRcqKCt4D9MWWhxhDXvVmSnT63p/hXCfltI2ZXicMnPUnxpdg/7+QLvh
	4A9SXaYrDYSCGlHQ4TlKkPkF4kHfHi4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736266731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dyMMfcxVbDU9Os7v1j5aKFBl4U0Fq3J0NhfVtQJPT1o=;
	b=jHHjZ82VwDJrVbXzb/M5O3TXSYl27yJUnrSV8LhRJOcmcc5ksSdJAo5a7C4B3ZWPs3h+qY
	l1FbnPDqSGS9Dip4bW4xXR6ZMIKYWa7k/0UWvKqJAJXAj1ksezOGmXB3dXyQ+3r8ZdkTUz
	CHYjhsy9tBe210Y13TPgPALNmCmyDlY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jan 2025 17:18:40 +0100
Subject: [PATCH v2] batman-adv: Use mailmap to fix old e-mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250107-mailmap-v2-1-12d85da0b8e7@narfation.org>
X-B4-Tracking: v=1; b=H4sIAN9TfWcC/z2NwQqDMBBEf0X23JRsmmr11P8oPaxmo4HGyEakI
 P57Q6FlTg/mzeyQWQJn6KodhLeQQ5oLmFMFw0TzyCq4wmC0uWrUjYoUXpEW5Wok9INx/U1DaS/
 CPry/S49nYS8pqnUSpp9v0Vzw72+oSmxrEXVft9zcZxJPa/k/JxnhOD5tgrjwnAAAAA==
X-Change-ID: 20250107-mailmap-d61a1fc2db80
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5638; i=sven@narfation.org;
 h=from:subject:message-id; bh=8T5lYFnoVXWfn4XNwq1TGA6RLxZpyKG6dh63PdefoFI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOm1wS949CxPPfc+tjXw148mU223ulWcl08e/fNqFqtvd
 cb8J/fsO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATic1m+F+6ZrXmgzPup318
 8wr9fqxqF9Jqm6h05MvM9i9ak03nxRxl+CvprN4b3uqvZlqtf8ctaeE05SvN2xtjyu8a/tnPstX
 hEB8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: L63WPPGK5WCER3SKGB3WRGJZOEQMBV5V
X-Message-ID-Hash: L63WPPGK5WCER3SKGB3WRGJZOEQMBV5V
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L63WPPGK5WCER3SKGB3WRGJZOEQMBV5V/>
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
Also relevant entries for other contributors from the v6.13-rc5 release
were added.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- Switched to Antonio's preferred e-mail address
- Link to v1: https://lore.kernel.org/r/20241231-mailmap-v1-1-1494110b69e7@narfation.org
---
 .mailmap | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000000000000000000000000000000000000..85a8ba762dde10a696970dd5eb3f5ae9e4e6dafa
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,75 @@
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
+Antonio Quartulli <antonio@mandelbit.com> <antonio@meshcoding.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio.quartulli@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@autistici.org>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@ritirata.org>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@openvpn.net>
+Antonio Quartulli <antonio@mandelbit.com> <a@unstable.cc>
+Colin Ian King <colin.i.king@gmail.com> <colin.king@canonical.com>
+Dan Carpenter <error27@gmail.com> <dan.carpenter@oracle.com>
+Geliang Tang <geliang@kernel.org> <geliang.tang@linux.dev>
+Geliang Tang <geliang@kernel.org> <geliang.tang@suse.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@xiaomi.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@gmail.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@163.com>
+Geliang Tang <geliang@kernel.org> <tanggeliang@kylinos.cn>
+Jiri Pirko <jiri@resnulli.us> <jiri@nvidia.com>
+Jiri Pirko <jiri@resnulli.us> <jiri@mellanox.com>
+Jiri Pirko <jiri@resnulli.us> <jpirko@redhat.com>
+Kees Cook <kees@kernel.org> <kees.cook@canonical.com>
+Kees Cook <kees@kernel.org> <keescook@chromium.org>
+Kees Cook <kees@kernel.org> <keescook@google.com>
+Kees Cook <kees@kernel.org> <kees@outflux.net>
+Kees Cook <kees@kernel.org> <kees@ubuntu.com>
+Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
+Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
+Leon Romanovsky <leon@kernel.org> <leonro@nvidia.com>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@acsom.ch>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
+Linus Lüssing <linus.luessing@c0d3.blue> <ll@simonwunderlich.de>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
+Marek Lindner <marek.lindner@mailbox.org> <lindner_marek@yahoo.de>
+Marek Lindner <marek.lindner@mailbox.org> <mareklindner@neomailbox.ch>
+Markus Schneider-Pargmann <msp@baylibre.com> <mpa@pengutronix.de>
+Nikolay Aleksandrov <razor@blackwall.org> <naleksan@redhat.com>
+Nikolay Aleksandrov <razor@blackwall.org> <nikolay@redhat.com>
+Nikolay Aleksandrov <razor@blackwall.org> <nikolay@cumulusnetworks.com>
+Nikolay Aleksandrov <razor@blackwall.org> <nikolay@nvidia.com>
+Nikolay Aleksandrov <razor@blackwall.org> <nikolay@isovalent.com>
+Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
+Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
+Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
+Oleksij Rempel <o.rempel@pengutronix.de>
+Oleksij Rempel <o.rempel@pengutronix.de> <ore@pengutronix.de>
+Paul E. McKenney <paulmck@kernel.org> <paul.mckenney@linaro.org>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
+Randy Dunlap <rdunlap@infradead.org> <rdunlap@xenotime.net>
+Randy Dunlap <rdunlap@infradead.org> <randy.dunlap@oracle.com>
+Randy Dunlap <rdunlap@infradead.org> <rddunlap@osdl.org>
+Randy Dunlap <rdunlap@infradead.org> <randy.dunlap@intel.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@s2003.tu-chemnitz.de>
+Simon Wunderlich <sw@simonwunderlich.de> <siwu@hrz.tu-chemnitz.de>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@gmx.de>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@open-mesh.com>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@openmesh.com>
+Sven Eckelmann <sven@narfation.org> <sven@open-mesh.com>

---
base-commit: c37dff40d07fbceb9d8b5d872f971ecc54da7fcc
change-id: 20250107-mailmap-d61a1fc2db80

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

