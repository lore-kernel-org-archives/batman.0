Return-Path: <jpettit@nicira.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Justin Pettit <jpettit@nicira.com>
In-Reply-To: <201009082225.47498.sven.eckelmann@gmx.de>
Date: Wed, 8 Sep 2010 16:13:51 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <72E610F4-6157-47CA-B409-92CE151843A8@nicira.com>
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
	<201009082058.15533.sven.eckelmann@gmx.de>
	<AANLkTi=FVyLE6OHTd+_qDbzSLk6fY5j6wBOWkYA810Dj@mail.gmail.com>
	<201009082225.47498.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] net: Add batman-adv meshing protocol
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, b.a.t.m.a.n@lists.open-mesh.net, netdev@vger.kernel.org, Jesse Gross <jesse@nicira.com>, Andi Kleen <andi@firstfloor.org>, davem@davemloft.net

On Sep 8, 2010, at 1:25 PM, Sven Eckelmann wrote:

> Without checking any facts: This sounds a little bit heavy - does it =
only=20
> sound heavy and in reality is extreme slim? The problem is that it =
must run on=20
> those low end, "please don't run code on me, because I cannot crunch =
numbers=20
> and have no ram" machines like the FON2100 or WRT54GL.


We used to run early versions of Open vSwitch on the WRTSL54GS (which is =
only a bit beefier than the WRT54GL) and didn't have any problems.  My =
guess is that it would run even better now, since the code has gone =
through a number of optimizations.  If packets are hitting the kernel =
cache, it's really only header parsing and a hash lookup, which is =
pretty cheap.

--Justin


