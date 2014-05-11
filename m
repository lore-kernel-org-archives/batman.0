Return-Path: <w-lkml@lebenslange-mailadresse.de>
Date: Sun, 11 May 2014 12:46:34 +0000
From: Wilfried Klaebe <w-lkml@lebenslange-mailadresse.de>
Message-ID: <20140511124633.GD7875@kaos.lebenslange-mailadresse.de>
References: <20140511001231.GC7875@kaos.lebenslange-mailadresse.de>
 <CANKiNjV7qrx-556DJk0qcOopnBs4NnKy51POEeZ7LpbdjX35OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANKiNjV7qrx-556DJk0qcOopnBs4NnKy51POEeZ7LpbdjX35OQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [resend] net: get rid of SET_ETHTOOL_OPS
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
To: Anish Khurana <anish.khurana130181@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, dev@openvswitch.org, xen-devel@lists.xenproject.org, linux-rdma@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acenic@sunsite.dk, trivial@kernel.org, e1000-devel@lists.sourceforge.net, bridge@lists.linux-foundation.org, devel@linuxdriverproject.org, nios2-dev@lists.rocketboards.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

Am Sun, May 11, 2014 at 01:13:47PM +0530 schrieb Anish Khurana:
> SET_ETHTOOL_OPS is equivalent to :
> #define SET_ETHTOOL_OPS(netdev,ops) \
>     ( (netdev)->ethtool_ops =3D (ops) )
>=20
> how it makes difference  removing this code and replacing with the
> code mentioned ?

It doesn't change anything in the resulting binaries. The whole point
is to remove the macro, which is something Dave wants to happen.

Kind regards,
Wilfried

