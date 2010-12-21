Return-Path: <andrew@lunn.ch>
Date: Tue, 21 Dec 2010 19:01:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101221180134.GF18448@lunn.ch>
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
	<1292320696-11983-2-git-send-email-linus.luessing@ascom.ch>
	<201012211839.37926.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201012211839.37926.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Creating new neighbor
 discovery packet
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
Cc: Linus L??ssing <linus.luessing@ascom.ch>

> > -#define BAT_PACKET       0x01
> > -#define BAT_ICMP         0x02
> > -#define BAT_UNICAST      0x03
> > -#define BAT_BCAST        0x04
> > -#define BAT_VIS          0x05
> > -#define BAT_UNICAST_FRAG 0x06
> > +#define BAT_PACKET_NDP   0x01
> > +#define BAT_PACKET_OGM   0x02
> > +#define BAT_ICMP         0x03
> > +#define BAT_UNICAST      0x04
> > +#define BAT_BCAST        0x05
> > +#define BAT_VIS          0x06
> > +#define BAT_UNICAST_FRAG 0x07
> 
> Although I like this reordering (I would like to see BAT_UNICAST followed by 
> BAT_UNICAST_FRAG) I think we can't easily touch this without annoying the 
> wireshark folks. Maybe we don't care because they hate us already ?

It will also be interesting to see what David Miller says the first
time you increment the version number, or make some other backward
incompatible change.

	     Andrew
