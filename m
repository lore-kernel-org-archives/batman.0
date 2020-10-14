Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Cale Collins <ccollins@gateworks.com>
Date: Wed, 14 Oct 2020 12:54:29 -0700
Message-ID: <CAG2Q2vWC7H5j6uVRFyKCmjyjG3zoH9L0JwnhmRFxiji=puhrfA@mail.gmail.com>
Subject: =?UTF-8?B?aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYbmZfcmVzZXTigJk7IGRpZA==?=
	=?UTF-8?B?IHlvdSBtZWFuIOKAmGRxbF9yZXNldOKAmT8=?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Rick Winscot <Rwinscot@kcftech.com>

Hello,

I'm building Buildroot using a 5.45 kernel kernel, when I add the
"batman-adv" package and compile I receive this error:

/buildroot/output/build/batman-adv-2019.3/net/batman-adv/soft-interface.c:4=
39:2:
error: implicit declaration of function =E2=80=98nf_reset=E2=80=99; did you=
 mean
=E2=80=98dql_reset=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  439 |  nf_reset(skb);
      |  ^~~~~~~~
      |  dql_reset

Is there a patch to correct this?  Any insight would be greatly appreciated=
.

Best regards,

Cale Collins
