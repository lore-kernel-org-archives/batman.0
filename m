Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523AA606A31A
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=hvOHcBIH
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DF61F830A6
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 13:18:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793103533;
 b=OcTep3e/d6dUhiXv19NWbGOlXVyG33OA4nInbujVpVo1CuLXbiYp64hHqg+0F5u6kVEu7
 +9dBsvsin+A8lnjAa7znzKJFAOHDY4M53Mnd2v6jDoWiBQNx20ddgOV2vaTUyikp0PbOe0l
 4YNFV9tgyQhPvmI1mkEaXbfbiM5HisQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793103533; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c0IunEX04TaNsit88KQcLus9zoNLvzD2jF1hWBlIUOU=;
 b=0j6mS0BialnuEzHwIwrb6cPPD8JF7qfYjeAKtuq2gsgTEKMg/ID3D4ShKqs0DvDviIejS
 hY3KHGyAnrIIBG0GniZKBUhxAIkyeg4BH6HrwRbnlgZVduP9+Dl1+LfRqVvzAZ7E79n7z0F
 DQOQ0hVu0Mc6bIUca5PpRDj6WNLp8Vc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6743981CFF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 13:18:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793103519;
	b=W0Ose5RAxbtmfObNMQrzCZ8ZnDecgvaRxxohT7+QOem1aaCun/qJCK++R6GU0LWzu7t/FQ
	CFwM8/LqyjLlzi373oYjh/EMUWknqp1NMFDGMWHyFSbknKcxiaO9cJldzW6xCJmDV5oklp
	w6J7bw9w/YVUBeCMWi+XJSdKO+XSF0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793103519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=c0IunEX04TaNsit88KQcLus9zoNLvzD2jF1hWBlIUOU=;
	b=Mhr7nUY1wj0hYN2LZQkmPUHr/32m/71q1z7T6kBIMlmc7hhiBMl2NUj1nr3fmvD85UNSkU
	vih2Ctwtw6T5/0sUT1ZB9yun2zCYZaQfg/XPVKYWn1W3Koeb548v7iMqsGfz6tK5z79ABw
	/NueIu1A3YUloFH6BduStbevCKmzvhw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hvOHcBIH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 310B220152;
	Tue, 27 Oct 2026 12:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793103508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c0IunEX04TaNsit88KQcLus9zoNLvzD2jF1hWBlIUOU=;
	b=hvOHcBIH5fQVnyD1yTGhMQt0C1Oj1YrGtf6/sTLlJ7V1iiusWtpQJIlJmbfk9xmbSV4X6y
	1oD2pnjVmNpYizEFDff0OKFaOH0q/FbUmlg0KPPp1ZlJ+q3+RAmaLNT1XSqVb80rgw+hPk
	uFbaNwejkS4R9NqtAVQOM61HoJlRu9g=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 27 Oct 2026 13:18:25 +0100
Subject: [PATCH batadv] batman-adv: document num_packets use as aggregation
 stop marker
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-kdoc-num_packets-v1-1-1fa6d584b7b3@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJCW4GoC/yWMzQrCMBAGX6V8ZwNpDjX6KiKSn42uxbRk0yKUv
 rtRjzMws0GoMAnO3YZCKwtPuUF/6BAeLt9JcWwMo83Qa3NUY5yCysvrNrswUhVl0xCttsmftEf
 L5kKJ37/lBd5VF1dc/14W/6RQvz/s+wf3U93hfAAAAA==
X-Change-ID: 20261027-kdoc-num_packets-8f6d808fb90b
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=sven@narfation.org;
 h=from:subject:message-id; bh=Na/Toj69wD/kb9K6d3bsMImYyj0BxNaZTV2O8WdOfUM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkPpk3cVlNdEbslKOfLWcuvf0N27O0WzDA897QmzElrz
 uRt23uTO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQA3eSIjw8tDEe2GX/YtWf7X
 ta2qoiWqhM1ha1WtzfFV93z9vDmFXBkZTlgdaVv66gbzqo2Ja/dETT25OUyvYNfKr5MnODaYhes
 bswMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FDMMO4FIPFIYLSPPOWBXEJR54RUHS3I5
X-Message-ID-Hash: FDMMO4FIPFIYLSPPOWBXEJR54RUHS3I5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FDMMO4FIPFIYLSPPOWBXEJR54RUHS3I5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The OGM send worker sets num_packets of a forw_packet to
BATADV_MAX_AGGREGATION_PACKETS before emitting it. This marks the
aggregate as full so that no further OGMs get appended while it is
transmitted. After this, num_packets no longer holds the number of
aggregated OGMs.

The kernel-doc still only describes the field as a plain counter.
Document the second use so later readers don't rely on num_packets
to be the actual number of aggregated OGMs.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de?part=2
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c19caa84..b3e6dbb3 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2047,7 +2047,13 @@ struct batadv_forw_packet {
 	/** @direct_link_flags: direct link flags for aggregated OGM packets */
 	DECLARE_BITMAP(direct_link_flags, BATADV_MAX_AGGREGATION_PACKETS);
 
-	/** @num_packets: counter for aggregated OGMv1 packets */
+	/**
+	 * @num_packets: counter for aggregated OGMv1 packets. Set to
+	 *  BATADV_MAX_AGGREGATION_PACKETS (independent of the real number of
+	 *  aggregated packets) by the send worker to prevent further
+	 *  aggregation while the packet is emitted. It must therefore not be
+	 *  used to iterate over the aggregated packets
+	 */
 	u8 num_packets;
 
 	/** @delayed_work: work queue callback item for packet sending */

---
base-commit: 08b79268afb43880f861c12ec9a34d1ccb85ab2f
change-id: 20261027-kdoc-num_packets-8f6d808fb90b

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

