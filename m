MIME-Version: 1.0
In-Reply-To: <200905291502.43117.lindner_marek@yahoo.de>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<1243507208-8999-1-git-send-email-sven.eckelmann@gmx.de>
	<200905291502.43117.lindner_marek@yahoo.de>
Date: Fri, 29 May 2009 09:00:40 -0500
Message-ID: <4313f3060905290700v55e0d724oa7357208d1491a15@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Fri, May 29, 2009 at 2:02 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Thursday 28 May 2009 18:40:08 Sven Eckelmann wrote:
>> Architectures with a special alignment for load and store operations on
>> datatypes bigger than bytes will return a prealigned memory region when
>> calling malloc. When we add our data structure before and after this
>> region we destroy this alignment.
>> To fix this problem we add special regions with "magic" padding data.
>> To be sure that it is big enough for every load/store operation we use
>> the alignment for uintmax_t or a pointer even when the architecture only
>> supports smaller load/store operations.
>>
>> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
>
> @Nathan: Could you let me know if these patches work for you ? If so I'll
> commit them.
>
> Regards,
> Marek
>
>

I set /proc/cpu/alignment to 4 (raise bus error) and I get a bus error:

Program received signal SIGBUS, Bus error.
list_add_tail (new=0x29368, head=0x28819) at list-batman.c:68
68              __list_add( new, head->prev, (struct list_head *)head );
(gdb) l
63       * Insert a new entry before the specified head.
64       * This is useful for implementing queues.
65       */
66      void list_add_tail( struct list_head *new, struct
list_head_first *head ) {
67
68              __list_add( new, head->prev, (struct list_head *)head );
69
70              head->prev = new;
71
72      }
