Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: WARNING in mark_lock (3)
Date: Thu, 28 Nov 2019 10:03:13 +0100
Message-ID: <3691620.GRZi0niZ3p@sven-edge>
In-Reply-To: <CACT4Y+abQSWfiN16BwXFOBi+d3CFGk53oj+5+zZwQPbcYu-Rew@mail.gmail.com>
References: <0000000000009aa32205985e78b6@google.com>
 <1809369.KjlzdqruN6@sven-edge>
 <CACT4Y+abQSWfiN16BwXFOBi+d3CFGk53oj+5+zZwQPbcYu-Rew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3339975.5L7NHtn4j8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzkaller <syzkaller@googlegroups.com>, syzbot <syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, Jakub Kicinski <jakub.kicinski@netronome.com>, Jamal Hadi Salim <jhs@mojatatu.com>, =?utf-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, vinicius.gomes@intel.com, wang.yi59@zte.com.cn, Cong Wang <xiyou.wangcong@gmail.com>

--nextPart3339975.5L7NHtn4j8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 28 November 2019 09:54:15 CET Dmitry Vyukov wrote:
[...]
> > I was thinking more about rerunning the same bisect but tell it to assume
> > "crashed: general protection fault in batadv_iv_ogm_queue_add" as OK instead
> > of assuming that it is a crashed like the previous "crashed: WARNING in
> > mark_lock". Just to get a non-bogus bisect result. Or try to rerun the
> > bisect between 40e220b4218b and 89d57dddd7d319ded00415790a0bb3c954b7e386
> 
> But... but this done by a program. What do you mean by "tell it"?

Sorry that I asked about what the infrastructure around syzbot can do and
how the interaction with it looks like.

Kind regards,
	Sven
--nextPart3339975.5L7NHtn4j8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl3fjVEACgkQXYcKB8Em
e0ajQhAAvetvCCehY5SmHsrLLKW7/YkVm3Ez3oqtbu/VCn8TEvau5PVt48ojQYmu
zOIZAs05i4JRI1WHZXyrAzPF3CI4juDdFCwOibiPDzCU2C3qD5s2AsZfxK22iPUt
dkBhW19Cq115ZgcOmerAor0nLkRkglYwoAEg6j+edtXUU3JYQG6PSGICN1NMGhmY
Q1jcXAGR1Hm+2SbR1sBBCflQHt8E6/wURkeqrvV82AcRSO3sPqQBWSEZ7QzIe3mc
oh0v4o5xZQMqppDByKmS9kZ5kRPH0yQid9l/KU4yGAQ8IDIZRKJGSHbpdOSGHNB4
9Wc3SR04lmn8WhwRBE8vpB/6n8cAq0mAv/kTa6pEYzjY499z8BjEkkAh9ggOuxLQ
AOb4dpu0L+wyXP/vLhUKJI+KWAJ+OOJoAVxNXh6HvhQRpShpTN/7+o1AVyRXLlBZ
bdjxVh3McRWvn8KYat3DtkON90uQRCZ9ufyTXcIPKkTiqQuT/UpwY0fNe3kjYfpK
pd5dyM86JWGxd39ramOhFSBQyNUAmJ+9pY2uVypbSABbbyIlqerGqzRSvgxoynNN
UrrZN3MVBCouMxM9+ES7L63jUg8JQQdAwr4RoisEyGLSPsstEnOd6PWYdsk6WYA2
kDoKPp9EjAeGEb7qH+IbXSm73qP2xX+rBBjfcTn/1CHCkgAPvTg=
=lHZm
-----END PGP SIGNATURE-----

--nextPart3339975.5L7NHtn4j8--



