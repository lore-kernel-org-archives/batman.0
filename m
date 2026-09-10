Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD601C79FA1
	for <batman-adv@archiver.kernel.org>; Fri, 11 Sep 2026 06:14:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DDD9080736
	for <batman-adv@archiver.kernel.org>; Fri, 11 Sep 2026 08:14:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789107266;
 b=etr24BOo2ls8WIII1nBZOjMRvCeDxEfrulPszAHuZVUHPuTJvHDwCy/wwpgTpAqXIMTCx
 W8i7Dw5xxBquDo7YIQOMum2A8/N8pcG7PBg/9XnbuDE1MKP11E4EpaAJus1tCLdsa+50lTB
 HYgGXcLxanhbTZv7j+HYIU+L9O+/xZE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789107266; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CrpBp6UrC3ldEa5GcKmmPo3oz74G2RAnpQBvJ2o9k1k=;
 b=aUhGdbgzXmEp2moyNdtimePaf1l4dqq9EAqXGwrkOce/eKVrFetzTI09iQQa+aLkrPB6O
 KRBvSb6ANMSv0w9CRb0wbkQrcD+g2KIJumyn+bOJxJzESNa0UNAFQxzrBs5ifIKfYK+DQlM
 HhGwBiUy8xGwMS0ppAG+TdZ1GoL59wo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4D3CC80083
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Sep 2026 20:55:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789066558;
	b=NaA9vYtD0cXv1MHqCmnJVZmNd6u+rW2ysy/DIy1f9aLhn1E1oxDiqNib4r6rePt9wepNsk
	cQTpepoET0mBoqJ7yZv+GdGzWhrnkVr1jmoprixCDgBvH4SonGfguODDH0pLbf83zEa9oR
	/M0KYsxc7ANYIm+hhD9WWktaSJdRmmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789066558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CrpBp6UrC3ldEa5GcKmmPo3oz74G2RAnpQBvJ2o9k1k=;
	b=gg2xS+Ek7eI5RzdqQSf0+4D1OgWczypcTNAZ4LfUJppn+o5qrXMUnCHYM84/FW+/p5QioV
	AwAR1ZNV11u35dJWlmKqqSYThvYGo+FGjhdRxKDO/+VeYt1nEvA/1PbtRVrzuPvrz0pZqz
	wH6L8oo25Aq9UUG5mHqmGonkPRlxsWc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SUzKykjd;
	spf=pass (diktynna.open-mesh.org: domain of cel@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=cel@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6ECCA447E2;
	Thu, 10 Sep 2026 18:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE43C1F008A7;
	Thu, 10 Sep 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789066545;
	bh=CrpBp6UrC3ldEa5GcKmmPo3oz74G2RAnpQBvJ2o9k1k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=SUzKykjdvV+5mb7+BixcB80g7+i+u+nBUwfb9eta7h9ErBD3kHVouipLrFNBXHDo7
	 Uyw4TEjlpn2m6IR6OTAmJKxDBIrJhtxYk9WyN6/cCJECIUZ0OaGP5pFuWeEzz9jfiY
	 Z8sTU5HwMpjruRlLh9s0Bx+p9piEZO0ceRs4l+vY877XvU3dSiGQlKgiCq1cmrIX5s
	 jcPDoCtGxJkAPjQjpe/F3DiFGiqirkyyCJA79XjucJKL4pVuQNqMz2IWjOt4PnUT/c
	 OxOpmwwOjbn3eepxYYTNMlO67QQOAOsXAp4rj/SK5E0QFMKw/iOnkIVWPTUVGKPkKk
	 g0bNHWFwxKWvw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CFE21F4006C;
	Thu, 10 Sep 2026 14:55:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 10 Sep 2026 14:55:42 -0400
X-ME-Sender: <xms:Lv2iaplfbQ631YFOzCGpJasjLjWIwQT3JrRVk3LS9MkCgPR1g1eugA>
    <xme:Lv2iavr9DxNpwTN2WBDYnlnGtcos9ihLSRkWiANMTxQZahPdAPSJkGAMCtQD9uGmu
    CvlIzaCLaPaXqkiswOybV3mvL_461fEaLOySRiUpr08YCVAogsBrjk>
X-ME-Proxy-Cause: 
 dmFkZTE4zEfUt91Vh8wMjr6L/WUBy21uDOI31KgY6OiMy0jiDAiO+GFbZriSZgXS8OAWnu
    /3wZfwktsQy09207CvYDKSXzOlYx9ZdBx1LSo/kQEdWNYp1yKeuEWfRKk9ojXejFncjkBt
    KckJanJNrOVpIib2/f6VXeIYgIP4I/6znBINkeaBLD8q/h8tTagpKFEVt2qYqixiI7+8ya
    Qck60jclUtx0SBvHLjTkr0/GBYxsUlspQBzQH7cLVb8Cy4QOwtBOR6sJv/73LrNH/Rr2dG
    XLu8xXR7kBokf4Hy6yKlXpCqB+DsgyF+8XmuyIzmr/OJYZPyvmv/ip/XfvhUk8ogZaQ3pr
    hOFjwJEFCJjQ6WJ8p5KgTILYUUvbu+1iKa4pw9oVNnHgKi7hTmmtu7k8vw99W8cd3eu808
    zZ7dnzk0LARYbX8HAqHV3buYMe4o9iEMKJwKob6lss0LOl/7XhQIypSm7GAf45lexb+g54
    Xm6bRAfY7SdS7p0rbeG51YU3sEYNWG/Mol7x0fZihE8QLC4ptqicNhJxDtyBLdDEX4yY0L
    NxeSjxo00rxMp4bke3nbLsmzErPZaLCX6BE+kz3nXYadZaNZFzWiOvWSaxkl2nI1wPMwGu
    qksNgPs3kj+c5Ft0oAb3U6+T7q0gnx/W3XYreb4vehHpxvHId3daxUMn3wkg
X-ME-Proxy: <xmx:Lv2iau4uQgwZ5ZSX77NXUK00CupYfPLJ--mL7W6WyoCrnFXJ28AYqg>
    <xmx:Lv2iaqX7SMcL8hmfn1O5CVsW6yS7vTTV6bHzj9JKszswq-uSObcxfw>
    <xmx:Lv2iarJEeotBEMJbbVfbMSQaUwMqTvxtXIvy4a3GKPkLyANW62-8MQ>
    <xmx:Lv2iaqQcxmN0cokbQxX3YL090yzt-HrXiCbr35zWHqVENYQgqslXjg>
    <xmx:Lv2iauC5ue_eshF6QAwcEWN4h9uxzHMXtUdgP-v3O2VblTSkZDFa_bSI>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F75E7811F0; Thu, 10 Sep 2026 14:55:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AHIlAaKAQArc
Date: Thu, 10 Sep 2026 14:55:20 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>, netdev@vger.kernel.org
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, edumazet@google.com,
 davem@davemloft.net, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Leon Romanovsky" <leon@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Tony Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Elad Nachman" <enachman@marvell.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>,
 "Petr Machata" <petrm@nvidia.com>,
 "Edward Cree" <ecree.xilinx@gmail.com>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Marek Lindner" <marek.lindner@mailbox.org>,
 "Simon Wunderlich" <sw@simonwunderlich.de>,
 "Antonio Quartulli" <antonio@mandelbit.com>,
 "Sven Eckelmann" <sven@narfation.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>,
 "Geliang Tang" <geliang@kernel.org>, "Julian Anastasov" <ja@ssi.bg>,
 "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>,
 "Ilya Maximets" <i.maximets@ovn.org>,
 "Allison Henderson" <achender@kernel.org>,
 "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>,
 "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>,
 "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
 "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "Jon Maloy" <jmaloy@redhat.com>,
 "Tung Quang Nguyen" <tung.quang.nguyen@est.tech>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Casey Schaufler" <casey@schaufler-ca.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Julian Braha" <julianbraha@gmail.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Neal Cardwell" <ncardwell@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Alyssa Ross" <hi@alyssa.is>,
 "Joel Granados" <joel.granados@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-security-module@vger.kernel.org
Message-Id: <ff6ff699-e942-455f-8816-49af24afb370@app.fastmail.com>
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the
 IPv4 stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-MailFrom: cel@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: DXC6OCDG6RVB6OCHYEENPGPCWEQXVH5G
X-Message-ID-Hash: DXC6OCDG6RVB6OCHYEENPGPCWEQXVH5G
X-Mailman-Approved-At: Fri, 11 Sep 2026 08:14:18 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DXC6OCDG6RVB6OCHYEENPGPCWEQXVH5G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>



On Thu, Sep 10, 2026, at 10:48 AM, Fernando Fernandez Mancera wrote:
> Historically, the IPv4 protocol has been linked to the core INET
> subsystem. Because shared infrastructure like the TCP/UDP engine,
> routing or INET hashtables live inside net/ipv4/, it has been impossible
> to compile a kernel with only IPv6 support.
>
> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
> 'def_bool y' for now. This does not allow to completely disable the
> IPv4 stack yet but it lays the necessary build-system work for that
> goal.
>
> In addition, multiple subsystems Kconfig symbols across networking
> features like tunnels, drivers and filesystems have been adjusted to
> depend on IPv4. Keep on mind that follow-up work is required to convert
> the Kconfig symbol to bool and remove the dependency on IPv4 where it
> makes sense.
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index e7808e5714dc..58e6f6db3100 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config SUNRPC
>  	tristate
> -	depends on MULTIUSER
> +	depends on MULTIUSER && IPV4
> 
>  config SUNRPC_GSS
>  	tristate

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
