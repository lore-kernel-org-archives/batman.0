Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120413082648.GK7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
	<CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
	<201204130017.31711.lindner_marek@yahoo.de>
	<20120413062241.GA14395@ritirata.org>
	<CAKLmikN=yGHL8QZomD=GsaKYcZchd=r7kvsjsyxMCx2CYNjbzw@mail.gmail.com>
	<20120413074323.GI7664@lunn.ch>
	<CAKLmikO8voWr9Rv9S5N-9v0GvbO=vc3y+Cnqv7XFd4ieRL=4og@mail.gmail.com>
	<20120413082648.GK7664@lunn.ch>
Date: Fri, 13 Apr 2012 10:35:00 +0200
Message-ID: <CAKLmikOqoChnMk8phKeE6-c2YSimw4hfEZy30ucTH1cWWYsNcg@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi!

On Fri, Apr 13, 2012 at 10:26 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> The pseudowire driver creates a network device l2tpeth0, l2tpeth1,
> l2tpeth2, etc, one for each session. Looks like you should be able to
> add these to BATMAN.

Yes. This was what we were targeting. Hopefully we can make it go over UDP.


Mitar
