MIME-Version: 1.0
In-Reply-To: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
Date: Tue, 26 May 2009 13:50:56 -0500
Message-ID: <4313f3060905261150o6c9fe82at6dd40d26456ac03a@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Debug Malloc Problem
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <B.A.T.M.A.N@open-mesh.net>

Looks like this one didn't go to all either.  Sorry for the mess.

On Tue, May 26, 2009 at 10:47 AM, Nathan Wharton <naw@greptar.com> wrote:
> On Fri, May 22, 2009 at 11:31 PM, Marek Lindner <lindner_marek@yahoo.de> =
wrote:
>>> I am getting set up to do remote debugging. =A0I'll see what I can find
>>> doing that.
>>
>> Yeah, that would be another option.
>
> ok, here is what I found on the debug malloc problem I am having:
>
> In the function debugMalloc:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0 =A0 =A0 =A0chunkHeader =3D (struct chunkHeader *)memory;
> =A0 =A0 =A0 =A0chunk =3D memory + sizeof(struct chunkHeader);
> =A0 =A0 =A0 =A0chunkTrailer =3D (struct chunkTrailer *)(memory + sizeof(s=
truct
> chunkHeader) + length);
>
> =A0 =A0 =A0 =A0chunkHeader->length =3D length;
> =A0 =A0 =A0 =A0chunkHeader->tag =3D tag;
> =A0 =A0 =A0 =A0chunkHeader->magicNumber =3D MAGIC_NUMBER;
>
> =A0 =A0 =A0 =A0chunkTrailer->magicNumber =3D MAGIC_NUMBER;
>
> =3D> =A0 =A0 =A0pthread_mutex_lock(&chunk_mutex);
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I get the following results:
>
> (gdb) p chunkHeader
> $26 =3D (struct chunkHeader *) 0x308c8
> (gdb) p chunk
> $27 =3D (unsigned char *) 0x308d8 "\020\322\n"
> (gdb) p chunkTrailer
> $28 =3D (struct chunkTrailer *) 0x308dd
> (gdb) p *chunkHeader
> $29 =3D {next =3D 0x40096c34, length =3D 5, tag =3D 15, magicNumber =3D 3=
05419896}
> (gdb) p *chunkTrailer
> $30 =3D {magicNumber =3D 878082050}
> (gdb) p length
> $31 =3D 5
>
> I think the magic number is not getting into the chunk trailer
> correctly because it is not aligned.
> chunkHeader is aligned because it was returned by malloc
> chunk is aligned because the size of the header is 16
> chunkTrailer is not aligned because it is chunk + 5
>
> Hope this helps. =A0If not, and that shouldn't be a problem, I'll see
> what else I can find.
>

I added the following patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batmand-r1269/batman/allocate.c =A0 =A0 2009-05-20 13:54:18.000000000 -=
0500
+++ batmand-r1269.mod/batman/allocate.c 2009-05-26 12:25:07.000000000 -0500
@@ -206,6 +206,10 @@
=A0 =A0 =A0 =A0struct chunkHeader *chunkHeader;
=A0 =A0 =A0 =A0struct chunkTrailer *chunkTrailer;
=A0 =A0 =A0 =A0unsigned char *chunk;
+ =A0 =A0 =A0 uint32_t remainder =3D length % 4;
+
+ =A0 =A0 =A0 if (remainder > 0)
+ =A0 =A0 =A0 =A0 length +=3D 4 - remainder;

=A0/* =A0 =A0 printf("sizeof(struct chunkHeader) =3D %u, sizeof (struct
chunkTrailer) =3D %u\n", sizeof (struct chunkHeader), sizeof (struct
chunkTrailer)); */

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
And I don't get any debug malloc problems anymore.

I do, however, still get the kernel crashes when using batgat.
