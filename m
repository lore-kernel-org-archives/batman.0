Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3059FC67861
	for <batman-adv@archiver.kernel.org>; Mon,  8 Apr 2024 08:29:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41DA481B14
	for <batman-adv@archiver.kernel.org>; Mon,  8 Apr 2024 10:29:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712564954;
 b=SOK2Dcp48SVhpF/giaEXigUH4ZxQu83WEcVUDBdzajxBuv3inAk455RYeucW/2Kl9ikcp
 a6Bt+FjGAZsPfp7hIpcE+y/iqqrCS9O2qGPPzhs0vXSpw+dyA6k4My1fHM8VN5TFSvNz5sj
 +deH11pHBz+fh/LVBxzytHo/QNGnlPU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712564954; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DVF+OMLqU+a3aYTHEfiGosps7ILyY58ARcRwVurmy7Y=;
 b=l2cH3aME6rC/0MorENdwsoIEgoZ7uQeZNaoPplBJ7+XgtVcaGNGSa3OKpfYowXlY34vHc
 hTFxXxPUkyzSgLaKsdjG47cQ26XM0RtwX3Z7+oyLZZi5qXFKGkAiQyr87Ais/q4R580Rma3
 qcU/fsjG/auhtV8lL+OvBUp3zvd5JK8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s2.neomailbox.net (s2.neomailbox.net [5.148.176.60])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C97E080E79
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  8 Apr 2024 10:29:02 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712564943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVF+OMLqU+a3aYTHEfiGosps7ILyY58ARcRwVurmy7Y=;
	b=ge6ogmaa20Vt/MHLoqnmQ5QZJ5oKfOVBqFHKUmzza8xZAmehj8byD4dt3MMwy04KFs+Laq
	HtCCaKdlEwXKbRCqbdyV/B2M/s0kkLbEm5JTltbWBOV5/sce5zYWw8a1PWV+6K9NfmLa2S
	AtsALP6Yc4dy6Z54H24ysEgW5j/bJrs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.60 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1712564943; a=rsa-sha256;
	cv=none;
	b=gGwl+xTrvjlYVSZCQqjXxrYp/4okLsrqR+TCJtoUB5TX6kIZK8RCex8A7f1vnYY4fRTJgo
	YBnzOnw6zopLlzjLckFo3sCqehU9gXST1yUnaROuJsXHia88AwFARYsPzix/b+IuBvLUpw
	q6uVPWPyn1bkMT/ACMXt0CrRpfmxlh0=
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: About Throughput in BATMAN_V
Date: Mon, 08 Apr 2024 10:28:57 +0200
Message-ID: <2066205.UkFFEUeh36@rousseau>
In-Reply-To: <171230441622.1066.17238774576163032219@diktynna.open-mesh.org>
References: 
 <3327582.AxlXzFCzgd@rousseau>
 <171230441622.1066.17238774576163032219@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: CXBHO2BWV2NXIKF3K4HWHHSSXJRM7IXA
X-Message-ID-Hash: CXBHO2BWV2NXIKF3K4HWHHSSXJRM7IXA
X-MailFrom: mareklindner@neomailbox.ch
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CXBHO2BWV2NXIKF3K4HWHHSSXJRM7IXA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Friday, 5 April 2024 10:06:56 CEST berkay.demirci@protonmail.com wrote:
> We also did tests in virtual environment and according to this commit
> https://git.open-mesh.org/batman-adv.git/commit/6e860b3d5e4147bafcda32bf9b3
> e769926f232c5, ethtool link speed detection used to be disabled for such
> cases but got reverted since automatic measurements aren't implemented.

No. Batman-adv used the ethtool 'auto-negotiation' on/off state to decide 
whether the the ethtool throughput value should be trusted.

As the commit states, the 'auto-negotiation' state has no impact on whether 
the reported throughput value should be trusted. Auto-negotiation could be on 
or off and still the value is wrong.


> dynamically calculating throughput is a must because like I said, one of our
> modems have a shorter distance range so it is faster when two nodes are
> close but as nodes move away, there is lots of packet loss so the real
> throughput drops as well, but with overriden throughput value stays the
> same.

You keep keep mentioning "modems have distance", "move away", "ethtool", etc 
without having explained what your setup is. Without providing details about 
these "modems with range" and what interface types you are talking about, 
nobody can really comment on your setup.  


> I see that the last patch for tp fallback was written in 2018, has there
> been no more progress since then? And what are the problems with it?

The main obstacle is time & energy to work on the tp fallback integration. 
Open issues were mentioned in the responses to the various patches.

f you are interested n spending time on these patches, I am happy to provide 
assistance.

Cheers,
Marek



