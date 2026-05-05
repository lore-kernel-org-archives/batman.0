Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1846FCD3427
	for <batman-adv@archiver.kernel.org>; Tue,  5 May 2026 18:32:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5448282214
	for <batman-adv@archiver.kernel.org>; Tue, 05 May 2026 20:32:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778005947;
 b=gdtLtFvd8H/+sUfrqpKZhSyOjp6Q2R5PdQB6N0H+J+4B18MIlUJPyd6atcMytsZVggLMl
 KcLRbwKWrZ65MvGQXj/q5usoS/P1jiExb2cbKhjNAVbcH0l6u3vsDpujw0f/FruX5U+4snr
 hMtjtnl4hLwP47pgnraPjSbot8H8BTY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778005947; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mltUUJ+OSRl3QoGEANutow0sZ3BcVDlcDH82qOKaIYQ=;
 b=YDls9tTQ1R/rH2FRz6ywLYnbDYjTWRoKjIQq/Kb6Gd+zieSVBHdM7o4cyvYSFOqIYlZSA
 JCpuwQHK1J0RQul8ZDH4pDXuvWQxHqqP3nGoaS6jxOKWNH+SrYmuR0qZkrhnF6W0lG3gZ30
 4QQyMt7beERrcH+EqNnHkt71315DlCU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E962E8065E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 05 May 2026 20:32:08 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778005939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mltUUJ+OSRl3QoGEANutow0sZ3BcVDlcDH82qOKaIYQ=;
	b=BcyU7hJBAwaH8M7QSpZ8DbUCjrKdNMsT1ihNCUxeVI4Aoh5tEZ+dNeTEWWQC89wwp3mCt0
	5PLClBhJwb0nAikwdEmdV9uTBPHaF+E1t21/Gw2qwYn2AihhgwwkHdWcilkk2xQ1xgZVIB
	VnMrPkJ3LXPzU2gLr3IgHqEj+6ghC2I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KuEcWPi9;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778005939;
	b=p4Aia2Wg6RecVpTbSfyk51jrhwKBWUCdet+npI09iR+8+o6UsXv+dPcUfA2gvHrzyXvlxo
	Ccm4zOsG4zDIOgacCtxpM6/3H2fGEY2q9X5Y5v0a1PoKc+6KitClzo5ADwaX4vH4Jlf3qD
	ZEv9kQeYzVEvlfMlIyxgr2TirhDERy4=
Received: by dvalin.narfation.org (Postfix) id 4FAEB212DF;
	Tue, 05 May 2026 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778005927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mltUUJ+OSRl3QoGEANutow0sZ3BcVDlcDH82qOKaIYQ=;
	b=KuEcWPi9KFrpEogCiLjmN9bH7pdHx0jp/K/7rAUZcPqseuAKlwejzQD+XyvxZAXi7q/cZW
	YRY/ly6eflGTWR7eDZY1IRNjjdCKiOth1uaUcpCGYVrGxiKWLqGItBt35YGz+vEiNtwkYY
	wbOuewHya9I5o7Re63hE/5OiIIZx8to=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 Ren Wei <n05ec@lzu.edu.cn>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 wangjiexun2025@gmail.com
In-Reply-To: 
 <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
References: 
 <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
Subject: Re: [PATCH net 1/1] batman-adv: stop caching unowned originator
 pointers in BAT IV
Message-Id: <177800587225.49931.6032285199258231121.b4-ty@b4>
Date: Tue, 05 May 2026 20:31:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=324; i=sven@narfation.org;
 h=from:subject:message-id; bh=UtJXbJ/pLCTorOy0ebCQ05ZckwTdS30cLePcNmLRwFA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/zDuf6c0/dq+B3Xbjbq4AjvYS281VgTsWvV93PXLbo
 5ebTzyM7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJGoFw/8049a9/59Vt9w6
 fTzu+9XnSxesfdf6TV1I7U3MBMa/Zaf0GP57x+a1fQuJWLn+9bbcyTGVByJ3S5oHbGWLUzfVP2r
 7IoQVAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 66SF5IUBEQ252HR5GH7T7EJAIV22XSK4
X-Message-ID-Hash: 66SF5IUBEQ252HR5GH7T7EJAIV22XSK4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/66SF5IUBEQ252HR5GH7T7EJAIV22XSK4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Sun, 03 May 2026 12:28:58 +0800, Ren Wei wrote:
> batman-adv: stop caching unowned originator pointers in BAT IV

Applied, thanks!

[1/1] batman-adv: stop caching unowned originator pointers in BAT IV
      https://git.open-mesh.org/batadv/c/37760490adc1

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

