MIME-Version: 1.0
In-Reply-To: <5161afcd0906121452p7fd294daha8915c906d7bb00e@mail.gmail.com>
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<200906130408.45362.lindner_marek@yahoo.de>
	<5161afcd0906121327m603d4c4ftc02458f30d39ff9c@mail.gmail.com>
	<200906130538.06620.lindner_marek@yahoo.de>
	<5161afcd0906121452p7fd294daha8915c906d7bb00e@mail.gmail.com>
Date: Mon, 15 Jun 2009 16:03:25 -0600
Message-ID: <5161afcd0906151503kb1945d5x665050c2d7eaea7a@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Fri, Jun 12, 2009 at 3:52 PM, Jacob Marble<jacobmarble@gmail.com> wrote:
> On Fri, Jun 12, 2009 at 3:38 PM, Marek Lindner<lindner_marek@yahoo.de> wr=
ote:
>> On Saturday 13 June 2009 04:27:44 Jacob Marble wrote:
>>> > This message indicates that this nodes already has one interface whic=
h is
>>> > not activate. Could you post "cat /proc/net/batman-adv/interfaces" af=
ter
>>> > you get this result ?
>>>
>>> "echo 'ath0' > interfaces"
>>> "cat interfaces"
>>> ath0
>>>
>>> [ =C2=A0 =C2=A0 97532] Adding interface: ath0
>>> [ =C2=A0 =C2=A0 97532] Can't activate module: the primary interface is =
not active
>>> [ =C2=A0 =C2=A0 97534] Adding route towards: 00:15:6d:a7:6a:14 (via
>>> 00:15:6d:a7:6a:14) [ =C2=A0 =C2=A0 97534] Creating new global hna entry=
:
>>> 00:ff:cf:5c:68:e0 (via 00:15:6d:a7:6a:14)
>>
>> It looks like a bug that I fixed in revision 1254. What version are you =
using ?
>>
>
> 1176 (from OpenWrt repositories). =C2=A0I'll get the latest svn.
>

Alright, I have OpenWrt SVN compiling, which has revision 1289.
However, I would like to compile the batman-advanced code from the
batman SVN repository instead.  I have tried copying the
batman-advanced directory to [the openwrt sdk]/package/ and then run
make, and this doesn't work.  I have tried compiling the
batman-advanced code by simply "make
KERNELPATH=3D~/OpenWrt-SDK-atheros-for-Linux-i686/" and that didn't
work.  I have tried several paths for KERNELPATH, but I think I need
the other cross-compile tools to be available as well...

Can someone give me a quick-and-dirty "Howto compile for OpenWrt"?
Afterwards, I could put together a nice README.openwrt for the SVN
repository.

TIA,

Jake
