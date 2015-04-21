Return-Path: <odshrit@gmail.com>
MIME-Version: 1.0
Date: Tue, 21 Apr 2015 17:26:17 +0200
Message-ID: <CACQgX2EGOT8WD0wTiSqMCoF=GeOJKeyTZtLBuKfHH3wkh4F40Q@mail.gmail.com>
From: Omar Shrit <odshrit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Installing issue (Makefile configuration doesn't
	exist)
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
To: b.a.t.m.a.n@lists.open-mesh.org

HI everybody:

I have four Raspberry Pi's, connected as a mesh network, I am trying
to  use Batman as routing protocol (the batman-adv module is used),
however I need to have the log file, and debug folder, as they already
doesn=E2=80=99t exist in the installed module in the Linux kernel.
The FAQ page explained that I have to re-install the module and
modifying the Makefile Debug option to y ,
In fact I have found that only the module which exist in the website
of Batman have these options in the Makefile, the makefile of the
module that exist in the Linux kernel is different, and doesn=E2=80=99t hav=
e
any option ,
by default the batman module in the Linux kernel doesn=E2=80=99t enable the
Debug option as I'm using in my RPI's Raspian with kernel version
3.18.5
Does anyone have any idea about how to change the options in the
module Makefile in Linux kernel before installing it ??, I need to use
cross-compile for compiling the kernel.
All suggestions are welcomed.

Thanks.
