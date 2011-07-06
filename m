Return-Path: <ordex@autistici.org>
Date: Wed, 6 Jul 2011 11:47:41 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110706094740.GC6543@autistici.org>
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<201107041455.33023.lindner_marek@yahoo.de>
	<CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
	<20110704182256.GB26734@autistici.org>
	<20110704182914.GA4362@sven-atom.home.narfation.org>
	<20110704183941.GC26734@autistici.org>
	<CAJA-1Ljpew4y6EjR9823V533ssC-DpirPkNpBbFzULZGvmw_jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJA-1Ljpew4y6EjR9823V533ssC-DpirPkNpBbFzULZGvmw_jg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Jul 06, 2011 at 11:41:53AM +0200, Max Ip wrote:
> I tried ebtables to block the mac address of the neighboring node.
> 
> sudo ebtables -I OUTPUT -s 00:1b:77:06:1c:15 -j DROP
> sudo ebtables -I INPUT -s 00:1b:77:06:1c:15 -j DROP

These commands won't have effect on not-bridge interfaces. That's why
you are still able to see 00:1b:77:06:1c:15 in your originator table.

> 
> But the batctl o command still shows 00:1b:77:06:1c:15 as one of the
> originators.
> 
> My question is won't the enslaving wlan0 to br0 have the same problem
> because the mac address for both br0 and wlan0 will be the same?
> 

Why do you care about the wlan0/br0 mac address? Am I missing something?


Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
