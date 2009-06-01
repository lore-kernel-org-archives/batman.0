MIME-Version: 1.0
In-Reply-To: <200906011844.15664.sven.eckelmann@gmx.de>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905291502.43117.lindner_marek@yahoo.de>
	<4313f3060905290700v55e0d724oa7357208d1491a15@mail.gmail.com>
	<200906011844.15664.sven.eckelmann@gmx.de>
Date: Mon, 1 Jun 2009 13:03:43 -0500
Message-ID: <4313f3060906011103q21b32600nf99f8607bd01045c@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman] Add padding around allocation
	debugger structures
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

On Mon, Jun 1, 2009 at 11:44 AM, Sven Eckelmann <sven.eckelmann@gmx.de> wro=
te:
> On Friday 29 May 2009 16:00:40 Nathan Wharton wrote:
>> > @Nathan: Could you let me know if these patches work for you ? If so I=
'll
>> > commit them.
>> >
>> > Regards,
>> > Marek
>>
>> I set /proc/cpu/alignment to 4 (raise bus error) and I get a bus error:
>>
>> Program received signal SIGBUS, Bus error.
>> list_add_tail (new=3D0x29368, head=3D0x28819) at list-batman.c:68
>> 68 =A0 =A0 =A0 =A0 =A0 =A0 =A0__list_add( new, head->prev, (struct list_=
head *)head );
>> (gdb) l
>> 63 =A0 =A0 =A0 * Insert a new entry before the specified head.
>> 64 =A0 =A0 =A0 * This is useful for implementing queues.
>> 65 =A0 =A0 =A0 */
>> 66 =A0 =A0 =A0void list_add_tail( struct list_head *new, struct
>> list_head_first *head ) {
>> 67
>> 68 =A0 =A0 =A0 =A0 =A0 =A0 =A0__list_add( new, head->prev, (struct list_=
head *)head );
>> 69
>> 70 =A0 =A0 =A0 =A0 =A0 =A0 =A0head->prev =3D new;
>> 71
>> 72 =A0 =A0 =A0}
> Have you added the patches per hand? At this moment no patch I've made
> available in trunk. As you have run it with gdb, can you please append a =
full
> backtrace?
>
> Best regards,
> =A0 =A0 =A0 =A0Sven
>

I had to copy the patches out of the e-mail.

Here is the back trace:
#0  list_add_tail (new=3D0x29bf0, head=3D0x298c9) at list-batman.c:68
#1  0x0000ee7c in _hna_global_add (orig_node=3D0x29f80,
hna_element=3D0x29ba8) at hna.c:371
#2  0x0000f160 in hna_global_add (orig_node=3D0x29f80, new_hna=3D<value
optimized out>, new_hna_len=3D<value optimized out>)
    at hna.c:529
#3  0x000099c8 in update_routes (orig_node=3D0x29f80,
neigh_node=3D0x2a080, hna_recv_buff=3D0xbead1591 "\n\002\001",
    hna_buff_len=3D10) at batman.c:377
#4  0x0000c730 in update_orig (orig_node=3D0x29f80, in=3D0xbead157f,
neigh=3D167772673, if_incoming=3D0x27678,
    hna_recv_buff=3D0xbead1591 "\n\002\001", hna_buff_len=3D-16723,
is_duplicate=3D0 '\0', curr_time=3D3199014207)
    at originator.c:227
#5  0x0000a7e0 in batman () at batman.c:956
#6  0x000148d4 in main (argc=3D14, argv=3D0xbead1e14) at posix/posix.c:629

Looks like debugMalloc didn't return an aligned value for head.  I'll
step through that and see what I see.
