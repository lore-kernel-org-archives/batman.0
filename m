MIME-Version: 1.0
In-Reply-To: <200905270013.12447.sven.eckelmann@gmx.de>
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<4313f3060905261150o6c9fe82at6dd40d26456ac03a@mail.gmail.com>
	<200905270013.12447.sven.eckelmann@gmx.de>
Date: Tue, 26 May 2009 19:06:16 -0500
Message-ID: <4313f3060905261706o16a78bd3l102c9921e035ada@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Debug Malloc Problem
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@open-mesh.net

On Tue, May 26, 2009 at 5:13 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wro=
te:
> On Tuesday 26 May 2009 20:50:56 Nathan Wharton wrote:
>> I added the following patch:
> Please don't introduce more magic numbers. If you need an alignment on in=
teger
> granularity then please use sizeof(int) instead of a simple constant.
> The rest looks quite good and logical. I assumed that the only architectu=
re
> without automatic catching of alignment problems is mips with load operat=
ors
> to the fp registers (never had such problems on simple arm machine nor co=
uld I
> produce that problem on them). Is there any other documentation about suc=
h
> problems on xscale or can you proof this with an test program (malloc 6 b=
yte,
> write uint32_t to first 4 byte, write another uint32_t to byte 2-5, compa=
re
> bytes with input - don't forget to set it volatile)? Your current proof i=
f
> concept test only shows that the "overriden" bytes will not get overriden
> after moving them some bytes higher.
>

I didn't really mean for that to be an accepted patch, just a quick
test.  Maybe the trailing magic number could just be a byte so you
don't have to allocate more memory.  I'm sure there are other things
to do too.

I haven't looked at any documentation for the xscale for this problem.
 I can do a test program.  I have seen this type of problem before,
but it would throw a bus error instead of going along with an
incorrect result.


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #include <stdio.h>
> #include <stdlib.h>
>
> #define x_moved(pos) ((int*)&x[pos])[0]
> static const int value1 =3D 0x01234567;
> static const int value2 =3D 0x89abcdef;
>
> int main() {
> =A0 =A0 =A0 =A0volatile char *x =3D (char*)malloc(sizeof(int) * 2);
> =A0 =A0 =A0 =A0x_moved(0) =3D value1;
> =A0 =A0 =A0 =A0x_moved(2) =3D value2;
>
> =A0 =A0 =A0 =A0if (x_moved(2) !=3D value2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("ERROR Value: ");
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("Value: ");
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0printf("%x %x\n", x_moved(0) , x_moved(2));
>
> =A0 =A0 =A0 =A0free(x);
> =A0 =A0 =A0 =A0return 0;
> }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Best regards,
> =A0 =A0 =A0 =A0Sven
>

Thanks for your help.
