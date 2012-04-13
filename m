Return-Path: <andrew@lunn.ch>
Date: Fri, 13 Apr 2012 10:26:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120413082648.GK7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
	<CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
	<201204130017.31711.lindner_marek@yahoo.de>
	<20120413062241.GA14395@ritirata.org>
	<CAKLmikN=yGHL8QZomD=GsaKYcZchd=r7kvsjsyxMCx2CYNjbzw@mail.gmail.com>
	<20120413074323.GI7664@lunn.ch>
	<CAKLmikO8voWr9Rv9S5N-9v0GvbO=vc3y+Cnqv7XFd4ieRL=4og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLmikO8voWr9Rv9S5N-9v0GvbO=vc3y+Cnqv7XFd4ieRL=4og@mail.gmail.com>
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

On Fri, Apr 13, 2012 at 09:51:51AM +0200, Mitar wrote:
> Hi!
> 
> On Fri, Apr 13, 2012 at 9:43 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> > Which implementation are you using of L2TP?
> 
> We are not using any, we are planning to use ones provided by OpenL2TP:
> 
> http://www.openl2tp.org/

Never used it, so i "use the source luke", since its in the kernel...

Looks like you have at least two options:

Linux PPP over L2TP (PPPoX/PPPoL2TP) Sockets
L2TPv3 ethernet pseudowire driver

PPP is L3 only, so you cannot add it to BATMAN. You would need to L3
routing over it.

The pseudowire driver creates a network device l2tpeth0, l2tpeth1,
l2tpeth2, etc, one for each session. Looks like you should be able to
add these to BATMAN.

    Andrew

