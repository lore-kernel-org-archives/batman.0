Return-Path: <ordex@autistici.org>
Date: Wed, 6 Jul 2011 11:50:42 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110706095041.GD6543@autistici.org>
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<201107041455.33023.lindner_marek@yahoo.de>
	<CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
	<20110704182256.GB26734@autistici.org>
	<20110704182914.GA4362@sven-atom.home.narfation.org>
	<20110704183941.GC26734@autistici.org>
	<CAJA-1Ljpew4y6EjR9823V533ssC-DpirPkNpBbFzULZGvmw_jg@mail.gmail.com>
	<CAOaDhSQ7yxeA_mx7NEYobChpvLZ9yjipBJu9rrpgh2SF0uNv3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOaDhSQ7yxeA_mx7NEYobChpvLZ9yjipBJu9rrpgh2SF0uNv3g@mail.gmail.com>
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

On Wed, Jul 06, 2011 at 11:47:36AM +0200, Gioacchino Mazzurco wrote:
> This one is useless because batman-adv use broadcast as destination
> and moreover your are dropping a mac address that is not on your
> machine as source in OUTPUT chain this doesn't make sense
> >sudo ebtables -I OUTPUT -s 00:1b:77:06:1c:15 -j DROP
> 
> you can use also iptables that is already installed do to this with
> --mac-source option without installing ebtables
> 

As already mentioned, this will not work. iptables only affects IP
packets. All the traffic below the IP-level will not be blocked.

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
