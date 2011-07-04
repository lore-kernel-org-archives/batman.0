Return-Path: <ordex@autistici.org>
Date: Mon, 4 Jul 2011 20:39:41 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110704183941.GC26734@autistici.org>
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<201107041455.33023.lindner_marek@yahoo.de>
	<CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
	<20110704182256.GB26734@autistici.org>
	<20110704182914.GA4362@sven-atom.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110704182914.GA4362@sven-atom.home.narfation.org>
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

On Mon, Jul 04, 2011 at 08:29:14PM +0200, Sven Eckelmann wrote:
> > As Marek suggested, you should use something like ebtables. But honestly I
> > remember that ebtables support has been removed from batman some time
> > ago.
> 
> What about using a bridge over the actual device to simulate the bad link
> together with ebtables? This would resolve the problem that batman-adv must be
> ebtables aware.


You mean enslave wlan0 (e.g.) to br0 and then put br0 into bat0?
If so, it sounds good, because at that point you can use ebtables
against frames going through br0.


Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
