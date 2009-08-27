Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 27 Aug 2009 18:05:38 +0800
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261119.22173.onelektra@gmx.net>
	<20090826180810.GF16067@lunn.ch>
In-Reply-To: <20090826180810.GF16067@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908271805.39186.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Thursday 27 August 2009 02:08:10 Andrew Lunn wrote:
> How many of these goals can be reached without changing the packet
> format? I've implemented regenerating lost OGMs without changing the
> protocol to a degree it needs to bump the version number. Does
> removing the averaging of TQ from remote neighbors change the message
> format?
>
> My question would be, does not changing the message format so that the
> version number can stay the same impose too high a penalty in terms of
> design restrictions?

Correct me if I'm mistaken but I thought you added the originator interval ?!

In the past we did not only increase the version number when the packet format 
changed. We use that number to distinguish different ways of processing routing 
information. A packet format modification is the most obvious change but not 
the only one. If I receive a packet and interprete it completely different than 
the neighbor giving that packet to me the chance of creating routing loops is 
high. Therefore any major routing protocol change might require the version 
field to be updated.

Regards,
Marek
