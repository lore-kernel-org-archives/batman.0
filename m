Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C1C02183
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 08:15:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4B082841CB
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 09:15:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736842540;
 b=dCd1S506hFilcslXWxFalCoCIKJarmLu/ZJQlY19quKAotHjDesaZJSzS87zTaDOrc3zx
 F8UYEvy6oqZilV5ULCT4EVdBRvriWDhAAsDdqbWMm/IIk7UBv3RdpyXFTJgRi2kzD1u3c5p
 n2VGN8j+ixiv6HRklNJLDJREDyxy9w0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736842540; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A4qSpa9PKTl3u7k1DQyLqfv8mgl5yR42K0bhyD7dYtE=;
 b=wjEYMhqx2InZpHogh75QhkCpvqnf/NwtGeiU0BUODRDwPayRQoKch3ujbchVSF7YRMqtm
 uYtel6mVPgFpEQqAldIMbkHe/VJwPhDFR0zLGL7j7dboDh/H6adk2EyRqx6yphndZu9zZEe
 lpCoKGjpBc9SsCqg8NAjkp9qeRNOqnY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com
 [52.119.213.152])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7F6F280029
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 14 Jan 2025 05:49:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736830199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=A4qSpa9PKTl3u7k1DQyLqfv8mgl5yR42K0bhyD7dYtE=;
	b=DG2yE8WA1DBNkiVa3TUArMg52d3pGFdRpn6N3EIeYk2tFw64/0aMl0SscOf5/tkkXRR0jS
	wEcN+vjgF7yupyjh7JBIwDDYC4sWZxRXjDNPyuiQtfAlZRUkVSz8C3gGF7XBfdTDaw03QV
	jmGbxhNNF47XswFhz/4RjAOGleTSSEQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=QB56+pzm;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=102578ec8=kuniyu@amazon.co.jp" designates 52.119.213.152 as permitted
 sender) smtp.mailfrom="prvs=102578ec8=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736830199; a=rsa-sha256;
	cv=none;
	b=DPS1KQHWHcxzsjlNq2IoWBYFgEByeHULwq4JBAmXhZpnOy40hdOCJLaOu7L+1Z0zThAIhc
	0bNUY7fqfANI/UI1gkhqH42sPhUAq2OSzdrc8+1KQoLEMgtaA0PDP/Q+ffb3Bk+tIm6nUc
	XEfFFnJBJMaJLFe01yX1X04cTNWEFBU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736830200; x=1768366200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4qSpa9PKTl3u7k1DQyLqfv8mgl5yR42K0bhyD7dYtE=;
  b=QB56+pzmCSrMo3b5ebDz1z/8SVIJZU+G3IqcVxaXA9WhdMjzTbQXDZEX
   S7hULpzuyMJnUr8+j4KPRvDOT0Q2KcJOyIM6Ko2+9Wkkmk8tJsQrs91pD
   39I4qcG9tYFI6Vy0C7jwQlNDtGnuQUt1IpU87BizacCUxr2MQEjp9IN93
   A=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400";
   d="scan'208";a="57499934"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 04:49:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:22602]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.93:2525]
 with esmtp (Farcaster)
 id 7019b803-c524-49e9-8de0-4c37547d545c;
 Tue, 14 Jan 2025 04:49:53 +0000 (UTC)
X-Farcaster-Flow-ID: 7019b803-c524-49e9-8de0-4c37547d545c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 04:49:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 04:49:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <alex.aring@gmail.com>, <andrew+netdev@lunn.ch>,
	<b.a.t.m.a.n@lists.open-mesh.org>, <bpf@vger.kernel.org>,
	<bridge@lists.linux.dev>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <osmocom-net-gprs@lists.osmocom.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v8 06/11] net: ipv6: Use link netns in newlink()
 of rtnl_link_ops
Date: Tue, 14 Jan 2025 13:49:35 +0900
Message-ID: <20250114044935.26418-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250113143719.7948-3-shaw.leon@gmail.com>
References: <20250113143719.7948-3-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.11.99]
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=102578ec8=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: CUMISOOVEYFHY52BKZA64BWYQTKLGQOT
X-Message-ID-Hash: CUMISOOVEYFHY52BKZA64BWYQTKLGQOT
X-Mailman-Approved-At: Tue, 14 Jan 2025 09:14:47 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CUMISOOVEYFHY52BKZA64BWYQTKLGQOT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 13 Jan 2025 22:37:14 +0800
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 2a6a424806aa..ac5e402c34bc 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -564,10 +564,12 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>  	return 0;
>  }
>  
> -static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
> -			struct nlattr *tb[], struct nlattr *data[],
> +static int bond_newlink(struct net_device *bond_dev,
> +			struct rtnl_newlink_params *params,
>  			struct netlink_ext_ack *extack)
>  {
> +	struct nlattr **data = params->data;
> +	struct nlattr **tb = params->tb;
>  	int err;
>  
>  	err = bond_changelink(bond_dev, tb, data, extack);

Note that IFLA_BOND_ACTIVE_SLAVE uses dev_net(dev) for
__dev_get_by_index().


[...]
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index fed4fe2a4748..0c496aa1f706 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1565,11 +1565,12 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(macvlan_common_newlink);
>  
> -static int macvlan_newlink(struct net *src_net, struct net_device *dev,
> -			   struct nlattr *tb[], struct nlattr *data[],
> +static int macvlan_newlink(struct net_device *dev,
> +			   struct rtnl_newlink_params *params,
>  			   struct netlink_ext_ack *extack)
>  {
> -	return macvlan_common_newlink(src_net, dev, tb, data, extack);
> +	return macvlan_common_newlink(params->net, dev, params->tb,
> +				      params->data, extack);

Pass params as is as you did for ipvlan_link_new().

Same for macvtap_newlink().


[...]
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 1e1b00756be7..1e9eadc77da2 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -327,10 +327,13 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
>  
>  static struct rtnl_link_ops netkit_link_ops;
>  
> -static int netkit_new_link(struct net *peer_net, struct net_device *dev,
> -			   struct nlattr *tb[], struct nlattr *data[],
> +static int netkit_new_link(struct net_device *dev,
> +			   struct rtnl_newlink_params *params,
>  			   struct netlink_ext_ack *extack)
>  {
> +	struct nlattr **data = params->data;
> +	struct net *peer_net = params->net;
> +	struct nlattr **tb = params->tb;

nit: please keep the reverse xmas tree order.


>  	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;

you can define *tbp here and initialise it later.

  	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp, *attr;

>  	enum netkit_action policy_prim = NETKIT_PASS;
>  	enum netkit_action policy_peer = NETKIT_PASS;


[...]
> @@ -1064,6 +1067,11 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
>  	struct net_device *dev;
>  	struct nlmsghdr *nlh;
>  	struct sk_buff *msg;
> +	struct rtnl_newlink_params params = {
> +		.net = &init_net,
> +		.tb = tb,
> +		.data = data,
> +	};

nit: Reverse xmas tree order


[...]
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ec98349b9620..7ff5e96f6ba7 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3766,6 +3766,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
>  	struct net_device *dev;
>  	char ifname[IFNAMSIZ];
>  	int err;
> +	struct rtnl_newlink_params params = {

nit: Reverse xmas tree order


> +		.net = net,

Use sock_net(skb->sk) directly here and remove net defined above,
which is no longer used in this function.

---8<---
        unsigned char name_assign_type = NET_NAME_USER;
        struct rtnl_newlink_params params = {
                .net = sock_net(skb->sk),
                .src_net = net,
                .link_net = link_net,
                .peer_net = peer_net,
                .tb = tb,
                .data = data,
        };
        u32 portid = NETLINK_CB(skb).portid;
---8<---


[...]
> @@ -1698,6 +1702,10 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
>  	LIST_HEAD(list_kill);
>  	struct ip_tunnel *t;
>  	int err;
> +	struct rtnl_newlink_params params = {
> +		.net = net,
> +		.tb = tb,
> +	};
>  
>  	memset(&tb, 0, sizeof(tb));

nit: Reverse xmas tree
