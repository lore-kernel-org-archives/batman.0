Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30095C55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:08:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9A08D84202
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:08:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942524;
 b=ZjYf+feRJfYdNv+XTbHTY/SfvBa9UkKovxjWHB9FwgpIBlkc2VQPsUoUHyr9EnBuJNDRr
 WOpNmcQ7OQo43fqpl9xFHuGuQpsGFxCkSd4VUQTcs9rkiINY7uH7QjPzoKf8lZAASZcXuo9
 ZTSzyPmlIBJ/fo91+hwjEqvUqQwD9uQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942524; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AmlLtQRkM97FYutHqGFpM6jrd2KvNwyPOfScA9ebmQ4=;
 b=0FxyzRKXQpRP0XJGm/kR+YLhfCfLpe5eowkuVKpxVnXFxoviBxxHyPeVF13e8jDyZcESX
 H7pTbWwtyyqU1o0eHx/bUFxvYzk1Lyc1MN/ctI+7Y/fWvL4FsFHG6KNN+cpIsjQFk8wKeOl
 u93d2+1Z7zrEJhnZSIo+u7ARGR3kCuA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1D8D781083
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:07:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942452;
	b=2xbm/rm40sd/b3JI74ARVGgYOQo90x7Bl4vPhCVYylHqXuJvoWG8KwK5U9o4l3IPggnx8w
	8IIN0rHpalzJl1RvXg2d+lZ4q8a1iJXd/LyU2nqhXKrdLxfNIM7jArxaSA+T459scCimzH
	aVFBf8yBHCSlxzG7AZAO8j/RPwiNRKc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AmlLtQRkM97FYutHqGFpM6jrd2KvNwyPOfScA9ebmQ4=;
	b=wzGyS4edeGw0H+lRdZZWFkS2i+ohyLZHRyJkUB0JLriobAqp2EGPzmMGIpzujG1jMkLgrx
	TiaKBY6pcHmZlgp4tj8Xo4frl3mFFIWoDiR/Fz+cG2JDUnwfcvVshO4VNEoXfOQGobs4x3
	gOgvYGdjl8thTquTfPJks7VrXEr+2Lw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QpCXlBHW;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A7D21204D0;
	Wed, 05 Aug 2026 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmlLtQRkM97FYutHqGFpM6jrd2KvNwyPOfScA9ebmQ4=;
	b=QpCXlBHWw3nV8peOjb/AKbtxh2jZ3/yNOs3If5jUbq3JjEnx/+Htp3pt6jEXFAxG0YS2J/
	xQYgOPwQvV7GOaAR3AZBuT8l1R/qXtMDA+FiYC4CEUZoB7oNPXlEC0N460iYPWSbINgP/E
	2NzMC5ik6ZF/fQKoX2OKRd4h0NVBThI=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Aug 2026 17:06:58 +0200
Subject: [PATCH batadv 2/2] batman-adv: compat: add
 scoped_guard(spinlock_bh, ...) support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-scoped_guard-compat-v1-2-3067f6013b62@narfation.org>
References: <20260805-scoped_guard-compat-v1-0-3067f6013b62@narfation.org>
In-Reply-To: <20260805-scoped_guard-compat-v1-0-3067f6013b62@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=sven@narfation.org;
 h=from:subject:message-id; bh=8rmMNiBmHjjVUKrzE1eVmlOw6Nhxcrut11Xj/1bgXUc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFgZNlE0V1zEoVYr/+D5rp85Rv4773LDmz4wr7rt7rz
 rst/V6jo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRr08ZGS4eV+v9GL5FKyxI
 cv+1jIjwaSVX3v5ccMHildTS8JQgdl9Ghln3Kn0YNK49j/s7ScG14qT9hbVvezufJKxs779zYWq
 AGhcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4TUBCDQ2DU4HRGOEWMBGUVAILAJC3ASZ
X-Message-ID-Hash: 4TUBCDQ2DU4HRGOEWMBGUVAILAJC3ASZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4TUBCDQ2DU4HRGOEWMBGUVAILAJC3ASZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/cleanup.h  | 48 +++++++++++++++++++++++++++++++++++++++++
 compat-include/linux/compiler.h | 15 +++++++++++++
 compat-include/linux/spinlock.h | 20 +++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/compat-include/linux/cleanup.h b/compat-include/linux/cleanup.h
new file mode 100644
index 00000000..9cdb6466
--- /dev/null
+++ b/compat-include/linux/cleanup.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_CLEANUP_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_CLEANUP_H_
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6, 5, 0) && \
+    !(LINUX_VERSION_IS_GEQ(6, 1, 79) && LINUX_VERSION_IS_LESS(6, 2, 0))
+
+#include <linux/compiler.h>
+
+#define CLASS(_name, var)						\
+	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
+		class_##_name##_constructor
+
+#define scoped_guard(_name, args...)					\
+	for (CLASS(_name, scope)(args),					\
+	     *done = NULL; !done; done = (void *)1)
+
+#define __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
+typedef struct {							\
+	_type *lock;							\
+	__VA_ARGS__;							\
+} class_##_name##_t;							\
+									\
+static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+{									\
+	if (_T->lock) { _unlock; }					\
+}
+
+#define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
+static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+{									\
+	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
+	_lock;								\
+	return _t;							\
+}
+
+#define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
+__DEFINE_LOCK_GUARD_1(_name, _type, _lock)
+
+#else
+#include_next <linux/cleanup.h>
+#endif /* LINUX_VERSION_IS_LESS(6, 5, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_CLEANUP_H_ */
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
new file mode 100644
index 00000000..de7c09c4
--- /dev/null
+++ b/compat-include/linux/compiler.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
+
+#include <linux/version.h>
+#include_next <linux/compiler.h>
+
+#if LINUX_VERSION_IS_LESS(6, 5, 0)
+
+#define __cleanup(func)			__attribute__((__cleanup__(func)))
+
+#endif /* LINUX_VERSION_IS_LESS(6, 5, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_ */
diff --git a/compat-include/linux/spinlock.h b/compat-include/linux/spinlock.h
new file mode 100644
index 00000000..71a333f8
--- /dev/null
+++ b/compat-include/linux/spinlock.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SPINLOCK_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_SPINLOCK_H_
+
+#include <linux/version.h>
+#include_next <linux/spinlock.h>
+
+#if LINUX_VERSION_IS_LESS(6, 15, 0) && \
+    !(LINUX_VERSION_IS_GEQ(6, 12, 37) && LINUX_VERSION_IS_LESS(6, 13, 0))
+
+#include <linux/cleanup.h>
+
+DEFINE_LOCK_GUARD_1(spinlock_bh, spinlock_t,
+		    spin_lock_bh(_T->lock),
+		    spin_unlock_bh(_T->lock))
+
+#endif /* LINUX_VERSION_IS_LESS(6, 15, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_SPINLOCK_H_ */

-- 
2.47.3

