Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF67C79FB9
	for <batman-adv@archiver.kernel.org>; Thu, 10 Sep 2026 15:16:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0E9BF842AA
	for <batman-adv@archiver.kernel.org>; Thu, 10 Sep 2026 17:16:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789053362;
 b=I0Pq6pn7FL5G5dgGWDlgc4u/WPuDNY6Xd2ZgChkUsmzQhUPA18ThjIl2xEEp9EDdwZbvD
 5XGy9E55JUMXj1pYgUEho5xz/lr7YKtOpOi/kkgYYlTgMA3ZzyIw96T/eu9mjyeRLZmZuNx
 lx1D2c6NLt+C+scz1P0gukKN3mIvvNI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789053362; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
 b=b3uy7B1YmVuBq/ovpTu7EXrmkseI33XyIGM55XdY54+TEBMQZm39ctH37OLy2wbMFpL5O
 i/5Zg50pGXJi0WC49w/CQcu85mFEHfmmCQbXb8LcDXYgESPlAl7IDaQx+RBXYmmg9ckpBZb
 QsSOY6CLVdQUkv0qms++hNhizHD+Ov4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=tipi-net.de;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=tipi-net.de;
 arc=pass; dmarc=none
Received: from mail.tipi-net.de (mail.tipi-net.de [IPv6:2a03:4000:43:185::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0CE6681134
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Sep 2026 17:12:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789053125;
	b=KEVw2LuJd5sw5uyLhxNlnmPbKu+91jcPbSA4BdhcoQaqlkwOdUdBgJRVJgPiJOUe9AIk/h
	3vc4dgpOvBveP+6fujP5ixh6ewLEDM3rV9F1BVTWCYIMW+0xTtzUz/lWbLoKXre4GKy2Ie
	UEHSr1XezwePrE+0Qh/N660TAobmgng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789053125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
	b=HiAr0jK1j7/+k9g9locDCMgEhg63Bg2iGa3tdEo4HMnWfqDTdAP0QjPdhpa60RUfIl0uJY
	DBLnvVnhdkOuWSookgc51Xp3ikBTlRDJgVxz3Khdmb3xtatKFSk9zqCsIMD4atnTroJ01c
	VdFmkD5x8y8tHRCD/KhOUGcopfhfJcs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=Hpdx1B0R;
	spf=pass (diktynna.open-mesh.org: domain of nb@tipi-net.de designates
 2a03:4000:43:185::1 as permitted sender) smtp.mailfrom=nb@tipi-net.de;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 47C55A4169;
	Thu, 10 Sep 2026 17:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789053121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
	b=Hpdx1B0RklFI70C6JovHFAuJwyocwPn/ocqTHpQdmGbpphdH1JIBcqr/YtbjcnbJ6ZtOfU
	7pePFoQRb7XlSWPffSMETd4TTPd0pZvW3piaRLHiSzL0tVz45TkmmC2BocAwDgRAgvuxw0
	XQneeJ/zpQOFh0La0WXgAbUPdKcd8z5ra8QU6CZxRLdgdCdeyMNYnQxqtLLs9ZeTuL8OPy
	5sN4KooGBkX/6RmSaBGO1l2v7csMS5zxmT0Ku9YXijilyY5qmWPpIUxr4cN1jVcamG22ON
	xBaiIr0TLZ8mbFDjdj4iXDwo/xy7DrVzyM+U/yDAqv8gNlxRbnB64AfiV66POA==
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 17:11:33 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Elad Nachman <enachman@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Saurav Kashyap
 <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <mkp@kernel.org>, Nilesh Javali <njavali@marvell.com>, Manish Rangankar
 <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Marek Lindner <marek.lindner@mailbox.org>, Simon
 Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli
 <antonio@mandelbit.com>, Sven Eckelmann <sven@narfation.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, Johannes Berg
 <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Julian
 Anastasov <ja@ssi.bg>, Aaron Conole <aconole@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Allison Henderson
 <achender@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin
 Long <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li
 <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Jon Maloy
 <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Casey Schaufler <casey@schaufler-ca.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <markus@blochl.de>, Arnd Bergmann <arnd@arndb.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Qingfang Deng
 <qingfang.deng@linux.dev>, Julian Braha <julianbraha@gmail.com>, Ethan
 Nelson-Moore <enelsonmoore@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Eric Biggers <ebiggers@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, Alyssa
 Ross <hi@alyssa.is>, Joel Granados <joel.granados@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
Message-ID: <aeb37452e976f5d44540ac3a0999d07b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-MailFrom: nb@tipi-net.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: DSVGHNFSPW7ZUIYNFSFEWMGWTX2OAUYZ
X-Message-ID-Hash: DSVGHNFSPW7ZUIYNFSFEWMGWTX2OAUYZ
X-Mailman-Approved-At: Thu, 10 Sep 2026 17:15:19 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DSVGHNFSPW7ZUIYNFSFEWMGWTX2OAUYZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Fernando,

Thanks for the patch - after nearly 30 years IPv6 should be mature 
enough :)

On 10.9.2026 16:48, Fernando Fernandez Mancera wrote:
> Historically, the IPv4 protocol has been linked to the core INET
> subsystem. Because shared infrastructure like the TCP/UDP engine,
> routing or INET hashtables live inside net/ipv4/, it has been 
> impossible
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
> ---

> [...]

> diff --git a/net/packet/Kconfig b/net/packet/Kconfig
> index 2997382d597c..00fda9e08cb0 100644
> --- a/net/packet/Kconfig
> +++ b/net/packet/Kconfig
> @@ -5,6 +5,7 @@
> 
>  config PACKET
>  	tristate "Packet socket"
> +	depends on IPV4

   depends on IPV4 || !INET

Otherwise this would break existing configs with INET=n. The same 
applies
to other affected options that currently permit INET=n.

> [...]

Thanks,
Nicolai
