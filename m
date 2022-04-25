Return-Path: <yuzhe@nfschina.com>
Message-ID: <2822d906-6006-2530-eca8-f4c398a1357d@nfschina.com>
Date: Mon, 25 Apr 2022 19:14:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] batman-adv: remove unnecessary type castings
References: <3537486.13E77TLkhO@ripper>
From: yuzhe <yuzhe@nfschina.com>
In-Reply-To: <3537486.13E77TLkhO@ripper>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, kernel-janitors@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, liqiong@nfschina.com, mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, sw@simonwunderlich.de

Hi,

thanks for your reply, we have fixed our mail server. And I'll correct and resubmit my patch.

在 2022/4/22 15:55, Sven Eckelmann 写道:

> Hi,
>
> we neither received your mail via the mailing list nor our private mail
> servers. It seems your mail setup is broken:
>
>      Apr 21 15:48:37 dvalin postfix/smtpd[10256]: NOQUEUE: reject: RCPT from unknown[2400:dd01:100f:2:72e2:84ff:fe10:5f45]: 450 4.7.1 <ha.nfschina.com>: Helo command rejected: Host not found; from=<yuzhe@nfschina.com> to=<sven@narfation.org> proto=ESMTP helo=<ha.nfschina.co>
>
>
> And when I test it myself, it is also not working:
>
>      $ dig @8.8.8.8 ha.nfschina.com
>
>      ; <<>> DiG 9.16.27-Debian <<>> @8.8.8.8 ha.nfschina.com
>      ; (1 server found)
>      ;; global options: +cmd
>      ;; Got answer:
>      ;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 39639
>      ;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1
>      
>      ;; OPT PSEUDOSECTION:
>      ; EDNS: version: 0, flags:; udp: 512
>      ;; QUESTION SECTION:
>      ;ha.nfschina.com.               IN      A
>      
>      ;; AUTHORITY SECTION:
>      nfschina.com.           600     IN      SOA     dns11.hichina.com. hostmaster.hichina.com. 2022011002 3600 1200 86400 600
>
>      ;; Query time: 328 msec
>      ;; SERVER: 8.8.8.8#53(8.8.8.8)
>      ;; WHEN: Fri Apr 22 09:51:56 CEST 2022
>      ;; MSG SIZE  rcvd: 105
>
>
> Please fix this before sending patches out.
>
>
> But the kernel test bot already demonstrated why this patch is not a good
> idea. You can improve it and resent it but I will not accept it in this form.
>
>
> Kind regards,
> 	Sven
