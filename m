Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Aug 2018 09:40:40 +0200
Message-ID: <1578855.qUiCBR2Cxb@sven-edge>
In-Reply-To: <2018081310240755548768@mail.sim.ac.cn>
References: <2791173.mX5NbDZpiX@sven-edge>
 <2018081310240755548768@mail.sim.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5442372.lcDNdbP7x8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Paper "Performance Evaluation of BATMAN-adv
 Wireless Mesh Network Routing Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "ligang.liu@mail.sim.ac.cn" <ligang.liu@mail.sim.ac.cn>
Cc: liujp <liujp@mail.sim.ac.cn>, qianhw <qianhw@mail.sim.ac.cn>, zhuj <zhuj@mail.sim.ac.cn>, "b. a. t. m. a. n" <b.a.t.m.a.n@lists.open-mesh.org>, kekegai <kekegai@smart-com.org>, TPII@ieee.org

--nextPart5442372.lcDNdbP7x8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 13. August 2018 04:24:08 CEST ligang.liu@mail.sim.ac.cn wrote:
[...]
> I'm so sorry for late reply, because I was in vocation last week.

No problem. But please change your reply style [2]. It is not very helpful 
when I first have to open my old mail to find out what you've added to the 
text and what was my original text :)

 
> Thank you very much for your concern on our work.
> 
> First of all, I have to say that the batman-adv V has performed very good in our recent tests.
> The main reason why it performed poor when we tested it  is the cfg80211 bug.
> When we made the test in Jan. we did not know about the cfg80211 uninitialization bug.
> We never thought of this kind of bug at that time, which is far beyond our scope.

Thanks for checking that. In the light of this and the other problems 
mentioned in my mail, it would be a good idea to retract the paper with the 
wrong information and revisit the topic with a new paper. I would be really 
interested in your results and the overhead comparison - but when comparing 
the different B.A.T.M.A.N. algorithm versions instead of bugs in other 
components.

This paper now could cause problems when other research use it as base for 
their own research - not noticing that this paper is flawed.

@kekegai@smart-com.org: Are you handling the retraction of CSCloud/EdgeCom 2018
conference papers [1]?

> I noticed this problem in the mail-list until in June.
> 
> Recently, I tried to fix the bug by modified the cfg80211 source code, ref https://patchwork.kernel.org/patch/10449857/ 
[...]
> Some tests have revealed that V has very good performance, at least not bad than IV.
> We will report our results after more careful tests.

Thanks


> Here is my response of your questions.
> 
> ************************************************************************************** 
> * What is OpenWrt 1703? (you've referenced a batman-adv config tutorial here 
>   and there is no such version as OpenWrt 1703)
> 
> ANS: 
> The base OpenWrt we used was built near in Sep.  2017, with
> git clone https://git.lede-project.org/source.git
> 
> I think the OpenWrt version should be LEDE 17.01.03

No, this would *not* result in LEDE 17.01.3 (released in Oct 3, 2017) - 
because you would have to specify the correct branch branch (actually the 
correct tag). The work on the stable versions v17.01.x was separated from the 
rest of the development with the branch created on on 2017-01-16. And your
commands will neither use the separate branch or the actual commit - it will 
just use whatever master is at that time. Rather bad when somebody wants to 
understand how to reproduce the results of your experiment.

Please make sure in your revisited paper that you make correct 
statements about the used software (LEDE vs. OpenWrt, git tags or actual git 
version's, applied patches, used feed versions, ...). Btw. there was just an 
actual OpenWrt release (after v15.05.1): 18.06.0 [3].

And also make sure that you're references are actually about the software. 
Right now your paper makes wrong statements about that kind of stuff.

* don't call it OpenWRT when it is LEDE
* don't name it 1703 when there is no such version and you've actually used 
  the development branch
* don't add a reference for OpenWRT 1703 which is then pointing to an 
  unrelated config tutorial on open-mesh.org

Having these incorrect statements in your paper doesn't make it look like it
is of high quality. And this also causes problems when other try to use your 
paper as base for their own research.

> **************************************************************************************
> * When did you want to contact the authors of the B.A.T.M.A.N. V 
>   implementation in batman-adv about your findings?
> 
> ANS: 
> I have tried to contact the community by sending a email to the mail-list,
> with a title "What's the exact definition of expected_throughput in BATMAN-ADV V?".
> In that email, I described my concern that the value of the expected_throughput was confused,
> and asked for help.
> 
> Unfortunately there are no response from there.

There was no such mail on the mailing list [4]. Please make sure that you 
followed our requirements for this list [5] (no HTML mails). And please use 
shorter, more concrete subjects than that.

But it seems that you never contacted the batman-adv developers via the 
mailing list about the other problems.

> **************************************************************************************
> * How did you solve the cfg80211 bug which returns uninitialized (random)
>   data when asked for the expected throughput of a station? Maybe you remember 
>   that the expected throughput is *the value* which B.A.T.M.A.N. V needs to 
>   calculate routes.
> 
> ANS:
> Our test was done in Jan. 2018 and the paper was submitted in Feb. 2018.
> At that time, I even had not realized that the problem of expected_throughput
> was from cfg80211 bug.

So your paper therefore (without you noticing) doesn't compare B.A.T.M.A.N. IV 
vs. B.A.T.M.A.N. V but still tries to establish the narrative that 
B.A.T.M.A.N. V is worse. 


> **************************************************************************************
> * What batman-adv version was used?
> 
> ANS:
> I think the version of batman-adv is 2017.3
> because the source file in OpenWrt named as:
> batman-adv-2017.3
> batctl-2017.3

This already shows that you did not use LEDE 17.01.3 - because this version 
did never include that particular batman-adv release. You were more likely on 
some random LEDE development branch commit.

> 
> **************************************************************************************
> * Did you use the openwrt-routing feed (which exact version) for
>   batctl+batman-adv or how did you build it?
> 
> ANS:
> Here are the main scripts.
> git clone https://git.lede-project.org/source.git
> ./scripts/feeds update -a
> ./scripts/feeds install -a
> 
> make download V=s
> make V=99
> 
> At last I flushed the generated 2 files:
> lede-ar71xx-generic-uImage-lzma.bin
> lede-ar71xx-generic-root.squashfs

These instruction will result in different version depending on when you run 
them. Neither the used LEDE commit is specified here nor the used feed commit.

> **************************************************************************************
> * Did you generate graphs for the chosen best next hop and how it changes
>   over time in comparison to B.A.T.M.A.N. IV?
>  
> ANS:
> I had checked the route by batctl ping -R xxx.xxx.xxx.xxx
> Unfortunately, we did not record and compare the route between IV and V.

I am currently assuming that the chosen routes were wrong because of the 
cfg80211 bug [6]. Your brief tests with the fixed cfg80211 seem to suggest 
this but no way to check this now.

Kind regards,
	Sven

> [1] https://ieeexplore.ieee.org/document/8421863/
[2] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
[3] https://github.com/openwrt/openwrt/releases/tag/v18.06.0
[4] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/
[5] https://www.open-mesh.org/projects/open-mesh/wiki/MailingList
[6] https://patchwork.kernel.org/patch/10449857/
--nextPart5442372.lcDNdbP7x8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAltxNfgACgkQXYcKB8Em
e0aYlRAAwO7tURh8v9uI+e+2A6uM3LaL2qRwIx4fyfXQ0zN30VZyYQqIARcOzulE
5xCh5CH2Aoth8HU9KA5euGhtvSj+DdxYmqZpEMrhXt0eJvoKlMHtSPT5EfvGrn8P
YpZesbO/weZwsxLwbFthwdtcSoVI+j+yV//ln10Q+d1ViPx4bHGyi6FxmAlyAW99
JH3bZYoEsPDnwr+9pEaRgadsNxR3DX0r6E17I3ChQUIBqt1asfHsh3B6FtzWSD0h
9WHtOlphHcl4lBQk7YqY4cpSZDsVohW+Ai8nBPt0Cu0+CwrD1G/HFcyQcTLIHiry
1VnenKDjapom942kFhb7qriOcPk9SM3sjUfyvW3xhELZBDBOs0IgWC7FVLFxJKIX
Npj+tsSlTI/t1sXmaYBZTtpdgK7OoBIn0A3oyS9fqwjpc8jv1sX4h0v0uHsOVAAh
6Nz9G63L6uJRsbTI3cHLfGHH2nOd3BzNtTku/Qi5gEJC5gLVYUPSCMn1lnSBKQqq
SWfuOkK9BpX8YYSoyE4LOZ6grsQulv8VQuCmSae4UnC0UQKqZ66KJDI3CaLWGYvI
CRMju7tLbV0aoBt6Ik4NACngVyffn+eLuDusALqpKyLniI889Qk5b6/kUTeD9y4C
3/QBx1OPJ4LMM2CyHyTUd+Dj17ryyf+DgMoNW6vaBQPkZdFwbG4=
=scLv
-----END PGP SIGNATURE-----

--nextPart5442372.lcDNdbP7x8--



