Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AEFC88E45
	for <batman-adv@archiver.kernel.org>; Sat, 12 Sep 2026 06:20:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0C232841DA
	for <batman-adv@archiver.kernel.org>; Sat, 12 Sep 2026 08:20:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789194010;
 b=FmhZCdDoPim2rosQqvpxZ1oU/V3QklzLpCdoC3IUs+g4tEFzctBZYvzZfB+mq35w1Rp1I
 dChuwM+D3BKIUCOgmhStoRdzOV5r44EOMDrylcIjBQyimKJ3pIzsHM19Muz3C3WHzw9+05i
 KXfJJnTqsQScaXXi+LYVdIK6xqNh1DQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789194010; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zPVAGvXA6BnDWmfJT3hQO0CB11Qqf66yZudh5n1EjA4=;
 b=QNyYpi5a1xW1kmzu3SF5g156IVT+zTFeXMmxcphWkfKueaqBEFTkSK0ZhsaQt0c5OT8T/
 a0o/mb3S4GUKH6UTLrl8N1WtKTFEaLu5gtXxxDkSWfTJlsGMXEAgBwchJZAzvEU3gO/V5VB
 fE0vlN+tu8K5C+0TZUEv7m1F+CF715g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=yahoo.com;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=yahoo.com; arc=pass;
 dmarc=none
Received: from sonic309-27.consmr.mail.ne1.yahoo.com
 (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D033B80826
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 11 Sep 2026 20:59:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789153208;
	b=wbg93RnpR5W3W9k3PvIT0R2vqGqjz1JTgE1lCDc3yOpFVtpSj2gPaeEOxZT6tRfNLTxaIj
	MrsMMewSkZkya3OqO3WKDRKyVB6gD24Tvq+6GksoG1O/1yxUQtpTBmA2OU3ELoyIRdfkn7
	1Syvy8Yv+t0v3SOl1i/ufetduL8hwno=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789153208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zPVAGvXA6BnDWmfJT3hQO0CB11Qqf66yZudh5n1EjA4=;
	b=nK8OMxuJwhOsBANdiRrO4V8UYizKE6Ejc7OWx9enKmcZMH/+DzPRKOL07d5c5f4ImciCfE
	/EaXPfrOGAx8NNMmThlSfR67jBLs0QTQP14Fz9swpSnvgNa71o9kRkB2v3C8azi/hPKawW
	uocQCfuwFV4BOvHC9KMkXpna2agSfAU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=mtnVsO1V;
	spf=none (diktynna.open-mesh.org: domain of casey@schaufler-ca.com has no SPF
 policy when checking 66.163.184.153) smtp.mailfrom=casey@schaufler-ca.com;
	dmarc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789153195; bh=zPVAGvXA6BnDWmfJT3hQO0CB11Qqf66yZudh5n1EjA4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=mtnVsO1VgKbez7SKzhsZplk6k0C9XTTXVlxzDnocNXEcQseScGzBI7NWgOkXr4UILYLp6xbh3FIHjwLdF+94WxMDb6ujNlEcAFFKECqG920WYAFTuiITuNW7RthvaIhN2AGu1tuq2GVpBfCumq35u7066l2/TlrAMDkZmZlUvAigViqjupi7aBGwM9ZfIWBkvefsp7nBcyrkSTSqOsa7ztb5+NPXMFhRnRdMy9gfukC2ZSMaXT2zEFTPBCWkqYo2lirWEQBy5QRK0sCqVkOeCrTj8u7fNeZOIN/CP0VXPWlqAHIOyz7yk4QRsYpt/9dz6e+97O94sev9f7/GzTpfMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789153195; bh=8D6wX+F6GVfY3825euMFl9WpyXMjynR9Yldv18g8cqJ=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=bu4h9TPqgz2/xWApTNwcDeX3xsfNIFng8n/Rtz3yUlQCrPCz+m2kDMyd3M9a6Pms/kzWOPV43nupzqMml3jzOYsaiLLPly+AkpJFunibZo005zZSyijIaAunEVowe0JkVkRQWqOp3EyjFNwnYUBwktLOD74qKN3sUJjX3iT+AbTuQVUXuxCWnSHC8A/cGDFK6WSahfUHLR5Es1J3SpdWDOemGlmdMRQbZ7mhtYCUeOSYpeLQzl3jnYI9DzlW5RN8oiwsfwkf4cKnC3dFl7o/M6y2kWAU4NLhB44efnNs/WkreEBGwafOavMDhpRceTX4GcgwwjSW0pqGP8TqOam0tQ==
X-YMail-OSG: 8IyxdVsVM1mOeDHP02iAS1e9vux4wp6Hm34349yjZZrE7KsVj4bJUTR76BW4BsK
 t19TLIIWTyEsL_xO6KYI6B3mIpTeWkCM7DlTvfoOQfuCsksf_DXfrnK4xY9kwKnB_FwtGMbXBVdX
 AwHEtPMyDd0o.V_n5VGZNusTss9eVCLkYUnExyioYPyx.Ad4XLy1Yhw66DZ6.cR7ayiSRijYW.xl
 305XtUrCNu_HX0zlFhl1UhhhGTmHJWDT71o9fTQtscG7_EeuKRlbSitXpH3h2TWZBa1RvmugXEHt
 NXIrMOJrZi6l.PxmX8gxMKPF7q1N60fwVrVibI3BInE.6oUKBezs64Ge8lnfaH6urMLx_mS7NELj
 fXVYAq93FCVN6TNK0NO4G.DDrLjcDRa6hhwWgZ6gQzEbJo2rpUwMXusCpi7RZb5Xl3sf4c2Idq5Z
 0YImN5yN2Urf87vmiFS8KvS6LQ8PAxxZyfXHUJ3TEbGILnbZXPD5AE_DFX2IpeDORzsdcSFaaNsu
 PJkDjGDNOOvznQ5FlWaMAh4HXH3i3.mQ0coMj6GUf4QwkG4eANVdkaMTdWJZeTV84xjq7hqr6XKn
 o1scllR7Z5GUkeTy8KNCbUrtqv5E7kUADSyywm2a.wUqCoxo5Q3A_YP0K0NZvpEKIs__FnlhdUI.
 q6m1Q09A2eYBeXmEIYZVeEkeB6sdw07Xxs8UUJuHZE0QHuKHXMrXD_xXTsGItQCvTPP8CDbX0kKe
 ImJUDil.4vy3ev72uHxHJEEWTnnuXYA_JydfBvosMnQg1N3bxdnWSWbU2Hkt3TqOn6I.FzGn6QG_
 wsFBAfZcXdPDj4v8n_Tn.11J7xLNj.C3Aoi_G63Dg8IjAO6.e7VyY4IIR7JohfOWwH7InWSPpd09
 L29Cgia4I5UJL8gTvOEtfAvKgJVnNCz.yi5pOsZY4j1II_vQDkb6oXyLuPEDAyPzDAFFnOiaNrKy
 x__Q1X.5B_1hlU32VDdlR0ZzLRLA1TJ22OXVHP7afTQZ2CEoO7JYf46la6agBDr8b5v6ACnNyYi0
 GhQZCLFp11jCoUSoTlX.swZ.VjvjiKiFxK1Ye.Y6beRQedZ1ShvRS3cGHZHLn0swNHUkffkG9fb3
 wOfjV.FBc9wUaDKFQWfxyDbjXO0IH0ejj1F4V87qTPUt2sRlRHwco_cjX6g8TQk3W1CWHZtJA8Pg
 tO3nnFPJrvQPKZpn49aFsX1c5K2ek4fcHTXgnHk4H1.HrFvV3xEMDEis4jnnSAlsgA8Rm6LvLdIz
 lUg33b0GLbxZzg0mpAIxtqrcQSofu5UyShBm.JhuDp9auiAWoHUZSz0qhhAGEt_GOhTOREfqCBZC
 G6fI4Yi.C177vKFVtiV63RCPKV3rxhhPlhyBZpV1ZUxEcqMjslksyvWTd6aT7vgXecZzbEB6Bbui
 PugKq5FvUYO.LajsfrgW6MxwegEMCwQHnJMQsa2Iiv_WjPIMQuqDSEH9zrUbp_k8Xt_MeBiTqXQs
 nXvD7ppdbgFMJjhFv1sbwFcotEUmdosnZNJTFj_.B9RbrhQTms0KTlTxt_kE8.NgiydL256Tokh1
 HbALEC9RtboqkogXmLNqhc9AtDZczzRhCNRn7Z2X3503NCMm88agdrjLobSs1H5d7xBdfXfFzDWy
 Nz0tAs4FjfupGpoHER0xGTafNDNwQhDzAsAi3Ns1zjs3AtY5PvuGfAWSa8fMSFBU03tXksZYFxo1
 ciJ0G1CvL1rd97I47QzrDWZ_28XKoUL8AUG1lo9hZdautcKmTjHBsHXCLAZuNOQ3VbTsaUcfqmee
 .irw7XZlKDpogx7TQrdIKjc686.9W3GLbec8PuplPYGKvHJJhuSP9jlcnM383VDSt8cLbmPuXq9q
 UfjAsSbY4zvrKu6HdDJcxvB8cx34WFQXftbm93mMXhuwnptgfKF5CDKWcQBHwqRHYsXSxAFpKM8S
 qTa3rFjIKqr1IO0XflZkb9XFSArGJix7oo_Xxz5tbTfxDmTZDSh6g_DFbDgKseITvTHLKJIf.Srg
 zVnCjD4ejDk1_J0rl97idNrtwcyBVrtsm8.34xwlrjrR25Rurg9citobqWcZ.BDfjnhc_fKhZQyb
 r8KhLp1zYO8PYT1BKGbEHUeMHroTq.j3oed5iHJ6xgxNJfL4MoCriV4lpnAthSrrU4GyoV4x2VqX
 oF_R8TC4LfHd6y98CdJloF.SZ2BtSQy89uStonDjpuGCXoEaZ98PKpIPceNx_hW37SyYRbmrBaKQ
 gu6._.5jHmTHesUwGqpIpKbbNaYhF7Q3yiS79YqO5LS7oubsSfX7dqeASC8h1m47H6U5NdATLY3r
 Y73pK8ITPNSGyICENKhMFqA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 155296a8-f4ef-4124-9fbd-d64e0f082663
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Sep 2026 18:59:55 +0000
Received: by hermes--production-gq1-678d9dd684-n95jq (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 54d69622036feeec9e5203b92a9973ac;
          Fri, 11 Sep 2026 18:59:50 +0000 (UTC)
Message-ID: <6f01eff3-20c9-488b-84f4-8c6456f2e54d@schaufler-ca.com>
Date: Fri, 11 Sep 2026 11:59:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
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
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 Sven Eckelmann <sven@narfation.org>,
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
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>,
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
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
 <ee89e26c-3dad-450b-8861-badf19afa141@schaufler-ca.com>
 <dfd9590c-e029-4432-9a13-c789f708cfee@suse.de>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <dfd9590c-e029-4432-9a13-c789f708cfee@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26525
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-MailFrom: casey@schaufler-ca.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: G4GUBXWIO7V7YTWPSY3C2RI5DDORH3CN
X-Message-ID-Hash: G4GUBXWIO7V7YTWPSY3C2RI5DDORH3CN
X-Mailman-Approved-At: Sat, 12 Sep 2026 08:18:20 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G4GUBXWIO7V7YTWPSY3C2RI5DDORH3CN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 9/11/2026 11:31 AM, Fernando Fernandez Mancera wrote:
> On 9/11/26 7:46 PM, Casey Schaufler wrote:
>> On 9/10/2026 7:48 AM, Fernando Fernandez Mancera wrote:
>>> Historically, the IPv4 protocol has been linked to the core INET
>>> subsystem. Because shared infrastructure like the TCP/UDP engine,
>>> routing or INET hashtables live inside net/ipv4/, it has been
>>> impossible
>>> to compile a kernel with only IPv6 support.
>>>
>>> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
>>> 'def_bool y' for now. This does not allow to completely disable the
>>> IPv4 stack yet but it lays the necessary build-system work for that
>>> goal.
>>>
>>> In addition, multiple subsystems Kconfig symbols across networking
>>> features like tunnels, drivers and filesystems have been adjusted to
>>> depend on IPv4. Keep on mind that follow-up work is required to convert
>>> the Kconfig symbol to bool and remove the dependency on IPv4 where it
>>> makes sense.
>>>
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>> ---
>>>   
>>
>> ...
>>
>>
>>>   security/smack/Kconfig                        |  1 +
>>>   54 files changed, 126 insertions(+), 66 deletions(-)
>>>
>> ...
>>
>>> diff --git a/security/smack/Kconfig b/security/smack/Kconfig
>>> index 5a8dfad469c3..b4e6d0168bd1 100644
>>> --- a/security/smack/Kconfig
>>> +++ b/security/smack/Kconfig
>>> @@ -3,6 +3,7 @@ config SECURITY_SMACK
>>>       bool "Simplified Mandatory Access Control Kernel Support"
>>>       depends on NET
>>>       depends on INET
>>> +    depends on IPV4
>>>       depends on SECURITY
>>>       select NETLABEL
>>>       select SECURITY_NETWORK
>>
>> Why would this make sense? You're introducing the capability to use
>> IP6 by itself, which is admirable, but you're disallowing that
>> configuration
>> with the Smack LSM. It appears that you've done a mechanical lookup
>> in the
>> Kconfig files and applied the minimal change to make the kernel compile,
>> which probably works for most cases. It does not work for Smack. Unless
>> there's a strong argument that Smack with IPv6 and without IPv4 is
>> and always
>> will be a pointless configuration you have my NAK.
>>
>>
>
> Right, that was kind of the point. The idea was to be able to compile
> core networking without IPv4. There are still plenty of modules that
> depends on IPv4. It does not mean that they will remain like that
> forever as I mentioned my idea was a follow-up on the series to avoid
> having a too long series.
>
> Anyway, I can make Smack to do not depend on IPv4 on this series if
> that could grant an ACK.

Yes, that would be acceptable. I apologize in advance for the Smack IPv6
implementation. Replacing it with a proper CALIPSO stack has been on the
todo list since CALIPSO was introduced.

>
> Thanks,
> Fernando.
>
