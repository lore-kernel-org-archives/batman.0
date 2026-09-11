Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994E2C88E45
	for <batman-adv@archiver.kernel.org>; Sat, 12 Sep 2026 06:19:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3DA9A83D6B
	for <batman-adv@archiver.kernel.org>; Sat, 12 Sep 2026 08:19:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789193975;
 b=1N04Oz0n3v2w2HeDOCxwdhbxbKS6fMIfYm9mJr6vHoMu1XkrvMupZ6Gx15PWrEZUEAccd
 wweeVtTZ4EjBBsyk2zwpq5lklnXwU9Dehl8NdRVETdcrCClQxp70Kq32PRqnK1yqmPCV2pG
 RXzhN7OzFR78TXeDL9nXmBKMS9ARVKY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789193975; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
 b=uuTRAbJmOerhozJC9xGSeHBRb5IACIf/mun+WDM3cFBAt66tyYPs+cEDwLZVEi1x65wcY
 IchkejgwQNBv9tGZ2Nysj8548jiM5L3JNSsPgAew+ss3ghI3xjpsMwM7eEjtBRr+QhQZHL1
 yMGiM7kPSVsF5PL3Ip0g/Wvca6AsyEA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=suse.de;
 arc=pass;
 dmarc=pass header.from=suse.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=suse.de; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=suse.de policy.dmarc=none
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BA436812DD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 11 Sep 2026 20:40:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789152014;
	b=sidY2UL83wMzwhrFlG1EUcEiySfju7/IoEVJs0PFvul7jiTHnRMEKaCS27x+rXgb96vza3
	ju9tbU+TBZj5xOe492WS2YJzjUZwAC2Lx10oalWQuRUZqy8JTW84ClI0GMuzsGfRXpWDBT
	G+4rVAxCpIOrVW2gEaOKPPvi1NqR4sY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789152014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
	b=XguF4Qc1k7ICA65jJiBMfT8iRzuPAYjIdp+hmo1EQ+XeTJqgSl7VyKqLWfT/9cVsv97hIn
	sa2OOp9aE+uVtdExTF5DOiB5ffn/4quebPanpFCbdSgAcMPu8YMuUuBbwGnyIABBxMqNZj
	h0t5SbC2ENvUsf80pZ5+DEjULXNpBfc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jQvT/hNL";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LjXuC2zN;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ul8oYidE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CSmkM9nN;
	spf=pass (diktynna.open-mesh.org: domain of fmancera@suse.de designates
 195.135.223.130 as permitted sender) smtp.mailfrom=fmancera@suse.de;
	dmarc=pass (policy=none) header.from=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A02A721D73;
	Fri, 11 Sep 2026 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1789151999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
	b=jQvT/hNLseNTOBEemFSNARlCXWKP2e4so8AW5lBP7Od/oZfcMhnGuBXX45mpo2ZC9ZQcIq
	nyh7In5EcGcTuubSALewLCrx7qgYTPhsNpExEBudSfp9VDoUCrTIQExSUn7hNcAjodDbMU
	TemTPkxHYqjXxuvN0STISPcLWS3ZbEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789151999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
	b=LjXuC2zNVa0kAgOsGh9AysxRDEQhs0Jmi+qRz8BHgyBxLrnJ/bqb45O7323NdYHfnzktFY
	5JmFVUzXVx8H0nCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1789151995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
	b=ul8oYidEl3s5A8NRIfwyKcVcj0SGx+WsBh3+UE9Dccx6gY+zohi+x+e6hwh8jSXE+gObAd
	NV75uaDsxqR0UY6CPfLl8YJhnVXKDDsXko24VKloUVa0DirbQIUHSuHhrfhkVmpbdaxA3K
	VMm1v3qsN1COmnh1eBjSb3oDODbJyJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789151995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
	b=CSmkM9nNI3cKI3Y5Y7JZBmKSl5oJhrB8oMTDovxD6JbikM1s63ZS0E//l7OLojSiSKX7Ve
	tHVAwdauixCBz0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10D7B132D3;
	Fri, 11 Sep 2026 18:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KIZRAfVKpGqufAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 11 Sep 2026 18:39:49 +0000
Message-ID: <986c5a6c-b904-477d-bb41-186b66f4b258@suse.de>
Date: Fri, 11 Sep 2026 20:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
To: Sven Eckelmann <sven@narfation.org>, netdev@vger.kernel.org
Cc: horms@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Elad Nachman <enachman@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, Nilesh Javali <njavali@marvell.com>,
 Manish Rangankar <mrangankar@marvell.com>, Varun Prakash
 <varun@chelsio.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Johannes Berg <johannes@sipsolutions.net>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Allison Henderson <achender@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen
 <tung.quang.nguyen@est.tech>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <markus@blochl.de>, Arnd Bergmann <arnd@arndb.de>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Qingfang Deng <qingfang.deng@linux.dev>, Julian Braha
 <julianbraha@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Alyssa Ross <hi@alyssa.is>,
 Joel Granados <joel.granados@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
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
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de> <2927239.BEx9A2HvPv@ripper>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <2927239.BEx9A2HvPv@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	FORGED_RECIPIENTS(2.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:jgg@ziepe.ca,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:ecree.xilinx@gmail.com,m:maxime.chevallier@bootlin.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:axboe@kernel.dk,m:sagi@grimberg.me,m:James.Bottomley@hansenpartnership.com,m:varun@chelsio.com,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:neil@brown.name,m:okorniev@redhat.com,m:tom@talpey.com,m:sw@simonwunderlich.de,m:razor@blackwall.org,m:fw@strlen.de,m:johannes@sipsolutions.net,m:ja@ssi.bg,m:aconole@redhat.com,m:echaudro@redhat.com,m:jiri@resnulli.us,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tung.quang.nguyen@est.tech,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:casey@schaufler-ca.com,m:serge@hallyn.com,m:vikas.gupta@
 broadcom.com,m:bhargava.marreddy@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:nb@tipi-net.de,m:markus@blochl.de,m:arnd@arndb.de,m:hkallweit1@gmail.com,m:florian.fainelli@broadcom.com,m:julianbraha@gmail.com,m:enelsonmoore@gmail.com,s:linux-afs@lists.infradead.org,s:linux-arm-kernel@lists.infradead.org,s:linux-nvme@lists.infradead.org,s:brcm80211@lists.linux.dev,s:bridge@lists.linux.dev,s:mptcp@lists.linux.dev,s:b.a.t.m.a.n@lists.open-mesh.org,s:intel-wired-lan@lists.osuosl.org,s:tipc-discussion@lists.sourceforge.net,s:coreteam@netfilter.org,s:dev@openvswitch.org,s:rds-devel@oss.oracle.com];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,ziepe.ca,lunn.ch,intel.com,marvell.com,nvidia.com,gmail.com,bootlin.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,hansenpartnership.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,oracle.com,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,est.tech,secunet.com,gondor.apana.org.au,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com,tipi-net.de,blochl.de,arndb.de,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
	R_RATELIMIT(0.00)[to_ip_from(RLu5qefsf3rq4khkdydytudeq9)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[133];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-MailFrom: fmancera@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: QLNCTVGG2LRNTKZU7OEQRG2SDSA7SEXU
X-Message-ID-Hash: QLNCTVGG2LRNTKZU7OEQRG2SDSA7SEXU
X-Mailman-Approved-At: Sat, 12 Sep 2026 08:18:20 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QLNCTVGG2LRNTKZU7OEQRG2SDSA7SEXU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 9/10/26 6:56 PM, Sven Eckelmann wrote:
> On Thursday, 10 September 2026 16:48:26 CEST Fernando Fernandez Mancera wrote:
>> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
>> index 58c408b7a7d9..60ad4b09be6e 100644
>> --- a/net/batman-adv/Kconfig
>> +++ b/net/batman-adv/Kconfig
>> @@ -9,6 +9,7 @@
>>   
>>   config BATMAN_ADV
>>          tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
>> +       depends on IPV4
>>          select CRC32
>>          help
>>            B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
> 
> This doesn't make a lot of sense to me IPV4 is not a requirement for
> batman-adv. Only very specific features will require symbols from IPv4:
> 
> * CONFIG_BATMAN_ADV_BLA
> 
>    - arp_create
> 
> * CONFIG_BATMAN_ADV_DAT
> 
>    - arp_create
> 
> * CONFIG_BATMAN_ADV_MCAST
> 
>    - ip_mc_check_igmp
> 
> 
> Basically things which currently depend on INET in net/batman-adv/Kconfig
> 
> Or am I missing something here?
> 

Yes, you are right. I must re-check all the symbols again. So thank you!

> Regards,
> 	Sven

