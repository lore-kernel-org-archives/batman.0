MIME-Version: 1.0
In-Reply-To: <200906012135.22488.sven.eckelmann@gmx.de>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200906011844.15664.sven.eckelmann@gmx.de>
	<4313f3060906011103q21b32600nf99f8607bd01045c@mail.gmail.com>
	<200906012135.22488.sven.eckelmann@gmx.de>
Date: Mon, 1 Jun 2009 16:50:36 -0500
Message-ID: <4313f3060906011450i3b5bef03j73d1b9613bddf6f6@mail.gmail.com>
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

On Mon, Jun 1, 2009 at 2:35 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wrote:
> Ok, I think I see the problem. The malloc returned a valid aligned adress.
> list_add_tail will get a pointer to an element in hna_global_entry. This
> structure is packed and all operations on it should be non-alignment safe. If
> you look at it further you will notice that orig_list is at position 9
> (assuming 4 bytes for a pointer) - which will not be aligned to 4 bytes of
> course.....
> And here comes the problem: the compiler will only do the safe operations on
> non-aligned data if it knows that it is not alignent. Since a cast is done by
> calling list_add_tail it will not know that this parameter is not aligned and
> the non-alignment bug will occur.
>
> So my question to marek: Is it really needed to have "struct hna_global_entry"
> packed in hna.h:57? If not then we should remove it and this problem should be
> gone. And what is with "struct hna_element".
>
> Thank you for your work, Nathan :)

You are welcome, thanks for your help.

The crashing of batgat on unloading turns out to be socket 4306 not
being ready to be reused yet.
I worked around this by using:
batmand -c -r 0 ; sleep 1 ; batmand -c -g 11000
and
batmand -c -g 0 ; sleep 1 ; batmand -c -r 2

Marek helped figure that out on irc.
