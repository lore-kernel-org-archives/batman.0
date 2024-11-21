Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D1EE65D2F
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 08:20:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0D31583F9D
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 09:20:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732263639;
 b=ms8hpj/b/pkXD/QnFDJPaU772Hl12sgzqd+t7T5XBhUm4tRS7O4nibOOXN4L3WrcZvpvc
 nZos0zXVF3xaeolUIHgcuzpyBzpBK1veHt4MAYRlavFjJs6bLpzStyx/09MM18JJYB22A1l
 OnVLglkVzlV8TmjR9beMo/r4F38VZJ8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732263639; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=e2Kv31MT5oF8RVQ9JWvUnsSwFo4hfOW3szAFVLCkGZM=;
 b=up4LRHUUO7Q0Oq8SG+9xF9hFKqXyBnxy/j6lWfHVCB4LclNGnYw6MWOuHC+lQrPrdmsTS
 O5SuWNb62A8wmpgtw8EKlV62qkGU6QLOLVutFMHHZERBTc7HYprujNtHBfx1NSu9/ZfDISQ
 TpsaT85n9OBH4MEMiAhKu5e7v8d2w5s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=intel.com header.i=@intel.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=intel.com policy.dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=intel.com header.i=@intel.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=intel.com policy.dmarc=none
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 95138801DA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 22:45:03 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732225505; a=rsa-sha256;
	cv=none;
	b=Pi24QxpthM4/pYACfPqbiaPSIPu6c4HY3LwlGdft7cm6/UVN7rNZcdlRQ3Otmgyp0gx6oa
	OxmVKUAkbqaovprokB7SAu+r0tzprASCrdn8Cw/lNtuo6pD2EhraavjzXiivjK8YAtKSyR
	6hYIn6tuBAW1Zp1KRwznMQ7JhvWSKWk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=intel.com header.s=Intel header.b=BNFcApkC;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (diktynna.open-mesh.org: domain of lkp@intel.com designates
 198.175.65.18 as permitted sender) smtp.mailfrom=lkp@intel.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732225505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=e2Kv31MT5oF8RVQ9JWvUnsSwFo4hfOW3szAFVLCkGZM=;
	b=d7lY9x5kO6mbJI+/fMQvewdHOxrNNwL4F1PTuD2b08aPyf61VuZShc3RTbCuMYRJMuXw5i
	wq/S381Vicqh1TEMC6l1sTcFYq3+8zNyF8GNj4KpENLEtPm/RMPuv/Y7Ka4QBhBlF89dXk
	dSecV9Dk/a6Ndmsvy81uh325zkCrTuQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732225504; x=1763761504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIUcN6+T+wki60rCRnwepyQ8KRF0PBbMkb47VLXLqKM=;
  b=BNFcApkCceVM9sS7dM7XHFFI8lIuy0mmm3XqLpRVhM+3qy5qt7P8kU4T
   f/8rIOxMJXlnwqnAi+F/DijxT8xYFwtyGKOLXSj+8Tb23nEbIwvBWQewe
   cFUuZd92N6PDupXXYMyNHL+GuBAQExGC+OITiX7sY8pwYweFr45jgh2p1
   6ArBuuiGy1vRY6YcTCdIeuNsjVizmxfhe0ZtF/V4MN5DveTlaWvScF5Rt
   7m/pbMhsNuxyC8wQ256oABy1O6lp+x9sVy6QFMHLOSQ6sVLGvcLzF0T5B
   nDnRm8CHu7/JpKQSCWQzAva8/7hLpyH4mPx+Efl2AhMNXL47O4aZBD7+8
   w==;
X-CSE-ConnectionGUID: GVU4WLuVRn2QIR7DT7XXpg==
X-CSE-MsgGUID: vLs2Oy9mRtOAD9UbESIE/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32514207"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600";
   d="scan'208";a="32514207"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2024 13:45:01 -0800
X-CSE-ConnectionGUID: xdpPO1RmQrC72kpFCsgzmg==
X-CSE-MsgGUID: zhZedUIBSeupQFYJAgkZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600";
   d="scan'208";a="90753178"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Nov 2024 13:44:56 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEyr-0003O1-1A;
	Thu, 21 Nov 2024 21:44:53 +0000
Date: Fri, 22 Nov 2024 05:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/5] rtnetlink: Decouple net namespaces in
 rtnl_newlink_create()
Message-ID: <202411220516.rokej98E-lkp@intel.com>
References: <20241118143244.1773-4-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118143244.1773-4-shaw.leon@gmail.com>
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: RFI7GNQRNTFL6NUMUJMOFVS5A4KJH2O6
X-Message-ID-Hash: RFI7GNQRNTFL6NUMUJMOFVS5A4KJH2O6
X-Mailman-Approved-At: Fri, 22 Nov 2024 09:20:26 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RFI7GNQRNTFL6NUMUJMOFVS5A4KJH2O6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Xiao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiao-Liang/net-ip_tunnel-Build-flow-in-underlay-net-namespace/20241121-112705
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241118143244.1773-4-shaw.leon%40gmail.com
patch subject: [PATCH net-next v4 3/5] rtnetlink: Decouple net namespaces in rtnl_newlink_create()
config: arc-randconfig-002-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220516.rokej98E-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220516.rokej98E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220516.rokej98E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/batman-adv/soft-interface.c:1075: warning: Function parameter or struct member 'params' not described in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'nets' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'dev' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'tb' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'data' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'extack' description in 'batadv_softif_newlink'


vim +1075 net/batman-adv/soft-interface.c

128254ceea6ffe Sven Eckelmann 2020-10-11  1063  
128254ceea6ffe Sven Eckelmann 2020-10-11  1064  /**
128254ceea6ffe Sven Eckelmann 2020-10-11  1065   * batadv_softif_newlink() - pre-initialize and register new batadv link
c19808cb1d05d1 Xiao Liang     2024-11-18  1066   * @nets: the applicable net namespaces
128254ceea6ffe Sven Eckelmann 2020-10-11  1067   * @dev: network device to register
128254ceea6ffe Sven Eckelmann 2020-10-11  1068   * @tb: IFLA_INFO_DATA netlink attributes
128254ceea6ffe Sven Eckelmann 2020-10-11  1069   * @data: enum batadv_ifla_attrs attributes
128254ceea6ffe Sven Eckelmann 2020-10-11  1070   * @extack: extended ACK report struct
128254ceea6ffe Sven Eckelmann 2020-10-11  1071   *
128254ceea6ffe Sven Eckelmann 2020-10-11  1072   * Return: 0 if successful or error otherwise.
128254ceea6ffe Sven Eckelmann 2020-10-11  1073   */
c19808cb1d05d1 Xiao Liang     2024-11-18  1074  static int batadv_softif_newlink(struct rtnl_newlink_params *params)
128254ceea6ffe Sven Eckelmann 2020-10-11 @1075  {
c19808cb1d05d1 Xiao Liang     2024-11-18  1076  	struct net_device *dev = params->dev;
c19808cb1d05d1 Xiao Liang     2024-11-18  1077  	struct nlattr **data = params->data;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1078  	struct batadv_priv *bat_priv = netdev_priv(dev);
a5ad457eea41ef Sven Eckelmann 2020-10-11  1079  	const char *algo_name;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1080  	int err;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1081  
a5ad457eea41ef Sven Eckelmann 2020-10-11  1082  	if (data && data[IFLA_BATADV_ALGO_NAME]) {
a5ad457eea41ef Sven Eckelmann 2020-10-11  1083  		algo_name = nla_data(data[IFLA_BATADV_ALGO_NAME]);
a5ad457eea41ef Sven Eckelmann 2020-10-11  1084  		err = batadv_algo_select(bat_priv, algo_name);
a5ad457eea41ef Sven Eckelmann 2020-10-11  1085  		if (err)
a5ad457eea41ef Sven Eckelmann 2020-10-11  1086  			return -EINVAL;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1087  	}
a5ad457eea41ef Sven Eckelmann 2020-10-11  1088  
128254ceea6ffe Sven Eckelmann 2020-10-11  1089  	return register_netdevice(dev);
128254ceea6ffe Sven Eckelmann 2020-10-11  1090  }
128254ceea6ffe Sven Eckelmann 2020-10-11  1091  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
