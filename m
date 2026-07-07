Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F029FC43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:50:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 769A8846D5
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:50:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450202;
 b=ty53rVk5hewrVlOiTZ9OUQscqudW1SEQ0fzrTeKjDKo75vTfKOckIlqb9D30mA+ObSWMv
 NCu7TTAdlRH+ryHqF7vUum+jUUJvtse2p7eFOF2ZDasDKkkda/IlDsplXxZTYKf8DPKjeTT
 9zkE7EdMVQkbXQles7ExE638NDAfLWo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450202; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=R/m2Fu+PzPapBpQMXdsNVCT1g6T5F2+ETQQBhtXVBWc=;
 b=rsEHX0epJX2xJn5Qmu9d3Y65MWMlS+ahT94txj7Z/TenLefbTSKeLEEmjpov7Gh3qyIEN
 4VdGo8jDyRfeKCl9uJH6AA5W5BA2/SKenCb5rZtNEr6aRU5yZKm1oCpDjF7BTsc7W1dQlKF
 HQtfn6L1LAFb1x6kHq56nU9HfnLHF9M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 69C8882726
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:46:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450022;
	b=o/vjJ9HG0fM79f3HnQPbZeotIh9RXRIhNfLNj5QdEAK+JKqtDgDFYNN8xk3Ky5GO/UIrV/
	rifg6aEM/dIGCP1EatZWP94rJOB9PkTzd2dYJe6INwMhG+QsSlht01qYK75Br1wBOwi9iv
	+F5XMfWHrRPqEYCXWsypuowbfsXa8P0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=R/m2Fu+PzPapBpQMXdsNVCT1g6T5F2+ETQQBhtXVBWc=;
	b=a6bmvPh+Ki78ExLdnCn8uDLsD82++FQ3ViYWozy0ZE2Wu+49APqPErsYANOI5yG6lRZldx
	A7V5wPGblZ3ytP90VCAY3mKfBWZCZpPdHBbrk+s+bDQQnp3FS8xd0FybTAAJwScxd/cdKH
	h7FfSRJnNW45adEya3NXemhVPQ10cLA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=yLARw9vQ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BB04C2059F;
	Tue, 07 Jul 2026 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/m2Fu+PzPapBpQMXdsNVCT1g6T5F2+ETQQBhtXVBWc=;
	b=yLARw9vQ/c/6hgMloBiRzHzUHxBVw9E0oxX/Nm0e+gPCNXBk66IFMoUuALZHvw1//3DkZ8
	9E61fNyjJSftnPdzbSjzn2jUfk1X7J+RevI4dpo31nWtNKAp4sqSUj+7o8WeyGESPyWWm9
	EbgRvZ++xSiw8sheILFq5tvwBw0JNog=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:44 +0200
Subject: [PATCH 02/11] batctl: icmp_helper: return proper errno on syscall
 failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-2-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477; i=sven@narfation.org;
 h=from:subject:message-id; bh=6DPRe/ecas4af+Lgq9KGqW3/t/HvYhdJg/5nwbUrKf0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+nlPN3m/2e3JL6ufEdfVi7a+1+lJTX+Y8VVm9Q/djX
 57CsidhHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJGDIz/K8yd02fZXKhy1/i
 r2GpQvHSt209X8WfXfveezvo4o4PpREM/5Rm3bn54OY1753qD2eWPEnyU/x7z3BDUZM9k6KsXXW
 YED8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2QXQQ5MKFRWRUGJPX5HYYDSOME7I533F
X-Message-ID-Hash: 2QXQQ5MKFRWRUGJPX5HYYDSOME7I533F
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2QXQQ5MKFRWRUGJPX5HYYDSOME7I533F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

icmp_interface_send(), icmp_interface_read() and icmp_interface_filter()
return the raw syscall results. On failure this is -1 while the callers
interpret negative values as negative errno codes: ping and traceroute
print strerror(-res) and thus always report "Operation not permitted" no
matter why the send, receive or filter setup actually failed (for example
ENETDOWN when the interface goes down mid-ping or ENOMEM when attaching the
socket filter). The other error paths of these functions already return
proper negative errno values.

Convert the syscall failures to -errno before returning them.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 icmp_helper.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/icmp_helper.c b/icmp_helper.c
index 15bae9a..65a2005 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -154,7 +154,7 @@ static int icmp_interface_filter(int sock, int uid)
 
 	if (setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &filter,
 		       sizeof(filter)))
-		return -1;
+		return -errno;
 
 	return 0;
 }
@@ -348,6 +348,7 @@ static int icmp_interface_send(struct batadv_icmp_header *icmp_packet,
 {
 	struct ether_header header;
 	struct iovec vector[2];
+	ssize_t ret;
 
 	header.ether_type = htons(ETH_P_BATMAN);
 	memcpy(header.ether_shost, iface->mac, ETH_ALEN);
@@ -358,7 +359,11 @@ static int icmp_interface_send(struct batadv_icmp_header *icmp_packet,
 	vector[1].iov_base = icmp_packet;
 	vector[1].iov_len  = packet_len;
 
-	return (int)writev(iface->sock, vector, 2);
+	ret = writev(iface->sock, vector, 2);
+	if (ret < 0)
+		return -errno;
+
+	return (int)ret;
 }
 
 int icmp_interface_write(struct state *state,
@@ -494,9 +499,12 @@ ssize_t icmp_interface_read(struct batadv_icmp_header *icmp_packet, size_t len,
 	max_sock = icmp_interface_preselect(&read_sockets);
 
 	res = select(max_sock, &read_sockets, NULL, NULL, tv);
-	/* timeout, or < 0 error */
-	if (res <= 0)
-		return res;
+	if (res < 0)
+		return -errno;
+
+	/* timeout */
+	if (res == 0)
+		return 0;
 
 	read_sock = icmp_interface_get_read_sock(&read_sockets, &iface);
 	if (read_sock < 0)
@@ -509,7 +517,7 @@ ssize_t icmp_interface_read(struct batadv_icmp_header *icmp_packet, size_t len,
 
 	read_len = readv(read_sock, vector, 2);
 	if (read_len < 0)
-		return read_len;
+		return -errno;
 
 	if (read_len < ETH_HLEN)
 		goto retry;

-- 
2.47.3

