Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E994E77198
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 20:38:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0D85E84096
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 21:38:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736282308;
 b=fRvG11KeJRJKjn6KYdfp4/7A3iCNMIpFLKwGySkGohhuoKvIUViC11XV9ToYVMikR0z5C
 trWVRAbgdrLjMypHub0x8XsUs0MLxqAnJDXgUU2Q0NNTAU2oXz7YdrfOF5f82bEr2LtTqzb
 hmjPnTTeuxwmLGF0DEYgD8kNGP68BHI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736282308; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ry/wKusF7/g6o+vQkav6he8DpFFbjDZCwBXGA4Z980I=;
 b=xsxbpWnfP/9GO5Jv2RUr3WcH650MuZp9Nstekc3sos6inXuHFsJb+UZ0EpRYSQCFtwCql
 EJsCB62BkbZ971JP9IfIsUGKPQ9D4FXkiS25YMtJqOyJZlt3T6MT1AYiBu8rRxQgmxp3JpH
 KqE9Tb04j4YbujRw9fDjSE2wZ+SBdv0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1654C817A8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Jan 2025 21:38:09 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736282289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ry/wKusF7/g6o+vQkav6he8DpFFbjDZCwBXGA4Z980I=;
	b=hFtbCMwYbWpMDZ6nZEpdVJ8YOsLEuVjtbXcvKv9pib40f3pRpkSiZoWBC8+lRDtYjhXX8g
	9UeoVeokxSolcvHELvSsxEDwwxaLNX+sKs0rVev4nFxumsLRLMpkNRzHQbB0QlJoItounZ
	GNNpCvGPGhEydqAEChj9KLoJrIoxid0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=IincHyk5;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 139.178.84.217 as permitted sender) smtp.mailfrom=kuba@kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736282289; a=rsa-sha256;
	cv=none;
	b=amNVgheHxbDR6x0odkawhBPNf/tH1m+5t9/6XxHS6+TXKd81nExWQ+HB4+TK/bhqZfMDep
	KLt/rTRhKjjntfhpmiwGlOm+8QJ3kIxR4VmO8VtT/80JmR+jJfBST562nYOXg2Q7yVPd4T
	siMLM6NwhiYFKzGWyBft4zT4fmwXhac=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8AB125C5EAC;
	Tue,  7 Jan 2025 20:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D5C4CED6;
	Tue,  7 Jan 2025 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736282287;
	bh=xVENo9muNO/TQ5xVqUKOs/5Q4+G96PW1sKSnQr73q9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IincHyk5dnHSj14WBxB3nZ8H+ad7Wv7JCDFqB3ioz1CyxVIL28f/wayA5OfnPboFy
	 w4bYeV8oyIpNsDF2th/1YTvksDeeiWBKLOGweUN5unnHCsYuY6UO9/ov33L1S7sVm+
	 1K3BnLtTw6iZPtOBVnjoMMzolL2SbZULRRKu+YNbYACOMPPIofT1Am+zEPd/PAx/vs
	 ld0p/Rkjj2unh6Png65S7WHaBoyC3nNe0ZjG8UBnxGV+bt8cBPNwF55J92ceGMmf0M
	 9p3XnJzVS37fvnQRlLFc7Do5qJjEPxgQYy5375IiG9MyjZthi5D9QPQCuQtvR2QVYT
	 LbPjcwrrJqcnA==
Date: Tue, 7 Jan 2025 12:38:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into
 struct
Message-ID: <20250107123805.748080ab@kernel.org>
In-Reply-To: <20250104125732.17335-3-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
	<20250104125732.17335-3-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 2ATU5DQ3DIHU522TJFA3OGNYVCDDBJNG
X-Message-ID-Hash: 2ATU5DQ3DIHU522TJFA3OGNYVCDDBJNG
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2ATU5DQ3DIHU522TJFA3OGNYVCDDBJNG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat,  4 Jan 2025 20:57:23 +0800 Xiao Liang wrote:
> -static int amt_newlink(struct net *net, struct net_device *dev,
> -		       struct nlattr *tb[], struct nlattr *data[],
> -		       struct netlink_ext_ack *extack)
> +static int amt_newlink(struct rtnl_newlink_params *params)
>  {
> -	struct amt_dev *amt = netdev_priv(dev);
> +	struct netlink_ext_ack *extack = params->extack;
> +	struct net_device *dev = params->dev;
> +	struct nlattr **data = params->data;
> +	struct nlattr **tb = params->tb;
> +	struct net *net = params->net;
> +	struct amt_dev *amt;

IMHO you packed a little too much into the struct.
Could you take the dev and the extack back out?
