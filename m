Return-Path: <andrew@lunn.ch>
Date: Fri, 13 Apr 2012 09:43:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120413074323.GI7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
	<CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
	<201204130017.31711.lindner_marek@yahoo.de>
	<20120413062241.GA14395@ritirata.org>
	<CAKLmikN=yGHL8QZomD=GsaKYcZchd=r7kvsjsyxMCx2CYNjbzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLmikN=yGHL8QZomD=GsaKYcZchd=r7kvsjsyxMCx2CYNjbzw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

On Fri, Apr 13, 2012 at 09:29:27AM +0200, Mitar wrote:
> Hi!
> 
> On Fri, Apr 13, 2012 at 8:22 AM, Antonio Quartulli <ordex@autistici.org> wrote:
> > A little remark here. You MUST use interfaces that support ethernet frames
> > transmission. Therefore (IIRC) you can use tap interfaces but not tun ones.
> 
> L2TP tunnel is creates a L2 tun interface, no?

First, of, lets make sure we are all using tun/tap correctly. I know i
keep having the check which is which.

http://en.wikipedia.org/wiki/TUN/TAP

	TAP (as in network tap) simulates a link layer device and it
	operates with layer 2 packets such as Ethernet frames. TUN (as
	in network TUNnel) simulates a network layer device and it
	operates with layer 3 packets such as IP packets. TAP is used
	to create a network bridge, while TUN is used with routing.

So a tap interface can be added to BATMAN and become part of the L2
mesh.

tun cannot be added to batman. You need to perform L3 routing over the
interface.

Which implementation are you using of L2TP?

      Andrew
