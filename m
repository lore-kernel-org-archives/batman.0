Return-Path: <cchien@creonexsystems.com>
From: <cchien@creonexsystems.com>
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
 <2546299.1OsWWQgn6R@ripper>
In-Reply-To: <2546299.1OsWWQgn6R@ripper>
Subject: RE: Question about batman for ARM
Date: Fri, 20 May 2022 08:51:00 -0700
Message-ID: <03ca01d86c61$6781b190$368514b0$@creonexsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hi Sven,

Thank you for the quick and informative response.
We will look into your suggestions.

Regards,
Charles
_____________
CreoNex Systems
2625 Townsgate Road, Suite 330
Westlake Village, CA 91320
www.creonexsystems.com
(805) 558-9687
This message (including any attachments) is for the named addressee(s)'s =
use only. It may contain sensitive, confidential, private proprietary or =
legally privileged information intended for a specific individual and =
purpose, and is protected by law. If you are not the intended recipient, =
please immediately delete it and all copies of it from your system, =
destroy any hard copies of it and notify the sender. Any use, =
disclosure, copying, or distribution of this message and/or any =
attachments is strictly prohibited.


-----Original Message-----
From: Sven Eckelmann <sven@narfation.org>=20
Sent: Friday, May 20, 2022 12:43 AM
To: Charles Chien <cchien@creonexsystems.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Question about batman for ARM

On Friday, 20 May 2022 08:18:45 CEST Charles Chien wrote:
> We=E2=80=99re currently trying to install batman-adv on an ARM =
platform but we=20
> ran into some issues and we would appreciate your help to answer our=20
> questions below:
>=20
> Is the batman-adv module compatible with an ARM processor (Raspberry =
PI 4)?

There is not just an "ARM" processor. It is a family of various =
processors.

Anyway, it can be used easily on Raspberry Pi - just make sure that you =
use a good wifi device + driver (+firmware) which actually can =
communicate over IBSS/802.11s (without forwarding enabled) and has no =
(extreme low) peer limit.=20
Unfortunately, you cannot take this for granted.

> I=E2=80=99m trying to install batman-adv onto an ARM Raspberry PI 4 =
with a=20
> Debian based Linux distribution (Pop OS). However, when I run=20
> =E2=80=9Cmodprobe batman-adv=E2=80=9D, it returns a FATAL error =
complaining that the=20
> module is not found in the =E2=80=9C/lib/modules=E2=80=9D directory. =
Where can I=20
> find/download the =E2=80=9C.ko=E2=80=9D for batman-adv for the ARM =
platform?

Ehrm, this is not how this works. You cannot just use a kernel module =
and hope that it works on all kernel (builds) available in the universe. =
This is also why we write following in each batman-adv release news =
entry: "As the kernel module always depends on the Linux kernel it is =
compiled against, it does not make sense to provide binaries on our =
website. As usual, you will find the signed tarballs in our download =
section:"

Either your distribution has to enable this module in their kernel build =
or you have to get their kernel headers (and build scripts) and then =
build it from scratch. And at least on the default Debian kernel, =
batman-adv is enabled since ages - so no idea why PopOS doesn't ship it

> And if I need to recompile the .ko file for ARM, is there an online=20
> repository where I can find the original source code for the=20
> batman-adv driver?

This is mentioned in multiple places on the website. Just to mention a =
few interesting pages:

* https://www.open-mesh.org/projects/open-mesh/wiki
* https://www.open-mesh.org/news/108
* https://www.open-mesh.org/projects/open-mesh/wiki/Download
* https://www.open-mesh.org/projects/open-mesh/wiki/UsingBatmanGit
* https://git.open-mesh.org/
  https://git.open-mesh.org/batman-adv.git
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

Kind regards,
	Sven

