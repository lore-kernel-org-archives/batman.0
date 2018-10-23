Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <03b201d46a7c$dd0b47e0$9721d7a0$@sina.com>
 <e287b33a075cd802539d75d95319805eee0010ea.camel@sdl.usu.edu>
 <2008119.62L72lsrl6@bentobox>
In-Reply-To: <2008119.62L72lsrl6@bentobox>
Date: Tue, 23 Oct 2018 17:52:54 +0800
Message-ID: <03c201d46ab6$2bbc2650$833472f0$@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>, 'Jonathan Haws' <jhaws@sdl.usu.edu>
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hi Sven and Jon,

Can you add a payload in multicast packets to carry the mac address, so =
we
can get the mac from the payload without concerning about whether it is =
IPv4
or IPv6?

Regards,
Gary

-----Original Message-----
From: Sven Eckelmann <sven@narfation.org>=20
Sent: 2018=C4=EA10=D4=C223=C8=D5 14:29
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: guohuizou2000@sina.com; b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue

On Dienstag, 23. Oktober 2018 04:04:42 CEST Jonathan Haws wrote:
[...]
> > I have a doubt for the issue.
> > Alfred should send the info by multicast packets. So the packet's=20
> > dst mac address should be multicast mac address.
> > The packet with multicast mac address should be received by all=20
> > group member, isn't it?
> > Why does the mesh point need peer's mac address for sending the =
info?
>=20
> The rest of the devs may be able to answer better, but I believe it is =

> how alfred does its data storage and mapping of the source.

Correct, alfred is storing the data from each server using its mac =
address.
It is also looking up the TQ of master servers via the mac address. And =
the
mac address is expected to be extractable from the EUI64 based =
link-local
IPv6 address.

And of course, Jonathan's IPv4 implementation must get the mac address =
using
different methods. It is using the function ipv4_arp_request to get the
information from IPv4 neighbor table. And it looks like his =
implementation
is missing a reliable way to fill this neighbor table.

Kind regards,
	Sven


