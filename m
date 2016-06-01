Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Wed, 1 Jun 2016 05:47:04 +0000
Message-ID: <0c23fd01e7834abeb734ee6c58524a5e@Ek.usurf.usu.edu>
References: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Non-batman Clients
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> I've followed the quick start guide, but apparently I'm missing=0A=
> something when it comes to non-batman clients.=0A=
>=0A=
> I've set all this up using vagrant and VirtualBox.  The mesh seems to=0A=
> work perfectly, however when I put in non-batman clients they cannot=0A=
> communicate one with another.  I would expect that they would be able to=
=0A=
> ping one another.=0A=
>=0A=
> I've given IP addresses to the bridge adapters on the 192.168.1.0/24=0A=
> subnet.  The clients I've given IP addresses on that same subnet=0A=
> (192.168.1.121 and 192.168.1.142).  When I tried pinging, I don't get=0A=
> anything back.  Sniffing packets in tcpdump shows that it is never=0A=
> getting anything back, though I did get an ARP back once with the=0A=
> correct MAC address, but still couldn't ping.  Never got an ARP back=0A=
> again...=0A=
>=0A=
> I can ping from each client to the IP address of the bridge they are=0A=
> connecting to, but cannot ping anything else on the network.=0A=
>=0A=
> Any thoughts?  Hopefully someone has seen this before and can point me=0A=
> in the right direction!=0A=
=0A=
Bump...has anyone run into this before?  Am I just missing something simple=
?=0A=
=0A=
Thanks!=0A=
