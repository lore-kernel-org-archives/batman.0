Return-Path: <bjo@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Wed, 28 Sep 2011 00:03:24 +0200
Message-ID: <2034315.VHQ2Ikuuga@mytilus>
In-Reply-To: <201109271344.27161.lindner_marek@yahoo.de>
References: <3131360.5iACvcvJX2@ostrea> <1997296.MKzYFvRXTH@mytilus>
	<201109271344.27161.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] batman-adv: loop caused by tinc and wifi
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

Am Dienstag, 27. September 2011, 13:44:26 schrieb Marek Lindner:
> On Tuesday, September 27, 2011 12:45:01 Bjoern Franke wrote:
> > ath1 (ad-hoc) as batman-interface
> > br-mesh (ath0 (ap-mode), eth0.1, tap0, bat0) as batman-interface
> > 
> > batman complains about the mtu 1500 of br-mesh, but it can't be set to
> > 1527 because bat0 does not like any mtu setting.
> 
> Ok, does it solve your loop ?

I don't know, yesterday one of the loop-routers crashed, so I was not able to 
test it yet.

BTW, how can I solve the MTU issue? 

regards
Bjoern
-- 
jabber: bjo@schafweide.org
bjo.nord-west.org | nord-west.org | freifunk-ol.de
