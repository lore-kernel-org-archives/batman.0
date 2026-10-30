Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E892606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ER+AG/pW
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 27F8684821
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 08:12:12 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793430732;
 b=l0vJqOzXKn+o/ENErtFzJ78X1DeDb6IKKnptAdP5lLae+refPt8ibl4RCRf4AZlbn0pEP
 76HLn84SL1qDF9fKzQ5pszMmIv3Mw+5SbCbf5bRO5stnxLNiWg4jIdjlGmSqZk4uf+BYp/D
 KnSuTPulXbLBY1P2+ne/5dzQrvHzi4U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793430732; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=octqyFYimOsatIHMz4CJTAXuYhPX39l2GOWexDc6e+U=;
 b=Lry6ge8GRESU/e3We5kQw97RwsbO+gOlZA8gcyTpaG1q2smdy+CUHwiyszHt6+A397l/P
 WLHRNx86wJBF3/PvTDdilK8WtE0KtdksHc4W2OVrBT0zg34o1aBWY5QDvbRgJJRvcdANggE
 43y72wjdZ6tm23v2NOGkB/H/mpKXkUw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=intel.com header.i=@intel.com;
 arc=pass;
 dmarc=pass header.from=intel.com policy.dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=intel.com header.i=@intel.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=intel.com policy.dmarc=none
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CA777846AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 23:01:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793397671;
	b=LXWTrLcBEZb87lrOJRCy0nb1nQZp1XDlNRfyCB+wZuIFDvG9iQIBKbfzqNcksXMHgCY8rG
	TOk1L8R9xVpH6JYt2hQfVxmY0Zj70fUkxh6noy+QsAEw2h3HkCoHupC8auF/LZVLFqu08I
	UHFjhlKtBHxff1S5dp6wc/D9OB0+yys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793397671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=octqyFYimOsatIHMz4CJTAXuYhPX39l2GOWexDc6e+U=;
	b=QCYD9bAFErVgZPbodETSSKt8q5tVhPeYQ70bzsd1rR1YHxyumhbEhPo34a8qynBpnwEy62
	6zdTzMR/QSDQJBotfltq2psYJHPPPE3DrVvyyD6YEgGb9Hal5fSwQNRaiUcFSP/AQMRaYo
	Htjd2DR/vJTnwFBdpcC31En0F0Xp0yg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=intel.com header.s=Intel header.b="ER+AG/pW";
	spf=pass (diktynna.open-mesh.org: domain of lkp@intel.com designates
 192.198.163.14 as permitted sender) smtp.mailfrom=lkp@intel.com;
	dmarc=pass (policy=none) header.from=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793397670; x=1824933670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uAAszUf04DL6b+ORx9R554o6d9Wb1c7w4v3eBbP/D8A=;
  b=ER+AG/pWMwQDzMqvvY8Xy9amxWDOZ9/zmHbognGCf0STUAb7FWqjS9w5
   BoQWXuHaP0tqV+bF3KMcshvHZnrQ7OMO9uAmXLgp71inigdtrZUXSKzw4
   mBwVU+2fgEKy9anJWE1llwwNxQg5u9kKbQknQnruGJRyv3/f3FiKNQfMY
   R0qjHt8gKoWr3n65NnmP4DghwpfqHnN90NBPnSsyQLE/WqT+P6I5bQKos
   sHEN2K7R83MyjfrRPaH1ooiiExrG7h8iBFdCl9nsk8zI2Syj08o9TCuie
   GJ2Xsx82zLSCGQHw+q86rQwfMEpzHWIxUOcApIHxsRzoLkG641oY1yoIs
   Q==;
X-CSE-ConnectionGUID: 3P+vN23nRw2gjmDIxsvYzg==
X-CSE-MsgGUID: jASkiU1ZRwawSDoNdLletw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2203073"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400";
   d="scan'208";a="2203073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 15:01:08 -0700
X-CSE-ConnectionGUID: XbVTQnfaREalV18kkXZuRQ==
X-CSE-MsgGUID: MuuUBk92Q3ChAV3JGaexbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400";
   d="scan'208";a="5426383"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2026 15:01:05 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMuek-00000000cHO-1VkO;
	Fri, 30 Oct 2026 22:01:02 +0000
Date: Sat, 31 Oct 2026 06:00:36 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>,
	marek.lindner@mailbox.org, sw@simonwunderlich.de,
	antonio@mandelbit.com, sven@narfation.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com,
	=?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>
Subject: Re: [PATCH net] batman-adv: reduce softirq drain in tt_purge loops
Message-ID: <202610310549.bbi0IqHw-lkp@intel.com>
References: <20261030000222.286935-1-omermetekaya0@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261030000222.286935-1-omermetekaya0@gmail.com>
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: ABQEM2YWWX5SJBCCFXHYW6ENA3M3YWGP
X-Message-ID-Hash: ABQEM2YWWX5SJBCCFXHYW6ENA3M3YWGP
X-Mailman-Approved-At: Sat, 31 Oct 2026 08:11:57 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ABQEM2YWWX5SJBCCFXHYW6ENA3M3YWGP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ömer,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/mer-Mete-Kaya/batman-adv-reduce-softirq-drain-in-tt_purge-loops/20261030-025951
base:   net/main
patch link:    https://lore.kernel.org/r/20261030000222.286935-1-omermetekaya0%40gmail.com
patch subject: [PATCH net] batman-adv: reduce softirq drain in tt_purge loops
config: csky-randconfig-1001-20261031 (https://download.01.org/0day-ci/archive/20261031/202610310549.bbi0IqHw-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610310549.bbi0IqHw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610310549.bbi0IqHw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/batman-adv/translation-table.c:1785 function parameter 'may_sleep' not described in 'batadv_tt_local_purge'
>> Warning: net/batman-adv/translation-table.c:1785 function parameter 'may_sleep' not described in 'batadv_tt_local_purge'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
