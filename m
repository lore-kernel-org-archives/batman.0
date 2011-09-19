Return-Path: <ordex@autistici.org>
Date: Tue, 20 Sep 2011 00:45:29 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110919224529.GB3410@ritirata.org>
References: <4E5D69E3.30403@robotech.de>
	<201109062033.17427.lindner_marek@yahoo.de>
	<4E67248D.8040904@robotech.de>
	<201109131318.03320.lindner_marek@yahoo.de>
	<4E711470.302@robotech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E711470.302@robotech.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

On Wed, Sep 14, 2011 at 10:54:08PM +0200, Tobias wrote:
> Hello Marek,
> 
> i flashed 5 Foneras and a TP-Link yesterday and today i tried to 
> reproduce the problem on a separate network.
> 
> It's not easy to reproduce the problem here but if i try, reboot and 
> "move" some devices, the "wrong MACs" also appear and some hops do not work.
> 
> So, when your patches are ready i can test with them.
> 
> Its no problem anymore to capture big logs here.
> 
> Tobias

Ok, little update:

I sent a little patch to Tobias in order to get a verbose log of the TT
updating dialogue (sorry for sending it privately, but I thought it was not
interesting for the list..I won't do it again :-) )

Now I'm going to further investigate on the issue..hoping the new log can help!

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
