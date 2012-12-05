Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Dec 2012 10:45:19 +0100
Message-ID: <6077188.nvBcCfzM5C@bentobox>
In-Reply-To: <20121204230126.GZ27828@ritirata.org>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121204230126.GZ27828@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1376232.UsqiQGsbYH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1376232.UsqiQGsbYH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 05 December 2012 00:01:26 Antonio Quartulli wrote:
[...]
> > The big question is: Is this extra waiting time for new feature patches
> > really useful in the current situation and does batman-adv benefit from
> > it in a special/irreplaceable way?
> 
> the added value I see in having this extra time is the that we can spend
> some days in testing it, running it on nodes and trying to find bugs. But,
> to be honest, I don't know if out there we have people really doing this on
> a daily/weekly basis.

Yes, but adding extra time isn't it. Testing and debugging would be an 
important part.. but is it done in a way that it pays for the extra pain when 
David is doing his monkey dance?
 
> > My personal observation is rather negative. Most problems are detected by
> > people using the release and by people checking the patches (on the
> > b.a.t.m.a.n. mailing list and on netdev... this includes "i am really
> > really angry about what you did" David). But of course, my impressions
> > could be slightly biased. I think Antonio can give more insights about it
> > because he has to squash all the stuff together.
> 
> well, if I got you correctly the problem here is "only" about time: with the
> current method we "wait" more time before sending patches upstream, while
> in your suggestion we will immediately (well we could still wait some days
> in order to let the build tests do their optimum job and double check the
> code - because yes, I re-read each and every patch before sending them to
> David..strange eh?
> :D).
> 
> So, you would like a mac80211 like process, I think.

I am not 100% sure about the mac80211, but it looks at least like it. But "let 
them wait for some days" is still a good idea.

> > Here just a calculation for a new feature patch:
> >  * Send to b.a.t.m.a.n@lists.open-mesh.org at the beginning of the first
> >  month * accepted by Marek in the middle of the first month (had to be
> >  resent or so) * will be part of next in the middle of the third month
> >  * will be sent to David in the middle of the third month (uh, fast
> >  Antonio)
> >  * will be send to Linus by David at the the beginning of the fifth month
> >  * will be released as a separate kernel module in the middle of the fifth
> >  
> >    month
> >  
> >  * will be released in a kernel at the beginning of the seventh month
> 
> you meant weeks here? It sounds like a birth :)

No, month like in "30 days of night". Lets use an example. Please search for 
"Add the backbone gateway list to debugfs" on the mailing list. It should be 
from 2012-06-14. It will be included in the kernel released in ~1 week. My 
guess is 2012-12-10 (so missed the "beginning of the seventh month" only by 
some days). It was send by you to David on 2012-08-23. So it was 
beginning/middle of the third month.

It was just a random patch. I think I would be able to find better matching 
ones, but it should be understandable that my guess is not so extreme wrong.

> > Antonio already showed that he can handle adhoc pull requests very well.
> > Therefore, the idea would be to remove the two month extra waiting time.
> 
> I hope you still meant weeks here..or am I missing something?

No, month like in "twelve of them make a year".

> > Here
> > are just two random branch names:
> > 
> > * next - new patches are excepted here - so it is something like net-next
> > for> 
> >   batman-adv. Antonio will gather some patches and then sent them to
> >   David.
> >   Davids reaction will come heavy and hard... but the effort for an
> >   reaction
> >   is reduced.
> > 
> > * master - bugfix gathering place. So it is like net for batman-adv.
> > Patches> 
> >   will end up really fast in Linus' tree.
> 
> To be honest I thought the same some time ago, but I think there was a good
> reason to have it like it is now. I exposed my thoughts to Marek (? I can't
> really remember) and he explained me why it was nice to have a
> pre-incubation.

And my anti-thesis is "we don't gain much in this incubation phase, but create 
more problems later on". It worked fine in the past because we didn't know 
what to sent and picked special patches and moved stuff around (i still have 
bad dreams about the gateway stuff).

So, this anti-thesis should give us the opportunity to reassess the current 
strategy to work with patches.

> The advantage I see is that, if we make a mistake and we send a fix, we can
> still merge the original patch and fix together before sending it to David.
> I think this give us a not negligible margin of error. But maybe we became
> good enough to get rid of this margin? :)

Definitely, but I think you are the right person to answer whether this 
incubation time helped us or whether it is only a tiny amount of fixes and the 
rest of the fixes came from other things.

We have to keep in mind that we are not living in our own isolated universe, 
but that there are also other persons involved which use the other way of 
getting stuff in the kernel. And from time to time they collide with our stuff 
in master. And don't forget our hellkeeper David, the incontrovertible opinion 
himself.

Kind regards,
	Sven
--nextPart1376232.UsqiQGsbYH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQvxevAAoJEF2HCgfBJntGCH4P/1MNTPCAErJHpW0SRq7uUTDe
a+LEJCX4ugDElkPMgLXkszsJKXsyOkC9POOsLSiAMzOY8VH69XshAquEQv3zYF+e
map0vlyUbyewagHUdtxpftkcQBulgtliCPjiqaAW04L1nYa7tpICeKtbhOxC5ySp
LtlDJ1OG+oV23krjzpnIeSFE3bm5bElJKNzsp0XlKex1xGZm/blFLtYYvhSdyZim
kvh73M15vW4ltUl2igL1I/mO/qiaAQ2fcIUbhpKysIX8c0NIy7SSh1RSTIrFjk4/
SBh6QqEi8a7IeYUMLNBVWHOTebTtTpJyGxdGMBSDTFYupB+EKX8ZZLsn4ex8aNwl
xeCfHMT+o7LxCInlLxqj9leMqBNhnCcpWvStq7zdmt1L8YBitMzkgrli8SdA7k30
X9KPdIV5gTalutPYo7z6rnuI8TqXvS3O29JbOwPs1zYvCQjeeF6+4dj6eMoT5gfU
IvcTS0fi7+7zSMN0x5nfET9NRqdjOsMv/IGF4KG8cPDcdFgfgBBZpc5XQwtSHZbw
9D3TTYcce3CpnUHlvRflJIt/I5hqzQOqosLYqNsghQKoV0shEjP42vHdjbluStPw
dQwtRNL4u54FTSAC/1ORox2OoTL2uWpDI3sQU3ZF4wYZa4pzYF2jBIpJAhkC9bK2
WPlT59LME2lxnCmVz4T4
=GOuG
-----END PGP SIGNATURE-----

--nextPart1376232.UsqiQGsbYH--

