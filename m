Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Wed, 8 Jun 2016 15:09:50 +0000
Message-ID: <4e5bb9a24054475a9a088932bb48c5e9@Ek.usurf.usu.edu>
References: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
 <1486656.g3lhHQC2Ly@voltaire>
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

=0A=
> Can you ping from the nodes running batman-adv to other nodes running bat=
man-=0A=
> adv ? In other words: Is your mesh working ?=0A=
=0A=
Yes, I can use the standard ping command to ping any batman node on the =0A=
mesh from any other batman node.  It is the non-batman clients that are =0A=
not communicating with anything.  They can only ping the node they are =0A=
directly connected to.=0A=
=0A=
> Can you provide specifics about what you saw when running tcpdump ? What =
does=0A=
> 'never getting anything back' mean ? The ping goes one way without any po=
ng=0A=
> showing up ? Have you checked on the ping destination (via tcpdump) that =
the=0A=
> ping ever made it there ?=0A=
=0A=
I had two non-batman clients on the mesh, connected to two different =0A=
nodes separated by a third node (i.e. for the client on node 1 to =0A=
communicate to the client on node 3, the data has to go through node 2). =
=0A=
  Each client can ping the node they are connected to (the br0 =0A=
interface, which has the IP address), but when they try and ping another =
=0A=
node or the other client I see the ping requests go out in tcpdump, but =0A=
nothing received at the other end (again in tcpdump).  I do see a lot of =
=0A=
ARP requests without replies on the originator if that helps.=0A=
=0A=
Thanks!=0A=
