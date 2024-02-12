Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2ACC48297
	for <batman-adv@archiver.kernel.org>; Mon, 12 Feb 2024 13:32:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 64CF08181A
	for <batman-adv@archiver.kernel.org>; Mon, 12 Feb 2024 14:32:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1707744742;
 b=B8eXOEgJe6gaEJ7JliWvCNRTo8N5hsO5Oob1NhoRE1PlSb4Bu2yAjzDN09yii7XtSuyjY
 wRIEE/JBIl5qAkCFe4t1Nnqyr+vPuqKc5Iwfy2bkE7hfELHWUl92kqpvZ+7/EwektJOy0HP
 wWGLsTvCJgW1tEE8X+hPcPsFNrFZ1Zo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1707744742; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yp8aYGU4sAFMtZ7+4I4BJH7bdbpFxkMOY3DfGzS3ASo=;
 b=N0PRVVVq52nR3zJ3ECQG6znmqzBSlRKqysV8yDn0wCCAZGllnhnLcXrcP8puFVBjbY4wu
 uA0D7bb4ELZvEuFrt0mgWGUqNTPFKiZv5RRcQUAcAEtZJ/3cvNm05wN1AdxaAAd1XyJtT4m
 zin7AcSO978Mwu59XcLbPqC8jGJj2zg=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9C7FC8056F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 12 Feb 2024 14:32:19 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1707744739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=yp8aYGU4sAFMtZ7+4I4BJH7bdbpFxkMOY3DfGzS3ASo=;
	b=TlEaF/AjgLKsdo/rdPXd643XUGWOidRdSrsgAThi90gTKJGIviF3QDoEBC7aR+d4D/hfxy
	X57BO2RplJ4pQCjIbCY7zgXqamhiD9b+KPb1a2p3gVSjJ0Nu3Bf9D+m153MXG9wxoT8cEg
	yu2HuluE55LQaRUYBk9RIW1RphM90Hg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="vlT/Hn6I";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1707744739; a=rsa-sha256;
	cv=none;
	b=xV47zUbU+W8Ga87xpEi+Y1gQ9VGHvGNaUWdMjAohG//oBOe+h/+GxRdIStzsC5SNwIu+fW
	qo0Iab4ySNYmpcrC6bt+7L+8qxRHTYR6MPlthGggpt5/D2uDNNFiwmpsJfTB7wTxfU8kkb
	z/C7vknAza1EvREcD7iKn/ILwrlgQ44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1707744739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yp8aYGU4sAFMtZ7+4I4BJH7bdbpFxkMOY3DfGzS3ASo=;
	b=vlT/Hn6IfoNtOmEAV1dByYpQS6768dGih3T8cWFWJrXPn78lPET971JipxB/zSH9RWfmXK
	lRN+1D3BNXA5VoiL2L5wEKk4hWAOZXTPRsAukGGE5qOCSShRQTdbFq5VIqaAxJI7ptp1R7
	AD3MiQSlKz4z0p9y71SRegmbXiII4/4=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH] batman-adv: Avoid infinite loop trying to resize local TT
Date: Mon, 12 Feb 2024 14:32:13 +0100
Message-Id: <20240212-infinite-tt-resize-v1-1-6644e31d2368@narfation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2807; i=sven@narfation.org;
 h=from:subject:message-id; bh=uM3BdhC6In+fMPSg0jWd2BIKpNz/pOCD1gDhzSWJGlw=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlyh23LKjCcpKVi/0s0/EVMY8mi/hZQrcexOBLc
 3r2j9qEV7yJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZcodtwAKCRBdhwoHwSZ7
 Rn+vEACmAzNBM0ss95PnAkp2zGbQ/KAUUT3Vayv4U3kIR2J/EecyjX7PyxA8wpha1pm30p7JP1r
 XmzRuFNLlhe2NVYipNW7848TZ5jCsYpBxazOQOKDHg39JZa2DHsZbuzonV/raxPtNkTo+eVNifd
 3e2s/TLxLcQTAvHbjNX1MzqH3y7LpIYvz1yo/2xNnSqb/XusrYLUmLE3ZiCjlCPrtab6oaxhRGA
 lEXtqa0ILUING8GGU8QjU2Knm2RsczMFwslRWmj1OrrLnvMCvIzF8CS003P6cDtAvmcA9n8iuny
 2b54kzq7e8tpDuo1yJ8bvQ7g2MJklMiPmrXjszzR7HcCv/fogW/If4oaewQjAVzk0Zp3HPwtY7V
 BJWp634cQ5OFXc8tfZpOcwx2sMtKwjyHgjGybE0Z1bTudn37lhCbluV4JTv6vZcY7EDgFWA32ce
 mgHyrKFDIFYacOJUDQvNMMgiChlirEltuTkK3+BLC51c8UDrRuNtGoVGZXub3uHlpPlKWo749+N
 yoObBK2HMCkRy4oz5+gdM9Obc25D547P6vaimOfdYcDml6ZuI7ZiG6rP5tKOLXepgquXn59a+Mu
 znCdAXIjOrCDfDwQgvowpT6H8J8F68bFqptn0IS4d9BRRNqI+6K7x28hmcX/m11VjlefBjQlnta
 9VBv4Yyi7/
 zvHww==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5NIYEVSC5ZIKVMDYLP3NBNMS65IX5NFO
X-Message-ID-Hash: 5NIYEVSC5ZIKVMDYLP3NBNMS65IX5NFO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5NIYEVSC5ZIKVMDYLP3NBNMS65IX5NFO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If the MTU of one of an attached interface becomes too small to transmit
the local translation table then it must be resized to fit inside all
fragments (when enabled) or a single packet.

But if the MTU becomes too low to transmit even the header + the VLAN
specific part then the resizing of the local TT will never succeed. This
can for example happen when the usable space is 110 bytes and 11 VLANs are
on top of batman-adv. In this case, at least 116 byte would be needed.
There will just be an endless spam of

   batman_adv: batadv0: Forced to purge local tt entries to fit new maximum fragment MTU (110)

in the log but the function will never finish. Problem here is that the
timeout will be halved all the time and will then stagnate at 0 and
therefore never be able to reduce the table even more.

There are other scenarios possible with a similar result. The number of
BATADV_TT_CLIENT_NOPURGE entries in the local TT can for example be too
high to fit inside a packet. Such a scenario can therefore happen also with
only a single VLAN + 7 non-purgable addresses - requiring at least 120
bytes.

While this should be handled proactively when:

* interface with too low MTU is added
* VLAN is added
* non-purgeable local mac is added
* MTU of an attached interface is reduced
* fragmentation setting gets disabled (which most likely requires dropping
  attached interfaces)

not all of these scenarios can be prevented because batman-adv is only
consuming events without the the possibility to prevent these actions
(non-purgable MAC address added, MTU of an attached interface is reduced).
It is therefore necessary to also make sure that the code is able to handle
also the situations when there were already incompatible system
configuration are present.

Cc:  <stable@vger.kernel.org>
Fixes: f7f2fe494388 ("batman-adv: limit local translation table max size")
Reported-by:  <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b95c3676..2243cec1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3948,7 +3948,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 
-	while (true) {
+	while (timeout) {
 		table_size = batadv_tt_local_table_transmit_size(bat_priv);
 		if (packet_size_max >= table_size)
 			break;

---
base-commit: 7d30b5a06020e8c4e53968e4086a0fa6e9fdd947
change-id: 20240212-infinite-tt-resize-285a0d33fff8

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

