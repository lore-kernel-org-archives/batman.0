Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Sun, 8 May 2016 04:19:08 +0000
Message-ID: <b510fe58444c44c0afff201e7f4dfb37@Ek.usurf.usu.edu>
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
 <33aefc13-e1a0-cef5-74f1-d21d7112b7d3@universe-factory.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> alfred explicitly binds to the link-local IPv6 address of the interface=
=0A=
> since version 2016.0. I suspect one of the following caveats might be you=
r=0A=
> problem:=0A=
>=0A=
> * The link-local IPv6 address must match the MAC address of the interface=
=0A=
> (here bat0) (derived by flipping the 2 bit of the first byte, and adding=
=0A=
> fe80 and fffe); this ususally breaks when the MAC address is changed afte=
r=0A=
> the interface is up=0A=
> * The link-local address must not be tentative when alfred is started=0A=
> (duplicate address detection must have finished; this usually means that=
=0A=
> the interface must be up for 3 seconds before alfred is started)=0A=
=0A=
This took care of it.  I had IPv6 disabled via sysctl and once enabled =0A=
it started working.  Here is the list of commands I entered to get a graph:=
=0A=
=0A=
modprobe batman-adv=0A=
batctl if add eth0=0A=
ip link set up bat0=0A=
=0A=
alfred -i bat0 -m &=0A=
batadv-vis > mesh.dot=0A=
=0A=
Thanks for the help!=0A=
