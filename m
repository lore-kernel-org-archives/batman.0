Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Dec 2012 22:50:08 +0100
Message-ID: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5600896.nasFKpPoNi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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


--nextPart5600896.nasFKpPoNi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I am here to think loud about the batman-adv way of dealing with patches. I 
think everybody knows how it works right now [1]. Patches will be accepted by 
Marek and applied on master (we ignore some exceptions for now). From time to 
time a new kernel is released, this is the time when next is used to create a 
new release which is more or less the stuff also in the released^W"next to be 
released" kernel. Now all the stuff in master is merged into next and Antonio 
will use the stuff in next to create pull requests for David S. Miller. In 
case he accepts it in net-next (this isn't as easy as it sounds), this stuff 
will be part of the next+1 kernel.

This concept of "let everything wait in master until it is smells funny" 
worked perfectly in the past and helped a lot to organize some things. But it 
seems more and more problematic to continue to work with it because David S. 
Miller isn't the most easy person and therefore a lot of things got pushed 
back or got rejected.

So, what happens when something gets rejected or has to be reworked? Yes, some 
people have to run around and do a lot of magic. These things will end up in 
next (because this is were Antonio is working when he sends patches to David) 
and all the new stuff in master has to be rebased later on top of the new 
things in next [did I just loose most of my audience or is this snoring coming 
out of my PC?].

To make it short: An extra release cycle waiting time for feature patches is 
added and creates an extra burden for the involved maintainers because they 
have to rebase/revert/move/... patches when something unexpected happens (or 
we can say: "when David happens"). I will just remind everyone of the DAT fun.

The big question is: Is this extra waiting time for new feature patches really 
useful in the current situation and does batman-adv benefit from it in a 
special/irreplaceable way?

My personal observation is rather negative. Most problems are detected by 
people using the release and by people checking the patches (on the 
b.a.t.m.a.n. mailing list and on netdev... this includes "i am really really 
angry about what you did" David). But of course, my impressions could be 
slightly biased. I think Antonio can give more insights about it because he 
has to squash all the stuff together.

Here just a calculation for a new feature patch:
 * Send to b.a.t.m.a.n@lists.open-mesh.org at the beginning of the first month
 * accepted by Marek in the middle of the first month (had to be resent or so)
 * will be part of next in the middle of the third month
 * will be sent to David in the middle of the third month (uh, fast Antonio)
 * will be send to Linus by David at the the beginning of the fifth month
 * will be released as a separate kernel module in the middle of the fifth
   month
 * will be released in a kernel at the beginning of the seventh month

Or it could easily happen that the author of the patches get a late "sry, it 
will not be accepted" in months three-five by David. Of course, it can also 
happen after month five, but this is rather unlikely because it already passed 
the fuzzy Heimdall reincarnation David.

Antonio already showed that he can handle adhoc pull requests very well. 
Therefore, the idea would be to remove the two month extra waiting time. Here 
are just two random branch names:

* next - new patches are excepted here - so it is something like net-next for
  batman-adv. Antonio will gather some patches and then sent them to David.
  Davids reaction will come heavy and hard... but the effort for an reaction
  is reduced.
* master - bugfix gathering place. So it is like net for batman-adv. Patches
  will end up really fast in Linus' tree.

But I would still say it is a good idea to create releases from next because 
more people will test it and therefore it is easier to get bugfixes to Linus' 
instead through the stable queue. .1 releases from master can still be created 
when necessary.

So, why bringing this up now? We currently have 12 Patches in master and Linux 
3.7 will be released soon. So switching the patch strategy will not break 
loose hell. And as a nice side effect: it is not too tragic when 
C.A.T.W.O.M.A.N. is not merged right now.

But what would it mean for the next release? Hm, the next release would be 
created from next, but then we propably have to use some tricks. Right now 
master is too far ahead because it has the role of next+1. We would have to 
move the patches to next (simple merge) and reset master to the release.

Further .0 releases would just be made on next and then master merges the 
release. Additional fixes in master can "simply" be merged in next.

Let the fight begin...

Kind regards,
	Sven

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Release-todo?version=133
--nextPart5600896.nasFKpPoNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQvnAQAAoJEF2HCgfBJntGbYwP+gNA0U5r6oG9c7qst2Y28VC2
5uZ5sK5XmxPPoGHQsbUK+Sd4wERalCYBdwyqu/UdwWb9d/htn8Ao/oLv93U+2+Cu
QHmcbcOlJlzXfgRw49JL10k1h6H3eBGjijadC0CQ0eQjG+XCNUYd42CRNzUL3V9s
NqyH1jj32DmmOpmv2euwz8m2nOCrRQbFVsk+L3+VVhlRhd/P87StMDFDZ0MUy7ny
etVRh1DI+u9f8RRZqKN+vXdXk7gYdeQtfWkmdaF46TiFNIfEYFTyK3VmYpG14L0J
oQ8UaBSQF1QXVtXAU4FC4AeJJiz8qEWTrpFmL6ZLVZxOtuEPNYdQGGT9CGeWAE1j
2JlQvZZWF9PA8BMTWt66payvR1nC7qQfr/Lk49A11aU6e0m2h7UI0cbnVga5ditH
rmg+Rxzy0mC6tNCb3EvPTdGjcRqpkcOITfqqW3aHYwCl1GepVwVYWbDYw6Yo6D/H
VqdJWptheedidUs0+LgoZhkxRQXIdQPKXvwfdKrE7zwk8hc/+li15gKAWTVjlmEc
Q21KMHkAWDFlBQgHlCId2DPpklyUS3dEUn2BUaP0nbw3fFIV9JLANskWmmGCB+rV
gEkWmxDyx0LTajcobmXpsRJyHFGK9/Qr+PPyleJYhSmAtZwnK7vQc59uWWLEjStn
ID1IvkWBE6yrHjVkuhr0
=H1uB
-----END PGP SIGNATURE-----

--nextPart5600896.nasFKpPoNi--

