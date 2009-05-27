MIME-Version: 1.0
In-Reply-To: <4313f3060905270720k45859cb5y822c47397482b77c@mail.gmail.com>
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<4313f3060905261150o6c9fe82at6dd40d26456ac03a@mail.gmail.com>
	<200905270013.12447.sven.eckelmann@gmx.de>
	<4313f3060905270720k45859cb5y822c47397482b77c@mail.gmail.com>
Date: Wed, 27 May 2009 11:07:17 -0500
Message-ID: <4313f3060905270907v61739fcei1cecc75adb578acb@mail.gmail.com>
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

On Wed, May 27, 2009 at 9:20 AM, Nathan Wharton <naw@greptar.com> wrote:
> On Tue, May 26, 2009 at 5:13 PM, Sven Eckelmann <sven.eckelmann@gmx.de> w=
rote:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #include <stdio.h>
>> #include <stdlib.h>
>>
>> #define x_moved(pos) ((int*)&x[pos])[0]
>> static const int value1 =3D 0x01234567;
>> static const int value2 =3D 0x89abcdef;
>>
>> int main() {
>> =A0 =A0 =A0 =A0volatile char *x =3D (char*)malloc(sizeof(int) * 2);
>> =A0 =A0 =A0 =A0x_moved(0) =3D value1;
>> =A0 =A0 =A0 =A0x_moved(2) =3D value2;
>>
>> =A0 =A0 =A0 =A0if (x_moved(2) !=3D value2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("ERROR Value: ");
>> =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("Value: ");
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0printf("%x %x\n", x_moved(0) , x_moved(2));
>>
>> =A0 =A0 =A0 =A0free(x);
>> =A0 =A0 =A0 =A0return 0;
>> }
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This results in:
> ERROR Value: 89abcdef cdef89ab
>

Some good info is here:
http://lecs.cs.ucla.edu/wiki/index.php/XScale_alignment
