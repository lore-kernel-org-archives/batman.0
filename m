Return-Path: <derick.deleon@gmail.com>
MIME-Version: 1.0
From: Derick Roman De Leon Leal <derick.deleon@gmail.com>
Date: Sat, 25 Feb 2017 12:38:46 -0600
Message-ID: <CAM0tZWbH0wP+f0YnaBfKMN5nsuqy5XGKxtjCiT=gaO=Q12KjZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Node freezes but still alive
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Thanks Linus and Antonio for your replies.

I guess is a driver issue, the thing is that I have been using this
exact same configuration in other 10 locations without a problem. It
sure is strange.

I don't know if this helps, but I saw this in the log.

Sat Feb 25 17:23:52 2017 kern.info kernel: [21168.652823] batman_adv:
bat0: IGMP Querier disappeared - multicast optimizations disabled
Sat Feb 25 17:24:02 2017 kern.info kernel: [21178.691583] batman_adv:
bat0: IGMP Querier appeared

A quick google search showed that this has to do with multicast, which
is disabled in my configuration. Should I enable it?

Also, I have noticed that the node with the issue is constantly
requesting who-has the gateway.

I ran this command from the gateway.
batctl td -x257 adhoc0

18:23:44.134458 BAT ae:86:74:47:8b:02: BCAST, orig ae:86:74:47:8b:02,
seq 1933, ARP, Request who-has 10.10.0.1 tell 10.10.0.142
(ac:86:74:47:8b:00), length 28
18:23:44.145748 BAT ae:86:74:47:8b:02: BCAST, orig ae:86:74:47:8b:02,
seq 1933, ARP, Request who-has 10.10.0.1 tell 10.10.0.142
(ac:86:74:47:8b:00), length 28
18:23:45.124692 BAT ae:86:74:47:8b:02: BCAST, orig ae:86:74:47:8b:02,
seq 1934, ARP, Request who-has 10.10.0.1 tell 10.10.0.142
(ac:86:74:47:8b:00), length 28
18:23:45.125725 BAT 60:e3:27:f2:71:1c > ae:86:74:47:8b:02: UCAST, ttvn
2, ttl 50, ARP, Reply 10.10.0.1 is-at 6a:64:42:e7:bf:cb, length 28
18:23:45.139625 BAT ae:86:74:47:8b:02: BCAST, orig ae:86:74:47:8b:02,
seq 1934, ARP, Request who-has 10.10.0.1 tell 10.10.0.142
(ac:86:74:47:8b:00), length 28
18:23:45.144519 BAT ae:86:74:47:8b:02: BCAST, orig ae:86:74:47:8b:02,
seq 1934, ARP, Request who-has 10.10.0.1 tell 10.10.0.142
(ac:86:74:47:8b:00), length 28

Does this means that there is IPv4 transmission?

Is there a way to make sure this is a driver problem?

In the meanwhile I will try a LEDE and a newer Openwrt.

Thanks again for all your help, any comment is welcome.


Best Regards,
Derick
