Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ADCC982D0
	for <batman-adv@archiver.kernel.org>; Sun, 20 Sep 2026 06:43:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1227183FBD
	for <batman-adv@archiver.kernel.org>; Sun, 20 Sep 2026 08:43:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789886616;
 b=DFjrsASUQ574IIkkH1PTLG+I1tzylZ+YlSYvJPPaYWnxXFs9uNpdOQfJnoEjnlYRwA0Te
 NXe0ytsBkcLUmizL2Q+onSszQBW3xQv7M/QGPvabZuY86vBJqjM0+pthUJAfZ2MNsBOQHRj
 9Q2P9v6KvhMQvcqAYJkOzfzmuLoIypk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789886616; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AmfOpn0VWWy3Tsnz0UM5QQh4OihdaMTq/EtZTTj9KQk=;
 b=wqd7rL6iddMZmcGkRms7lWhahsl+uRr7nisT1W1Djd7wwHNLfTxtrnxmdMTyPjSHRsxEi
 ZKN95yWSiFamo1VCQ/rLG3co45WxTENuJPg5u8lDVL+xsxL843i3Oc9S7WmkwjEVO3HaFuG
 12ZrxeB5IQPcnMTDTuwRRS4EAzay/F8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E07B6817C3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 20 Sep 2026 08:43:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789886605;
	b=1y4TEWf/c69Ps1G6t+yo0TXgjtrjN2QLtX1WPhUZccZpO+JBNEGC0GZxL+uFyx4mO4QKYg
	A1k0fZ1tUHILEGLmOqLMLRo+Gqss/Cyk15iTqRYV15ASqAQuk8xKbAaKvbpSDHuoBT+jzw
	0JGIyl0fka+Ey1cETpl/J7Apdv4mv/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789886605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AmfOpn0VWWy3Tsnz0UM5QQh4OihdaMTq/EtZTTj9KQk=;
	b=TomdHHjZfH2OfguPM4C7R1BhyzV8P/FOmDpt0+pUAD1Iqu/37mnx8uNul7rvrIC2MVkfLl
	JMcfT75onxfd39hy9ei7pnzbzaQl7bd8EE7Nu2JujROX4ZbCNcGuCFFBWC6RnLTZ0cnk7G
	UzDjkCh+pxVvATBo5ErkMp0XRUZVB0I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vzz0AJbg;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id BF3BC200E4;
	Sun, 20 Sep 2026 06:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1789886592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmfOpn0VWWy3Tsnz0UM5QQh4OihdaMTq/EtZTTj9KQk=;
	b=vzz0AJbgAhUeDHqksixpZnVxz6A1xpmFfdyx4PqbuDFvOBRhvFV0AxdRDMMvOIODVcDoc5
	7+2UNPMtmqhR6kCg6oDNgBpGabJfaupatXPRgKH88b/6fi9U5n6211Na0q/Kf6DmK2IM1l
	SmhRXiGdbUvI9vFX0w17bZHl2Y5Ug04=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 b.a.t.m.a.n@lists.open-mesh.org
In-Reply-To: <20260920022722.3145774-1-peng.fan@oss.nxp.com>
References: <20260920022722.3145774-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] batman-adv: use assign_bit() where applicable
Message-Id: <178988658272.12473.15213520390601170124.b4-ty@b4>
Date: Sun, 20 Sep 2026 08:43:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=297; i=sven@narfation.org;
 h=from:subject:message-id; bh=xDxiweT7X4s66vbzudAwklUnEm4le5OIOMnHIbcdNTA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnrG6oPPsn9LBgg+P5I4uIvKQz7VN9dcNz5+9HuB1/st
 Tsyi3bM6ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMxOYfwx8uyShWX+ZDYuEp
 UkeSPRQZ+Owfu69+e4Dvh3r7KgX+R5cZGaZpBzluOb130xMLqRfRJ4PUBG5WW/Gu3htv6t/0/eW
 qWZwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 725MLINVGKYXEAANGMQV5DOK7TPUB2HL
X-Message-ID-Hash: 725MLINVGKYXEAANGMQV5DOK7TPUB2HL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/725MLINVGKYXEAANGMQV5DOK7TPUB2HL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Sun, 20 Sep 2026 10:27:21 +0800, Peng Fan (OSS) wrote:
> batman-adv: use assign_bit() where applicable

Applied, thanks!

[1/1] batman-adv: use assign_bit() where applicable
      https://git.open-mesh.org/batadv/c/5afe6b0d034e

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

