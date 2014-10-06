Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 06 Oct 2014 16:53:18 +0200
Message-ID: <1917557.CdpaRSNIN5@prime>
In-Reply-To: <5432A9D7.5080604@rund.freifunk.net>
References: <5432800F.7030008@rund.freifunk.net>
 <20141006143301.GH10428@odroid> <5432A9D7.5080604@rund.freifunk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] alfred packet types for gluon node statistics?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Monday 06 October 2014 16:40:23 Ufo wrote:
> ah nice. but its a question to the batman-adv developers instead of the
> gluon people..
> freifunk-gluon is used by many freifunk communities, so maybe it would
> be better to "register" these datatypes?
> 
> see http://git.open-mesh.org/alfred.git/blob_plain/refs/heads/master:/README
> 
> cite:
> --
> This will set the hostname as data for datatype 64. Note that 0 - 63 are
> reserved (please send us an e-mail if you want to register a datatype)
> --

As long as the datatypes are only used in a specific firmware or community, all 
people know about the assignment and there is no need to register the number - 
its like using the private LAN 192.168.0.0/16 network in your home network, 
you know that you use it and you don't have to tell anyone.

However if you write up some software potentially used in many *different* 
communities, like vis, its a good thing to register.

In any case, please choose and feel free to let us know. :)

Cheers,
    Simon
