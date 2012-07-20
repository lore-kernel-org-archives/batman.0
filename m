Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <5008C14B.6040707@codigosur.org>
Date: Thu, 19 Jul 2012 23:24:11 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] batman-adv not selecting a gateway when using
 "client 1" through uci config
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi everyone,

I've been experimenting with gateway selection in QuintanaLibre. I have
a very bad gateway that I want to work as a last resort gateway when the
other is down, so I tried changing to gw_mode client 1 and used some
unreal values for the Up/Down speeds to "force" the selection.

Anyway, this is all well, the good gateway gets selected from almost all
the mesh, but the problem is that when I updated the client routers
configuration using uci to make it permanent, I stumbled with this
strange result that you can see here:

http://pastebin.com/pEhcq2TW


there's no gateway being selected until I manually run:
# batctl gw_mode client 1
(which was te current mode anyway)
on each client.

In fact, connected computers are not being served DHCP offers because of
this.

Is this some known behavior or just something I overlooked?


Thanks as ever for your help with batman-adv, which here at the far
south we are loving every day more as little mesh clouds keep spawning
around us :)


Cheers,
NicoEch=E1niz
