Return-Path: <trizonelabs@googlemail.com>
MIME-Version: 1.0
Date: Sun, 8 Apr 2012 10:39:16 +0300
Message-ID: <CAJuY50wnaeNvHJU0x7u6i+Q29Gx9hcd=qjdmZeJeEoftkgqTtA@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Subject: batman-adv Openwrt Kamikaze / 8.09 problem
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
To: b.a.t.m.a.n@lists.open-mesh.org

Seeking for hep to get batman-adv running on Openwrt Kamikaze 8.09
build Kernel 2.6.30

Build runs ok, but module not loaded.=A0 .... =A0 =A0 batctl -v
...batman-adv module not loaded

Try to load manually : =A0 =A0 insmod /lib/modules/2.6.30.10/batman-adv.ko
 ......... unknown symbol in module or unknown parameter

Any hint how to setup the build for 8.09 trunk highly appreciated

regards
3zl
