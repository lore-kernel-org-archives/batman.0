Return-Path: <laimaretto@gmail.com>
MIME-Version: 1.0
From: Lucas Aimaretto <laimaretto@gmail.com>
Date: Mon, 24 Nov 2014 15:18:45 -0300
Message-ID: <CAHmnjeAPeFU2oFyVM3=6H0R3_bu9EOV_3wRianjpHiqHHCwPvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] problems while patching vde 2.3.2
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
To: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,

I'm trying to patch VDE just as suggested in [1] but I'm having
trouble. I've downloaded VDE 2.3.2 from here [2] and the patches from
here [1].

I'm doing the following:

lucas@test:~/batman-adv/
script/vde$ tar zxvf vde2-2.3.2.tar.gz
lucas@test:~/batman-adv/script/vde$ patch
vde2-2.3.2/src/vde_switch/port.c < vde2-2.3.2_colour.patch
patching file vde2-2.3.2/src/vde_switch/port.c
patching file vde2-2.3.2/src/vde_switch/port.c
Hunk #1 FAILED at 68.
1 out of 1 hunk FAILED -- saving rejects to file
vde2-2.3.2/src/vde_switch/port.c.rej

What is it that I'm doing wrong?

Any hint is appreciated ...

Regards!

Lucas

[1] - http://www.open-mesh.org/projects/open-mesh/wiki/Emulation
[2] - http://sourceforge.net/projects/vde/files/vde2/2.3.2/

--=20
"Antes ten=C3=ADamos hambre y mir=C3=A1bamos el reloj para saber qu=C3=A9 h=
ora era.
Ahora miramos el reloj para saber si tenemos hambre." -- Ernesto
S=C3=A1bato
