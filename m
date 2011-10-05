Return-Path: <ordex@autistici.org>
Date: Wed, 5 Oct 2011 10:57:02 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111005085701.GB6682@ritirata.org>
References: <mailman.54.1312831773.1125.b.a.t.m.a.n@lists.open-mesh.org>
	<CAFevQmNuUV-FebLq5nuD=iqX24xqEiBxaxd9nTja3O4XewHKFA@mail.gmail.com>
	<201108161311.27235.lindner_marek@yahoo.de>
	<CAFevQmMuk16mnWhsZibwiRe5Kdo4aNfu_1XZmBEigX5SBU8HTQ@mail.gmail.com>
	<20111004214811.GE28555@ritirata.org>
	<CAFevQmM4SPz+8chA79Bsa0=Rt492jeK6QTCxMpmCGeKAi8wOtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFevQmM4SPz+8chA79Bsa0=Rt492jeK6QTCxMpmCGeKAi8wOtA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman-adv secure
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

On Wed, Oct 05, 2011 at 10:25:08 +0200, Filippo Sallemi wrote:
> Hi,
> after some hours spend to find another threads talking about this
> topic I'm not able to resolve my problem but I have another two
> question about this.
> 1. Can I user macfilter option in wireless config without decerase performance?

mh..Honestly I don't know, I think that any kind of filter will affect the
performance somehow. Probably (if I am not wrong) the macfilter configuration on the node
firmware is an hostapd feature (do you use openwrt, right?).

> 2. Exists another tool such ebtables but that work on a simple interface?
> 

Don't think so..but I could be wrong. IIRC we discussed about the possibility of
creating br0, enslave wlan0 (or whatever is your phy device) into br0 and then
use ebtables on br0. Really ugly IMHO :p

Cheers,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
