Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200909291814.53591.sven.eckelmann@gmx.de>
References: <200909031406.49008.lindner_marek@yahoo.de>
	<200909291719.37794.lindner_marek@yahoo.de>
	<5161afcd0909290856w41dc1d10l3b109c2e68155f70@mail.gmail.com>
	<200909291814.53591.sven.eckelmann@gmx.de>
Date: Tue, 29 Sep 2009 23:39:21 -0600
Message-ID: <5161afcd0909292239h63defcc8o6d55b3b9cc1fbfd8@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] mailing list migration (was: development flow)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

>> I think that having two lists would be a hassle and a mistake. =C2=A0To
>> have two lists at one host might work, but one list at VGER and
>> another somewhere else could be counter-productive, as "internal"
>> communication would be constantly forwarded to the kernel list, and
>> relevant kernel traffic would have to be forwarded back to the
>> "internal" list. =C2=A0Think about that for a second. =C2=A0Eventually, =
we would
>> probably just drop one list.
>>
>> If one list is O(n), then two lists are O(n^2) for anyone who needs
>> both. =C2=A0I vote for one list, no matter where it's hosted.
> Don't understand the calculation as I would prefer + instead of * here, b=
ut
> this isn't the point (and if you would do program a bad matching algorith=
m
> here it is still O(M*N) ).
> Don't think that two lists are good without a good topic split. I see a r=
eason
> for -devel, -users and -announcements list in some projects, but not for =
a
> list for "kernel people" and for "other people".
...
> Haven't followed the whole discussion, but is it real such a big problem =
to
> change the mailing list address? OK, it shouldn't be done every week, but=
 this
> is done for a good reason. Just do an announcement on this list and creat=
e an
> auto reply (smtp failure notice with further information) when someone wr=
ites
> to the old list.

I agree with all of this.  My point is that multiple lists should at
least be hosted at the same place.  The topic split is a good point,
too; if there were two -devel lists, I think all of the developers
would eventually use the "kernel people" list exclusively.

> Maybe more interesting is the fact that if we can import old information =
into
> the new list. I think mailman stores everything in simple mboxes, or am I
> wrong?
> And also interesting if we can do backups of the data on vger and co.

Just looked at the VGER website, and they use majordomo.  I don't know
much about these things; can mailman data be imported to majordomo?  A
quick look around reveals no email addresses to contact them, other
than some that seem to be spambot honeypots.

What do we need in order to make a decision?  I would like to get this
transition happening soon so that real work can move forward.

Jacob
