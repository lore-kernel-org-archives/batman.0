Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD28BE77188
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 09:02:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EFB0483F59
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 10:02:41 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735635761;
 b=rZX2lXppdPh2Uiav12kd2j3lyiqluJhb9anFutU/NeTZDJ3ARIbifrQ10rQ+Ize2uodX8
 kUbRpyG8gjl5dQZ9OFjQwLgoTjxRuXeESkMAVFKQ8c0JsBKcj00vfAFiU7gdk4g4jflotUw
 44BQMJ2jSddjfypRTUUfBEC2wanzyf8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735635761; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rS8YZGE5Ti/t57mAkrhtGBUIWDecfgI4unEuP4QmT8g=;
 b=3NKv1hX1yZeu41ge77uWh3uZNd1lP2PPbYNwURj/6xgpW6IO+VGIA1BrxqHybsQPkAG49
 lcw6SBzZzeqdyh0flYDsizSr7Sc3FhRab9pQf4FwtrS4xARfR3+CLEFK7FJheuokE9fkfk7
 +bJ+95SMCU7SPJuo9/JUSHQaxjvwO2g=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD3888176D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 31 Dec 2024 10:02:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735635737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=rS8YZGE5Ti/t57mAkrhtGBUIWDecfgI4unEuP4QmT8g=;
	b=x8LnrdUY3jYNSjhQx7rXy+LFPX6GjcIYb+BFf4lS00zf7NNjs7BG/LFDiKT6RI0sa70E8e
	ABIQHfA9VTHsf2acF80LHOPSvf7x3CYB9+ivt8yUdCV/EELZQ133l7t68saL99iOyrNZzO
	9cxv2mUY2cl+WFYW9CPqIPnslayVVaU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YCkd1Cpr;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735635737; a=rsa-sha256;
	cv=none;
	b=X8jdnpt0xg+9HnCcjwcXLGy5YlK/ICTYGgOT2yLi5EPuHHQA8DtkwNLkOR8lUjVRswyoQL
	ilXfYlRIh3uGUh5QgXLvU+SFjTlTi/l/HGdiWRBji7gCW5vvlcVKpPFBLcc0U1B/aOGZwC
	L/iYBkcz7kW5+CG1I+ri2ET1FkMOpo8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1735635737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rS8YZGE5Ti/t57mAkrhtGBUIWDecfgI4unEuP4QmT8g=;
	b=YCkd1CprTy1RA06rYWekmRb9IZGAtj1eXkuFZ47BYO0Jip+/NyIEVFdQq+tMRvF6+SPcfo
	MtsrxnTfpBWYzuhmZ40A1nE+yJuvLHQWhhp67nF0CaFGBrjm3LfzQawUinm14XTbV0CNTO
	GPKxYndCEfJX9Cb0AzrGvXAActuPdM8=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 Dec 2024 10:02:03 +0100
Subject: [PATCH] batman-adv: Use mailmap to fix old e-mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241231-mailmap-v1-1-1494110b69e7@narfation.org>
X-B4-Tracking: v=1; b=H4sIAAqzc2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI2ND3dzEzJzcxAJd46REyzRDQ8NU80RLJaDqgqLUtMwKsEnRsbW1APy
 Hr4RZAAAA
X-Change-ID: 20241231-mailmap-3ba9f111e7a9
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5311; i=sven@narfation.org;
 h=from:subject:message-id; bh=k26QPYD4wKH+Rja40UOyq981UlHYa0i0plfXnhc9qLY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnFm3n3vtn+O83ivP7EgzOjdS4kCGnoBl28vzZ+65F8m
 ZhfaR/1OkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATsS1n+F+iOat3126mKNMM
 qdVfpjyLPMdyTztv1jyTnkMJ1d8cHl1l+M3GeoqZ36Pxod9k34nT9RzC7h+OPXF861pmWVYmx0u
 vVjICAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GMEF3VSKD5XQ2LNZFSJN6YUUSO4RK65Z
X-Message-ID-Hash: GMEF3VSKD5XQ2LNZFSJN6YUUSO4RK65Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GMEF3VSKD5XQ2LNZFSJN6YUUSO4RK65Z/>
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
 .mailmap | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000000000000000000000000000000000000..baea0dfef6112e5bcb2144cadd04781e58fe63c4
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,73 @@
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
base-commit: 50715dc9f4b72f390a24d485fbd235d01e96f988
change-id: 20241231-mailmap-3ba9f111e7a9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

