Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Sat, 7 May 2016 16:47:28 +0000
Message-ID: <6d2a336c7e23473fa37d03bbc498c852@Ek.usurf.usu.edu>
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
 <33aefc13-e1a0-cef5-74f1-d21d7112b7d3@universe-factory.net>
 <1b43c9dff51e492397ca5202456d9d2f@Ek.usurf.usu.edu>
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, Matthias Schiffer <mschiffer@universe-factory.net>

>> alfred explicitly binds to the link-local IPv6 address of the interface=
=0A=
>> since version 2016.0. I suspect one of the following caveats might be yo=
ur=0A=
>> problem:=0A=
>>=0A=
>> * The link-local IPv6 address must match the MAC address of the interfac=
e=0A=
>> (here bat0) (derived by flipping the 2 bit of the first byte, and adding=
=0A=
>> fe80 and fffe); this ususally breaks when the MAC address is changed aft=
er=0A=
>> the interface is up=0A=
>> * The link-local address must not be tentative when alfred is started=0A=
>> (duplicate address detection must have finished; this usually means that=
=0A=
>> the interface must be up for 3 seconds before alfred is started)=0A=
=0A=
One more question - is there a configuration option to disable this?  My =
=0A=
application of batman-adv and alfred is not for a wide area network =0A=
providing internet, but rather to setup a mesh between master nodes of =0A=
my private network for data sharing and synchronization.  My private =0A=
network at the moment has no plans to utilize IPv6 and we would like to =0A=
keep it disabled if possible.=0A=
=0A=
At the moment I am guessing it would be a code hack to switch this logic =
=0A=
to use IPv4 instead?  Or am I over-analyzing this and really it isn't a =0A=
big deal, I just need to get the right configuration setup?=0A=
