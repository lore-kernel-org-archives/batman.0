Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB2606A31C
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=iQV88Kd5
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2D82683E9B
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 10:18:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793351906;
 b=RAILCm2JYzBrmcSh/+xTPkpIZDKjmgMBG0pJ/dWtQOn6AFbI/6mDOnKx4TME21+slQJ0D
 HeV+xkpV0Za2ANf9Wy+1TM9SK287ievoQGh8mLkBvrhisuR9QsS4AEDly1ZWcuKFdbRMzvN
 ISaCxD70blMYFEmamyS+ggwyMsyci8A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793351906; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HmQXP6gzBGluuaBJcSrqbODuk2l6xoC3Nu7Ij2eiUxc=;
 b=Ckdaojpl3XY89xWOHjO192MrDgdsLIqTU8ZbEsuvoFhpU1snB4BKqQFnIQNsU4rJRwWMp
 SJf0Buuv3EB3ZJTavq3FdHZhZvboj3uP3NiVHWDicrjHJXWMVb3dpF0UrvJxuvhn07WBP8p
 zh/yecZ/8AxX6SkkYwg3ZQkHCPTIT6g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 94BE080A77
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 10:17:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793351890;
	b=Z6tfxJchg1YPw9/cHyfyn4pltZlfp03Ot/kYHemrChoeRhDZ8HiT1U1+H2/HWJZdXs04ul
	UCtyIaYE/PyDXOz/PX84040nomuCPp42qTZ0rvw3BNZHQpGnmbL8luv2/m0jWNMxFwWfeL
	4XIJ7k6MsQFW5hs4m041XId+l2GILBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793351890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HmQXP6gzBGluuaBJcSrqbODuk2l6xoC3Nu7Ij2eiUxc=;
	b=zB/+wqDhqjy2uARZ7c93pVcwdu3/Sr94EXlKVFmlSBLPjKwKhX3lbz0wsEkvebIQsUPXKz
	uA0D5rmWb5N9aUWFlkabOYAfEeWtE0+vY2Dr/Sik2I2/lmzhYjr4/RyDoCjDgNHu7A2CCA
	NRJLxIxD+2m9tcFCq/kuWonIbcKSdls=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iQV88Kd5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2E2BC1FF7B;
	Fri, 30 Oct 2026 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793351879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmQXP6gzBGluuaBJcSrqbODuk2l6xoC3Nu7Ij2eiUxc=;
	b=iQV88Kd5x3Gh8mrDdTDvRVUuGFJ9F9Fs+InmShzfW4YwDZXvL0dMII87kkv43vDBSEVvtr
	S+uV0iMUO69AOnvS4Bsu5LD9cijeGI2i5r0nvW7XUhdWyzEFY6C7cG2knWdSiWbJeavNmb
	xIfCzWhZ4jQv9qU1nPR2XJd3GB/pcws=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Kyle Zeng <kylebot@openai.com>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
In-Reply-To: <20261030042146.73797-1-kylebot@openai.com>
References: <20261030042146.73797-1-kylebot@openai.com>
Subject: Re: [PATCH] batman-adv: mcast: validate tracker padding before
 forwarding
Message-Id: <179335159629.2015734.12351778845482914326.b4-ty@b4>
Date: Fri, 30 Oct 2026 10:13:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=sven@narfation.org;
 h=from:subject:message-id; bh=VCz6BsN4NIu5OO60GpB6VBIoiCYJ/C2oF5GKMYuBNQI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlPEo6I1PX9LEisLgnznlssHbojUHVPTAhr/rT+i7JWa
 z/5NP3vKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExk2y+GfwbMxe+3xp7wMLFy
 UX1w5P2idqa+q/1B656G7tCOLvh4/iTDf/fNrG/y7/9Jz0x4ud+hKrTj34S78xueaZ7pdencw9M
 qyQ0A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MHDFID4TXWCJK7UUGXIQCABTZKEX2634
X-Message-ID-Hash: MHDFID4TXWCJK7UUGXIQCABTZKEX2634
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MHDFID4TXWCJK7UUGXIQCABTZKEX2634/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 29 Oct 2026 21:21:46 -0700, Kyle Zeng wrote:
> batman-adv: mcast: validate tracker padding before forwarding

Applied, thanks!

[1/1] batman-adv: mcast: validate tracker padding before forwarding
      https://git.open-mesh.org/batadv/c/ea01fff30f63

Just two minor nitpicks:

Please add 'batadv' to the subject prefix '[PATCH batadv]' to make it more
clear what tree is the target. In this case, it was clear because this (single)
patch series only went to the linux-kernel and the b.a.t.m.a.n mailing list.
And no one picks patches from the former.

The other one: d89e1d186ec9271bf78e62771779e9fc03bf0fc3 is here the base
commit. But it is not even in our tree. Please try to use a recent version of
the target tree to make sure that it applies cleanly and that you are actually
testing against the correct source code. The other patch which came in today
had for example conflicts. Yours luckily not.

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

