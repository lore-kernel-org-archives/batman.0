Return-Path: <laimaretto@gmail.com>
MIME-Version: 1.0
In-Reply-To: <54739107.2050005@meshcoding.com>
References: <CAHmnjeAPeFU2oFyVM3=6H0R3_bu9EOV_3wRianjpHiqHHCwPvA@mail.gmail.com>
 <547377B0.8000602@meshcoding.com> <54739107.2050005@meshcoding.com>
From: Lucas Aimaretto <laimaretto@gmail.com>
Date: Tue, 25 Nov 2014 10:28:38 -0300
Message-ID: <CAHmnjeApJ7ossb11JFh4mQ6Hwx994vmMMka7fRLT+CCZtoabAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] problems while patching vde 2.3.2
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

On Mon, Nov 24, 2014 at 5:11 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
>
>
> On 24/11/14 19:23, Antonio Quartulli wrote:
>>
>>
>> On 24/11/14 19:18, Lucas Aimaretto wrote:
>>> Hi all,
>>>
>>> I'm trying to patch VDE just as suggested in [1] but I'm having
>>> trouble. I've downloaded VDE 2.3.2 from here [2] and the patches from
>>> here [1].
>>
>> The patch is for vde-2.3.1, so either you download that version of the
>> software or you "fix" the patch to work with vde-2.3.2.
>
> Sorry Lucas,
>
> I just realized that we have that patch on the wikipage
> (http://www.open-mesh.org/attachments/download/152/vde2-2.3.2_colour.patc=
h).
>
> Did you use this one? It was at the very bottom (attachments section)
>

Ciao Antonio,

Indeed, I've used the patch that's located at the bottom of the page.
As said, I've used that patch version 2.3.2 (from the bottom of the
page [1]) with the source code from [2].

When using those two together, patching does not work. But, after
digging into the patch itself, I've removed the bottom of it (look
below):

diff -urp vde2-2.3.2-orig/src/vde_switch/port.h vde2-2.3.2/src/vde_switch/p=
ort.h
--- vde2-2.3.2-orig/src/vde_switch/port.h    2011-11-23 17:41:17.000000000 =
+0100
+++ vde2-2.3.2/src/vde_switch/port.h    2012-01-11 09:57:54.080058808 +0100
@@ -68,6 +68,7 @@ int portflag(int op, int f);
 #define P_CLRFLAG 3

 #define HUB_TAG 0x1
+#define COLOURFUL_TAG 0x2

 void port_init(int numports);

After removing the content relative to patching port.h, then patching
port.c works ok! (I have not patched port.h: since it's only a line
that needs to be included, I did it manually).

So I think that doing a patch for each file (one for port.h and a
different one for port.c) will work.

Thanks in any case for your feedback!

Regards!

Lucas

[1] - http://www.open-mesh.org/attachments/download/152/vde2-2.3.2_colour.p=
atch
[2] - http://sourceforge.net/projects/vde/files/vde2/2.3.2/

--=20
"Antes ten=C3=ADamos hambre y mir=C3=A1bamos el reloj para saber qu=C3=A9 h=
ora era.
Ahora miramos el reloj para saber si tenemos hambre." -- Ernesto
S=C3=A1bato
