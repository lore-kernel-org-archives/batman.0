Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Fri, 6 May 2016 20:45:50 +0000
Message-ID: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

I am trying to get familiar with the Alfred tools and downloaded version =
=0A=
2016.1.  Unfortunately it didn't work - I couldn't get past a bind error:=
=0A=
=0A=
root@sierra1:~# ./alfred -m -i bat0=0A=
can't bind: Cannot assign requested address=0A=
Failed to open interfaces=0A=
=0A=
I had setup batman-adv with the commands:=0A=
=0A=
batctl if add eth0=0A=
ip link set up bat0 (eth0 was already up)=0A=
=0A=
I rolled back to 2015.0 (per a hint at =0A=
http://wiki.pinneberg.freifunk.net/alfred) and alfred started up just =0A=
fine instead of giving the error.  However it periodically gives the =0A=
following message:=0A=
=0A=
announce master ...=0A=
Error during sent: Cannot assign requested address=0A=
=0A=
I also tried alfred -m -i eth0 with the same results.=0A=
=0A=
Is there something wrong in my configuration?  Can anyone point me in =0A=
the right direction?  I've read through the Wiki for both batman-adv and =
=0A=
alfred and am out of ideas.=0A=
=0A=
I'm trying to prove this setup and get familiar with it in a virtual =0A=
environment, so I am using VirtualBox to setup a network of 4 nodes in =0A=
my mesh.  Should be simple enough, and batman-adv seems to work just =0A=
great - once its up and running, all nodes can communicate one with =0A=
another as expected.  Only issue is I am trying to get alfred to work =0A=
with batadv-vis to give me a graph to tell me it really is working right.=
=0A=
=0A=
Thoughts?=0A=
Thanks!=0A=
Jon=0A=
=0A=
-- =0A=
Jonathan R. Haws=0A=
Embedded Engineer=0A=
Space Dynamics Laboratory=0A=
jhaws@sdl.usu.edu=0A=
