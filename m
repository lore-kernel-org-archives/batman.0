Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Charles Chien <cchien@creonexsystems.com>
Date: Thu, 19 May 2022 23:18:45 -0700
Message-ID: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
Subject: Question about batman for ARM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello developers,



We=E2=80=99re currently trying to install batman-adv on an ARM platform but=
 we
ran into some issues and we would appreciate your help to answer our
questions below:

Is the batman-adv module compatible with an ARM processor (Raspberry PI 4)?



I=E2=80=99m trying to install batman-adv onto an ARM Raspberry PI 4 with a
Debian based Linux distribution (Pop OS). However, when I run
=E2=80=9Cmodprobe batman-adv=E2=80=9D, it returns a FATAL error complaining=
 that the
module is not found in the =E2=80=9C/lib/modules=E2=80=9D directory. Where =
can I
find/download the =E2=80=9C.ko=E2=80=9D for batman-adv for the ARM platform=
?



And if I need to recompile the .ko file for ARM, is there an online
repository where I can find the original source code for the
batman-adv driver?




--=20
Regards,
Charles
