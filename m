Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE56BCD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 11:02:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4824083F40
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 13:02:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782039758;
 b=LZnaRxJwn2l0aExdGslPr/qol5CMxPfK05XIpfYMSjQTeXI+mLNNgYQ87lQacaLLjA/fM
 HN0ncQDJYaZWMPkrXPm3SFyip0HiA9s9FP17NbOGmoizKIFwPlGcFjp5Y2q89js3uxb8h8n
 ihyDveje/lS8uHDBiKbIqyilt76/Gfc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782039758; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=31o1PkNX/UXG8Bq78l4SycLtkbws0dfHf4wBQfU15gY=;
 b=0FirFh6ObRXuGFBJSAt1Q6QqDFVhJG9XsbBMur5giKB4IiXB6IBbJBUQ+YBLhQdAeZpSb
 fG+KaQsDjQ8Byv+7s7u97tKSolQ6nS73TY37HCMJomTo5W/XS8fpXwh5LEbgh6lpEUVvbRK
 RGczpoLmKzgxVBAIc7eXSr+JM2vfLto=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 220F980BC1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 13:02:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782039744;
	b=JEhHL7zPt3xhqpZRFxuvoDhfww0E8t7pJRL9kgdltAdxvdfXswPy+v6XWPr5f657J3NWKd
	dpIWVOZcSLES73buzrI3lv6JHcTppGgFxrRK0UGXC33aaqoXLZ+LZhHGWee3a3WEVkYZDw
	1uRmtpCGGm+yFCeXgyY1XAMXz7KMtaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782039744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=31o1PkNX/UXG8Bq78l4SycLtkbws0dfHf4wBQfU15gY=;
	b=RZJxnXkvU5stKvq4ZlGQxnUUkKn1urtp6kCo+YUKBuFeBIRSohOxH0og3vV+qWdtwqgVsG
	Us6jOfI/UKF1KJ2SvfZVKMaFxfneKWOn3UTxh1rwCOVZDy6XR22S5454o39INK8/CB4is+
	uvs3ruHRvjgS8ro+2NFoov526AfH3ko=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DROj09ad;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3029A1FEC5;
	Sun, 21 Jun 2026 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782039733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=31o1PkNX/UXG8Bq78l4SycLtkbws0dfHf4wBQfU15gY=;
	b=DROj09adW3h0JCSjUZBB7dkuKqMaPLoL3TuVy0ONqqd2ryJjoIJs/tDxisoNpC686uV8PY
	zyfbB+hNQq0ifJI2qglEVeV+/4h0y34wOWsiXHKC3Ej9XOekcamoPCCJ3Q4JEChj2LBqUR
	D7uAzhrdT1evo8ZrZ93v+uEJ7dq61tg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 13:02:09 +0200
Subject: [PATCH] batctl: switch to native getrandom
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-native-random-v1-1-4af35a65a8a9@narfation.org>
X-B4-Tracking: v=1; b=H4sIALDEN2oC/yXMQQqAIBBA0avErBNUMqKrRAvTsSZIQyuC6O5ZL
 d/i/wsSRsIEbXFBxIMSBZ8hygLMpP2IjGw2SC5rXkvBvN7oQBa1t2FhxjjXVEIrpSzkZo3o6Px
 +Xf877cOMZnsncN8PQfIrq3EAAAA=
X-Change-ID: 20260621-native-random-ccff841a555d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4593; i=sven@narfation.org;
 h=from:subject:message-id; bh=2T+GFPVYqEsRPUPyg1/5iwIOkgvrsSmlMu2WZ9imHI4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmRzaulfGaGuK/hbFp7mWu7c8L5RuftPi08t3WUN64P
 HnNgSmNHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ3FFlZHhxIkIwJffLtkWp
 iyRKeHQs78dkxhj3Lpk84d0ZjZ5s1q2MDAfd/L4arzw/u+DRbweuP04Kv4LZ61unn2B081JdoC+
 3jgcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3TLQWMPX3HVLFTGAI2ZPVTWFFQHMU3CM
X-Message-ID-Hash: 3TLQWMPX3HVLFTGAI2ZPVTWFFQHMU3CM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3TLQWMPX3HVLFTGAI2ZPVTWFFQHMU3CM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When the commit 98541a89ff99 ("batctl: Add helper to generate instant
random bytes") was added, getrandom() was not available on all systems
which batctl should support. This changed and all the fallback code can now
be removed and getrandom() can be used directly

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c   | 65 -----------------------------------------------------------
 functions.h   |  2 --
 icmp_helper.c | 10 ++++++++-
 ping.c        |  8 +++++++-
 traceroute.c  |  7 ++++++-
 5 files changed, 22 insertions(+), 70 deletions(-)

diff --git a/functions.c b/functions.c
index 5e1cb40..170a1ff 100644
--- a/functions.c
+++ b/functions.c
@@ -869,71 +869,6 @@ int check_mesh_iface_ownership(struct state *state, char *hard_iface)
 	return EXIT_SUCCESS;
 }
 
-static int get_random_bytes_syscall(void *buf __maybe_unused,
-				    size_t buflen __maybe_unused)
-{
-#ifdef SYS_getrandom
-	return syscall(SYS_getrandom, buf, buflen, 0);
-#else
-	return -EOPNOTSUPP;
-#endif
-}
-
-static int get_random_bytes_urandom(void *buf, size_t buflen)
-{
-	ssize_t r;
-	int fd;
-
-	fd = open("/dev/urandom", O_RDONLY);
-	if (fd < 0)
-		return -EOPNOTSUPP;
-
-	r = read(fd, buf, buflen);
-	close(fd);
-	if (r < 0)
-		return -EOPNOTSUPP;
-
-	if ((size_t)r != buflen)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static int get_random_bytes_fallback(void *buf, size_t buflen)
-{
-	static int initialized;
-	struct timespec now;
-	uint8_t *bufc = buf;
-	size_t i;
-
-	/* this is not a good source for randomness */
-	if (!initialized) {
-		clock_gettime(CLOCK_MONOTONIC, &now);
-		srand(now.tv_sec ^ now.tv_nsec);
-		initialized = 1;
-	}
-
-	for (i = 0; i < buflen; i++)
-		bufc[i] = rand() & 0xff;
-
-	return 0;
-}
-
-void get_random_bytes(void *buf, size_t buflen)
-{
-	int ret;
-
-	ret = get_random_bytes_syscall(buf, buflen);
-	if (ret != -EOPNOTSUPP)
-		return;
-
-	ret = get_random_bytes_urandom(buf, buflen);
-	if (ret != -EOPNOTSUPP)
-		return;
-
-	get_random_bytes_fallback(buf, buflen);
-}
-
 int parse_bool(const char *val, bool *res)
 {
 	if (strcasecmp(val, "0") == 0 ||
diff --git a/functions.h b/functions.h
index c2ce1b8..19334df 100644
--- a/functions.h
+++ b/functions.h
@@ -58,8 +58,6 @@ int get_algoname(struct state *state, unsigned int mesh_ifindex,
 int check_mesh_iface(struct state *state);
 int check_mesh_iface_ownership(struct state *state, char *hard_iface);
 
-void get_random_bytes(void *buf, size_t buflen);
-
 int parse_bool(const char *val, bool *res);
 bool parse_throughput(char *buff, const char *description,
 		      uint32_t *throughput);
diff --git a/icmp_helper.c b/icmp_helper.c
index 8b4fad7..33fe535 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -21,6 +21,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/random.h>
 #include <sys/select.h>
 #include <sys/socket.h>
 #include <sys/uio.h>
@@ -226,7 +227,14 @@ static int icmp_interface_add(const char *ifname, const uint8_t mac[ETH_ALEN])
 
 int icmp_interfaces_init(void)
 {
-	get_random_bytes(&uid, 1);
+	ssize_t r;
+
+	r = getrandom(&uid, sizeof(uid), 0);
+	if (r < 0)
+		return -errno;
+
+	if (r != sizeof(uid))
+		return -EIO;
 
 	return 0;
 }
diff --git a/ping.c b/ping.c
index b61bca4..dfe99c4 100644
--- a/ping.c
+++ b/ping.c
@@ -170,7 +170,13 @@ static int ping(struct state *state, int argc, char **argv)
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
-	icmp_interfaces_init();
+	res = icmp_interfaces_init();
+	if (res < 0) {
+		fprintf(stderr, "Error - unable to initialize ICMP interface: %s\n",
+			strerror(-res));
+		goto out;
+	}
+
 	packet_len = sizeof(struct batadv_icmp_packet);
 
 	memset(&icmp_packet_out, 0, sizeof(icmp_packet_out));
diff --git a/traceroute.c b/traceroute.c
index a0fb925..9748151 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -106,7 +106,12 @@ static int traceroute(struct state *state, int argc, char **argv)
 
 	mac_string = ether_ntoa_long(dst_mac);
 
-	icmp_interfaces_init();
+	res = icmp_interfaces_init();
+	if (res < 0) {
+		fprintf(stderr, "Error - unable to initialize ICMP interface: %s\n",
+			strerror(-res));
+		goto out;
+	}
 
 	memset(&icmp_packet_out, 0, sizeof(icmp_packet_out));
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);

---
base-commit: ea57436f665805a6e93f496617e44dab8a2f33a4
change-id: 20260621-native-random-ccff841a555d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

